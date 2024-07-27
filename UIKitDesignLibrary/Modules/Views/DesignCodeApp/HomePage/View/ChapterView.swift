//
//  ChapterView.swift
//  UIKitDesignLibrary
//
//  Created by charvin on 2024/7/13.
//

import Foundation
import UIKit
extension DesignCodeApp {
    class ChapterView: UIView, ViperView {
        var routeSource: UIViewController?
        var eventHandler: ViperPresenter?
        var dataSource: ViperPresenter?

        var chapterLabel = UILabel()
        var cards: UICollectionView?

        override init(frame: CGRect) {
            super.init(frame: frame)
            self.setupViews()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        func setupViews() {
            self.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
            self.setupLabelView()
            self.setupCards()
        }

        func setupLabelView() {
            self.addSubview(self.chapterLabel)
            self.chapterLabel.text = "CHAPTER 1: 12 SECTIONS"
            self.chapterLabel.textColor = UIColor(red: 40 / 255, green: 40 / 255, blue: 40 / 255, alpha: 1)
            self.chapterLabel.font = .systemFont(ofSize: 15, weight: .semibold)
            self.chapterLabel.numberOfLines = 0
            self.chapterLabel.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                self.chapterLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 50),
                self.chapterLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
                self.chapterLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
            ])
        }

        func setupCards() {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal

            let cards = UICollectionView(frame: .zero, collectionViewLayout: layout)
            cards.translatesAutoresizingMaskIntoConstraints = false
            cards.backgroundColor = .clear
            cards.showsHorizontalScrollIndicator = false
            cards.dataSource = self
            cards.delegate = self
            cards.register(ChapterCardsCell.self, forCellWithReuseIdentifier: "ChapterCardsCell")
            self.cards = cards

            guard let cards = self.cards else { return }
            self.addSubview(cards)
            NSLayoutConstraint.activate([
                cards.topAnchor.constraint(equalTo: self.chapterLabel.bottomAnchor, constant: 15),
                cards.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                cards.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                cards.heightAnchor.constraint(equalToConstant: 248)
            ])
        }
    }

    class ChapterCardsCell: UICollectionViewCell {
        let containerView = UIView()
        let imageContainerView = UIView()
        let imageView = UIImageView()
        let title = UILabel()
        let caption = UILabel()

        override init(frame: CGRect) {
            super.init(frame: frame)
            self.setupViews()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        func setupViews() {
            self.setupContainerViews()
            self.setupImageView()
            self.setupLabelView()
            self.setupCaptionView()
        }

        func setupContainerViews() {
            self.containerView.backgroundColor = .clear
            self.containerView.layer.cornerRadius = 14
            self.containerView.layer.shadowOpacity = 0.25
            self.containerView.layer.shadowOffset = CGSize(width: 0, height: 10)
            self.containerView.layer.shadowRadius = 20
            self.containerView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(self.containerView)

            NSLayoutConstraint.activate([
                self.containerView.topAnchor.constraint(equalTo: self.topAnchor),
                self.containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                self.containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                self.containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])

            self.imageContainerView.backgroundColor = .clear
            self.imageContainerView.layer.cornerRadius = 14
            self.imageContainerView.clipsToBounds = true
            self.imageContainerView.translatesAutoresizingMaskIntoConstraints = false
            self.containerView.addSubview(self.imageContainerView)

            NSLayoutConstraint.activate([
                self.imageContainerView.topAnchor.constraint(equalTo: self.containerView.topAnchor),
                self.imageContainerView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor),
                self.imageContainerView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor),
                self.imageContainerView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor)
            ])
        }

        func setupImageView() {
            self.imageView.contentMode = .scaleAspectFill
            self.imageView.translatesAutoresizingMaskIntoConstraints = false
            self.imageContainerView.addSubview(self.imageView)

            NSLayoutConstraint.activate([
                self.imageView.topAnchor.constraint(equalTo: self.imageContainerView.topAnchor),
                self.imageView.leadingAnchor.constraint(equalTo: self.imageContainerView.leadingAnchor),
                self.imageView.trailingAnchor.constraint(equalTo: self.imageContainerView.trailingAnchor),
                self.imageView.bottomAnchor.constraint(equalTo: self.imageContainerView.bottomAnchor)
            ])
        }

        func setupLabelView() {
            self.title.textColor = .white
            self.title.font = .systemFont(ofSize: 32, weight: .semibold)
            self.title.numberOfLines = 3
            self.title.translatesAutoresizingMaskIntoConstraints = false
            self.containerView.addSubview(self.title)

            NSLayoutConstraint.activate([
                self.title.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 20),
                self.title.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 20),
                self.title.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -20)
            ])
        }

        func setupCaptionView() {
            self.caption.textColor = .white
            self.caption.font = .systemFont(ofSize: 17)
            self.caption.numberOfLines = 3
            self.caption.translatesAutoresizingMaskIntoConstraints = false
            self.containerView.addSubview(self.caption)

            NSLayoutConstraint.activate([
                self.caption.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -20),
                self.caption.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 20),
                self.caption.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -20)
            ])
        }
    }
}

extension DesignCodeApp.ChapterView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let dataSource = self.dataSource as? DesignCodeAppHomePageChapterCardsDataSource else { return 0 }
        return dataSource.getSectionsNum()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let dataSource = self.dataSource as? DesignCodeAppHomePageChapterCardsDataSource else { return UICollectionViewCell() }
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "ChapterCardsCell",
            for: indexPath
        ) as? DesignCodeApp.ChapterCardsCell else {
            return UICollectionViewCell()
        }
        cell.title.text = dataSource.getSectionTitle(for: indexPath.item)
        cell.caption.text = dataSource.getSectionCaption(for: indexPath.item)
        cell.imageView.image = UIImage(named: dataSource.getSectionImage(for: indexPath.item))
        cell.layer.transform = self.animateCell(cellFrame: cell.frame)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let eventHandler = self.eventHandler as? DesignCodeAppHomePageViewEventHandler else { return }
        eventHandler.chapterTapped(at: indexPath.item)
    }
}

extension DesignCodeApp.ChapterView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 304, height: 248)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
}

extension DesignCodeApp.ChapterView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let collectionView = scrollView as? UICollectionView {
            for cell in collectionView.visibleCells {
                if let chapterCell = cell as? DesignCodeApp.ChapterCardsCell {
                    if  let indexPath = collectionView.indexPath(for: chapterCell),
                        let attributes = collectionView.layoutAttributesForItem(at: indexPath) {
                        let cellFrame = collectionView.convert(attributes.frame, to: self.routeSource?.view)
                        let translationX = cellFrame.origin.x / 5
                        chapterCell.imageView.transform = CGAffineTransform(translationX: translationX, y: 0)
                        chapterCell.layer.transform = self.animateCell(cellFrame: cellFrame)
                    }
                }
            }
        }
    }

    func animateCell(cellFrame: CGRect) -> CATransform3D {
        let angleFromX = Double((-cellFrame.origin.x) / 11)
        let angle = CGFloat((angleFromX.truncatingRemainder(dividingBy: 360) * Double.pi) / 180.0)
        var transform = CATransform3DIdentity
        transform.m34 = -1.0 / 1000
        let rotation = CATransform3DRotate(transform, angle, 0, 1, 0)

        var scaleFromX = (1000 - (cellFrame.origin.x - 200)) / 1000
        let scaleMax: CGFloat = 1.0
        let scaleMin: CGFloat = 0.8
        if scaleFromX > scaleMax {
            scaleFromX = scaleMax
        }
        if scaleFromX < scaleMin {
            scaleFromX = scaleMin
        }

        let scale = CATransform3DScale(CATransform3DIdentity, scaleFromX, scaleFromX, 1)

        return CATransform3DConcat(rotation, scale)
    }
}
