import Foundation
import UIKit

extension DesignCodeApp {
    class ContentPageViewController: UIViewController, ViperView {
        var eventHandler: ViperPresenter?
        var dataSource: ViperPresenter?

        var routeSource: UIViewController? {
            return self
        }

        let scrollView = UIScrollView()
        let heroView = ContentPageHeroView()
        let closeBlurView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        let closeButton = UIButton()

        override func viewDidLoad() {
            super.viewDidLoad()
            self.setupViews()
        }

        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            updateScrollViewContentSize()
        }

        func setupViews() {
            self.view.backgroundColor = .white
            self.view.addSubview(self.scrollView)
            self.scrollView.translatesAutoresizingMaskIntoConstraints = false
            self.scrollView.contentInsetAdjustmentBehavior = .never
            NSLayoutConstraint.activate([
                self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
                self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])

            self.scrollView.addSubview(self.heroView)
            self.heroView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                self.heroView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
                self.heroView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
                self.heroView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
                self.heroView.heightAnchor.constraint(equalToConstant: 420)
            ])

            self.view.addSubview(self.closeBlurView)
            self.closeBlurView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                self.closeBlurView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
                self.closeBlurView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                self.closeBlurView.widthAnchor.constraint(equalToConstant: 36),
                self.closeBlurView.heightAnchor.constraint(equalToConstant: 36)
            ])
            self.closeBlurView.layer.cornerRadius = 12
            self.closeBlurView.layer.masksToBounds = true

            self.closeBlurView.contentView.addSubview(self.closeButton)
            self.closeButton.setImage(UIImage(named: "Action-Close"), for: .normal)
            self.closeButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                self.closeButton.topAnchor.constraint(equalTo: self.closeBlurView.topAnchor),
                self.closeButton.leadingAnchor.constraint(equalTo: self.closeBlurView.leadingAnchor),
                self.closeButton.trailingAnchor.constraint(equalTo: self.closeBlurView.trailingAnchor),
                self.closeButton.bottomAnchor.constraint(equalTo: self.closeBlurView.bottomAnchor)
            ])
            self.closeButton.addTarget(self, action: #selector(self.closeButtonTapped), for: .touchUpInside)
        }

        func updateScrollViewContentSize() {
            let contentHeight = heroView.frame.height + 30 + heroView.contentLabel.intrinsicContentSize.height
            self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: contentHeight)
        }

        @objc func closeButtonTapped() {
            self.dismiss(animated: true, completion: nil)
            guard let eventHandler = self.eventHandler as? DesignCodeApp.ContentPagePresenter else { return }
            eventHandler.closeButtonTapped()
        }
    }

    class ContentPageHeroView: UIView {
        let backgroundImageView = UIImageView()
        let titleLabel = UILabel()
        let captionLabel = UILabel()
        let contentLabel = UILabel()
        let progressBlurView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        let progressView = UILabel()

        override init(frame: CGRect) {
            super.init(frame: frame)
            self.setupViews()
        }

        required init?(coder: NSCoder) {
            super.init(coder: coder)
            self.setupViews()
        }

        func setupViews() {
            self.addSubview(self.backgroundImageView)
            self.backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
            self.backgroundImageView.contentMode = .scaleAspectFill
            self.backgroundImageView.image = UIImage(named: "ios11")
            NSLayoutConstraint.activate([
                self.backgroundImageView.topAnchor.constraint(equalTo: self.topAnchor),
                self.backgroundImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                self.backgroundImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                self.backgroundImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])

            self.addSubview(self.titleLabel)
            self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
            self.titleLabel.text = "Learn IOS 11 Design"
            self.titleLabel.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
            self.titleLabel.textColor = .white
            self.titleLabel.numberOfLines = 0
            NSLayoutConstraint.activate([
                self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 66),
                self.titleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                self.titleLabel.widthAnchor.constraint(equalToConstant: 262)
            ])

            self.addSubview(self.captionLabel)
            self.captionLabel.translatesAutoresizingMaskIntoConstraints = false
            self.captionLabel.text = "Learn Colors, Typography and Layout for IOS"
            self.captionLabel.font = UIFont.systemFont(ofSize: 17)
            self.captionLabel.textColor = UIColor.white.withAlphaComponent(0.8)
            self.captionLabel.numberOfLines = 0
            NSLayoutConstraint.activate([
                self.captionLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                self.captionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30),
                self.captionLabel.widthAnchor.constraint(equalToConstant: 264)
            ])

            self.addSubview(self.contentLabel)
            self.contentLabel.translatesAutoresizingMaskIntoConstraints = false
            self.contentLabel.font = UIFont.systemFont(ofSize: 19)
            self.contentLabel.textColor = .darkGray
            self.contentLabel.numberOfLines = 0
            NSLayoutConstraint.activate([
                self.contentLabel.topAnchor.constraint(equalTo: self.backgroundImageView.bottomAnchor, constant: 30),
                self.contentLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                self.contentLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20)
            ])

            self.addSubview(self.progressBlurView)
            self.progressBlurView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                self.progressBlurView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
                self.progressBlurView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                self.progressBlurView.heightAnchor.constraint(equalToConstant: 36)
            ])

            self.progressBlurView.contentView.addSubview(self.progressView)
            self.progressView.translatesAutoresizingMaskIntoConstraints = false
            self.progressView.text = "1/12"
            self.progressView.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
            self.progressView.textColor = .white.withAlphaComponent(0.7)
            NSLayoutConstraint.activate([
                self.progressView.centerYAnchor.constraint(equalTo: self.progressBlurView.centerYAnchor),
                self.progressView.centerXAnchor.constraint(equalTo: self.progressBlurView.centerXAnchor)
            ])

            NSLayoutConstraint.activate([
                self.progressBlurView.widthAnchor.constraint(equalTo: self.progressView.widthAnchor, constant: 20)
            ])

            self.progressBlurView.layer.cornerRadius = 12
            self.progressBlurView.layer.masksToBounds = true
        }
    }
}
