import Foundation
import UIKit
import AVKit
extension DesignCodeApp {
    class HomePageViewPresenter:
        ViperPresenter,
        DesignCodeAppHomePageViewEventHandler {
        weak var view: ViperView?
        var wireframe: ViperWireframe?
        var interactor: ViperInteractor?

        func chapterTapped(at index: Int) {
            guard let interactor = interactor as? DesignCodeApp.HomePageInteractor else { return }
            guard let wireframe = wireframe as? DesignCodeApp.HomePageWireframe else { return }
            guard let view = view as? UIViewController else { return }
            let section = interactor.dataSevice?.sections[index]
            wireframe.showContent(title: section?.title ?? "",
                                  caption: section?.caption ?? "",
                                  content: section?.body ?? "",
                                  image: section?.image ?? "",
                                  progress: "\(index + 1) / \(interactor.dataSevice?.sections.count ?? 0)"
            )
        }
        func playButtonTapped() {
            let urlString = "https://" +
                "player.vimeo.com/external/" +
                "235468301.hd.mp4?" +
                "s=e852004d6a46ce569fcf6ef02a7d" +
                "291ea581358e&profile_id=175"
            guard let url = URL(string: urlString) else { return }
            let player = AVPlayer(url: url)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player

            guard let view = view as? UIViewController else { return }
            view.present(playerViewController, animated: true) {
                player.play()
            }
        }
    }
}

extension DesignCodeApp.HomePageViewPresenter: DesignCodeAppHomePageChapterCardsDataSource {
    func getSectionsNum() -> Int {
        guard let interactor = interactor as? DesignCodeApp.HomePageInteractor else { return 0 }
        return interactor.dataSevice?.sections.count ?? 0
    }

    func getSectionTitle(for index: Int) -> String {
        guard let interactor = interactor as? DesignCodeApp.HomePageInteractor else { return "" }
        return interactor.dataSevice?.sections[index].title ?? ""
    }

    func getSectionCaption(for index: Int) -> String {
        guard let interactor = interactor as? DesignCodeApp.HomePageInteractor else { return "" }
        return interactor.dataSevice?.sections[index].caption ?? ""
    }

    func getSectionContent(for index: Int) -> String {
        guard let interactor = interactor as? DesignCodeApp.HomePageInteractor else { return "" }
        return interactor.dataSevice?.sections[index].body ?? ""
    }

    func getSectionImage(for index: Int) -> String {
        guard let interactor = interactor as? DesignCodeApp.HomePageInteractor else { return "" }
        return interactor.dataSevice?.sections[index].image ?? ""
    }
}

extension DesignCodeApp.HomePageViewPresenter: DesignCodeAppHomePageTestmonialDataSource {
    func getTestmonialNum() -> Int {
        guard let interactor = interactor as? DesignCodeApp.HomePageInteractor else { return 0 }
        return interactor.dataSevice?.testimonials.count ?? 0
    }
    
    func getTestmonialContent(for index: Int) -> String {
        guard let interactor = interactor as? DesignCodeApp.HomePageInteractor else { return "" }
        return interactor.dataSevice?.testimonials[index].text ?? ""
    }
    
    func getTestmonialFullName(for index: Int) -> String {
        guard let interactor = interactor as? DesignCodeApp.HomePageInteractor else { return "" }
        return interactor.dataSevice?.testimonials[index].name ?? ""
    }
    
    func getTestmonialJobDescription(for index: Int) -> String {
        guard let interactor = interactor as? DesignCodeApp.HomePageInteractor else { return "" }
        return interactor.dataSevice?.testimonials[index].job ?? ""
    }
    
    func getTestmonialAvatar(for index: Int) -> String {
        guard let interactor = interactor as? DesignCodeApp.HomePageInteractor else { return "" }
        return interactor.dataSevice?.testimonials[index].avatar ?? ""
    }
}
