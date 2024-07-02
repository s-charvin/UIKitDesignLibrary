//
//  File.swift
//  iosViews
//
//  Created by scw on 2024/2/4.
//

import UIKit

let apiKey = "7cd89ae71dc3a75ffbeb7425fb609e04"
typealias SearchAPICompletion = (Result<FlickrSearchResults, Flickr.APIError>) -> Void

class Flickr {
    enum APIError: Error {
        case unknownAPIResponse
        case generic
    }

    func searchFlickr(for searchTerm: String, completion: @escaping SearchAPICompletion) {
        guard let searchURL = flickrSearchURL(for: searchTerm) else {
            completion(Result.failure(Self.APIError.unknownAPIResponse))
            return
        }

        let searchRequest = URLRequest(url: searchURL)

        URLSession.shared.dataTask(with: searchRequest) { [weak self] data, response, error in
            guard
                let self = self,
                error == nil
            else {
                DispatchQueue.main.async {
                    completion(Result.failure(Self.APIError.generic))
                }
                return
            }

            guard
                response as? HTTPURLResponse != nil,
                let data = data
            else {
                DispatchQueue.main.async {
                    completion(Result.failure(Self.APIError.unknownAPIResponse))
                }
                return
            }

            self.parseResponse(searchTerm: searchTerm, data: data, completion: completion)
        }
        .resume()
    }
    private func parseResponse(
        searchTerm: String,
        data: Data,
        completion: @escaping SearchAPICompletion
    ) {
        do {
            let resultsDictionary = try parseJSON(data: data)
            processResults(resultsDictionary: resultsDictionary, searchTerm: searchTerm, completion: completion)
        } catch {
            handleParsingError(error, completion: completion)
        }
    }

    private func parseJSON(data: Data) throws -> [String: AnyObject] {
        guard let resultsDictionary = try JSONSerialization.jsonObject(with: data) as? [String: AnyObject] else {
            throw Self.APIError.unknownAPIResponse
        }
        return resultsDictionary
    }

    private func processResults(resultsDictionary: [String: AnyObject], searchTerm: String, completion: @escaping SearchAPICompletion) {
        guard let stat = resultsDictionary["stat"] as? String else {
            asyncCompletion(completion, with: .failure(Self.APIError.unknownAPIResponse))
            return
        }

        switch stat {
        case "ok":
            print("Results processed OK")
        case "fail":
            asyncCompletion(completion, with: .failure(Self.APIError.generic))
            return
        default:
            asyncCompletion(completion, with: .failure(Self.APIError.unknownAPIResponse))
            return
        }

        parsePhotos(resultsDictionary: resultsDictionary, searchTerm: searchTerm, completion: completion)
    }

    private func parsePhotos(resultsDictionary: [String: AnyObject], searchTerm: String, completion: @escaping SearchAPICompletion) {
        guard
            let photosContainer = resultsDictionary["photos"] as? [String: AnyObject],
            let photosReceived = photosContainer["photo"] as? [[String: AnyObject]]
        else {
            asyncCompletion(completion, with: .failure(Self.APIError.unknownAPIResponse))
            return
        }

        let flickrPhotos: [FlickrPhoto] = photosReceived.compactMap { photoDictionary in
            createFlickrPhoto(from: photoDictionary)
        }

        let searchResults = FlickrSearchResults(searchTerm: searchTerm, searchResults: flickrPhotos)
        asyncCompletion(completion, with: .success(searchResults))
    }

    private func createFlickrPhoto(from dictionary: [String: AnyObject]) -> FlickrPhoto? {
        guard
            let photoID = dictionary["id"] as? String,
            let farm = dictionary["farm"] as? Int,
            let server = dictionary["server"] as? String,
            let secret = dictionary["secret"] as? String
        else {
            return nil
        }

        let flickrPhoto = FlickrPhoto(photoID: photoID, farm: farm, server: server, secret: secret)
        guard let url = flickrPhoto.flickrImageURL() else { return flickrPhoto }
        guard let imageData = try? Data(contentsOf: url) else { return flickrPhoto }
        let image = UIImage(data: imageData)
        flickrPhoto.thumbnail = image
        return flickrPhoto
    }

    private func handleParsingError(_ error: Error, completion: @escaping SearchAPICompletion) {
        guard let apiError = error as? APIError else {
            asyncCompletion(completion, with: .failure(Self.APIError.generic))
            return
        }

        asyncCompletion(completion, with: .failure(apiError))
    }

    private func asyncCompletion(_ completion: @escaping SearchAPICompletion, with result: Result<FlickrSearchResults, APIError>) {
        DispatchQueue.main.async {
            completion(result)
        }
    }


    private func flickrSearchURL(for searchTerm: String) -> URL? {
        guard let escapedTerm = searchTerm.addingPercentEncoding(
            withAllowedCharacters: CharacterSet.alphanumerics
        ) else {
            return nil
        }

        let urlString = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&text=\(escapedTerm)&per_page=30&format=json&nojsoncallback=1"
        return URL(string: urlString)
    }
}
