import UIKit
import Foundation
extension DesignCodeApp {
    class HomePageViewController: UIViewController, ViperView {
        var eventHandler: ViperPresenter? {
            didSet {
                self.chapterView.eventHandler = self.eventHandler
                self.testMonialView.eventHandler = self.eventHandler
            }
        }
        var dataSource: ViperPresenter? {
            didSet {
                self.chapterView.dataSource = self.dataSource
                self.testMonialView.dataSource = self.dataSource
            }
        }

        var routeSource: UIViewController? {
            return self
        }
        
        let scrollView = UIScrollView()

        let heroView = HomePageHeroView()
        let bookView = BookView()
        let chapterView = ChapterView()
        let testMonialView = TestmonialViewController()

        override func viewDidLoad() {
            super.viewDidLoad()
            self.setupViews()
        }

        func setupViews() {
            self.view.backgroundColor = .systemBackground
            self.setupScrollView()
            self.setupHeroView()
            self.setupBookView()
            self.setupChapterView()
            self.setupTestMonialView()

            self.heroView.titleLabel.alpha = 0
            self.heroView.phoneImageView.alpha = 0
            self.heroView.playButtonView.alpha = 0

            UIView.animate(withDuration: 1) {
                self.heroView.titleLabel.alpha = 1
                self.heroView.phoneImageView.alpha = 1
                self.heroView.playButtonView.alpha = 1
            }

            self.heroView.playButtonImageView.addGestureRecognizer(
                UITapGestureRecognizer(
                    target: self,
                    action: #selector(self.playButtonTapped)
                )
            )

            self.bookView.isUserInteractionEnabled = true
            self.chapterView.isUserInteractionEnabled = true
            self.heroView.playButtonImageView.isUserInteractionEnabled = true
            self.heroView.playButtonView.isUserInteractionEnabled = true
            self.heroView.isUserInteractionEnabled = true
        }

        func setupScrollView() {
            self.view.addSubview(self.scrollView)
            self.scrollView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
                self.scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
                self.scrollView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
                self.scrollView.heightAnchor.constraint(equalTo: self.view.heightAnchor)
            ])
            self.scrollView.delegate = self
            self.scrollView.contentSize = CGSize(
                width: self.view.frame.width,
                height: 2000
            )
            self.scrollView.contentInsetAdjustmentBehavior = .never
        }

        func setupHeroView() {
            self.scrollView.addSubview(self.heroView)
            self.heroView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                self.heroView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
                self.heroView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
                self.heroView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
                self.heroView.heightAnchor.constraint(equalToConstant: 452)
            ])
        }

        func setupBookView() {
            self.scrollView.addSubview(self.bookView)
            self.bookView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                self.bookView.topAnchor.constraint(equalTo: self.heroView.bottomAnchor),
                self.bookView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
                self.bookView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
                self.bookView.heightAnchor.constraint(equalToConstant: 348)
            ])
        }

        func setupChapterView() {
            self.scrollView.addSubview(self.chapterView)
            self.chapterView.translatesAutoresizingMaskIntoConstraints = false
            self.chapterView.isUserInteractionEnabled = false
            NSLayoutConstraint.activate([
                self.chapterView.topAnchor.constraint(equalTo: self.bookView.bottomAnchor),
                self.chapterView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
                self.chapterView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
                self.chapterView.heightAnchor.constraint(equalToConstant: 380)
            ])
        }

        @objc private func playButtonTapped(_ sender: UITapGestureRecognizer? = nil) {
            guard let eventHandler = self.eventHandler as? DesignCodeAppHomePageViewEventHandler else {
                return
            }
            eventHandler.playButtonTapped()
        }

        func setupTestMonialView() {
            self.scrollView.addSubview(self.testMonialView.view)
            self.testMonialView.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                self.testMonialView.view.topAnchor.constraint(equalTo: self.chapterView.bottomAnchor),
                self.testMonialView.view.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
                self.testMonialView.view.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
                self.testMonialView.view.heightAnchor.constraint(equalToConstant: 524)
            ])
        }
    }
}

extension DesignCodeApp.HomePageViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY < 0 {
            self.heroView.transform = CGAffineTransform(translationX: 0, y: offsetY)
            //            self.heroView.playButtonImageView.transform = CGAffineTransform(translationX: 0, y: -offsetY / 3)
            self.heroView.playButtonView.transform = CGAffineTransform(translationX: 0, y: -offsetY / 3)
            self.heroView.titleLabel.transform = CGAffineTransform(translationX: 0, y: -offsetY / 3)
            self.heroView.phoneImageView.transform = CGAffineTransform(translationX: 0, y: -offsetY / 4)
            self.heroView.backgroundImage.transform = CGAffineTransform(translationX: 0, y: -offsetY / 5)
        }
    }
}
