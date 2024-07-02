//
//  HeroView.swift
//  UIKitDesignLibrary
//
//  Created by charvin on 2024/4/23.
//

import UIKit

class DesignCodeAppHeroView: UIView {
    let backgroundImage = UIImageView()
    let titleLabel = UILabel()
    let phoneImageView = UIImageView()
    let blurView = BlurView(effect: UIBlurEffect(style: .dark))
    let playButtonView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    let playButtonImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        self.backgroundColor = .systemBackground
        self.setupImageView()
        self.setupTitleLabel()
        self.setupPhoneImageView()
        self.setupBlurView()
        self.setupPlayButtonView()
    }

    func setupImageView() {
        self.addSubview(self.backgroundImage)
        self.backgroundImage.image = UIImage(named: "Home")
        self.backgroundImage.contentMode = .scaleAspectFill
        self.backgroundImage.clipsToBounds = true
        self.backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.backgroundImage.topAnchor.constraint(equalTo: self.topAnchor),
            self.backgroundImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.backgroundImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.backgroundImage.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    func setupTitleLabel() {
        self.addSubview(self.titleLabel)
        self.titleLabel.text = "Learn to design & code for iOS 11"
        self.titleLabel.font = UIFont.systemFont(ofSize: 36, weight: .semibold)
        self.titleLabel.textColor = .white
        self.titleLabel.numberOfLines = 0
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -77.5),
            self.titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -54),
            self.titleLabel.widthAnchor.constraint(equalToConstant: 160),
            self.titleLabel.heightAnchor.constraint(equalToConstant: 172)
        ])
    }

    func setupPhoneImageView() {
        self.addSubview(self.phoneImageView)
        self.phoneImageView.image = UIImage(named: "Art-iPhoneX")
        self.phoneImageView.contentMode = .scaleAspectFit
        self.phoneImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.phoneImageView.leadingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor, constant: 28.333),
            self.phoneImageView.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor, constant: 12.5),
            self.phoneImageView.widthAnchor.constraint(equalToConstant: 123),
            self.phoneImageView.heightAnchor.constraint(equalToConstant: 319)
        ])
    }

    func setupBlurView() {
        self.addSubview(self.blurView)
        self.blurView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.blurView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.blurView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.blurView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.blurView.heightAnchor.constraint(equalToConstant: 128)
        ])
    }

    func setupPlayButtonView() {
        self.playButtonImageView.image = UIImage(named: "Action-Play")
        self.playButtonImageView.contentMode = .scaleAspectFit
        self.playButtonImageView.translatesAutoresizingMaskIntoConstraints = false

        self.playButtonView.layer.cornerRadius = 25
        self.playButtonView.clipsToBounds = true
        self.playButtonView.translatesAutoresizingMaskIntoConstraints = false
        self.playButtonView.contentView.addSubview(self.playButtonImageView)

        self.addSubview(self.playButtonView)

        NSLayoutConstraint.activate([
            self.playButtonView.centerXAnchor.constraint(equalTo: self.phoneImageView.centerXAnchor),
            self.playButtonView.centerYAnchor.constraint(equalTo: self.phoneImageView.centerYAnchor, constant: -12.5),
            self.playButtonView.widthAnchor.constraint(equalToConstant: 50),
            self.playButtonView.heightAnchor.constraint(equalToConstant: 50),
            self.playButtonImageView.topAnchor.constraint(equalTo: self.playButtonView.topAnchor),
            self.playButtonImageView.bottomAnchor.constraint(equalTo: self.playButtonView.bottomAnchor),
            self.playButtonImageView.leadingAnchor.constraint(equalTo: self.playButtonView.leadingAnchor),
            self.playButtonImageView.trailingAnchor.constraint(equalTo: self.playButtonView.trailingAnchor)
        ])
    }
}


class BlurView: UIVisualEffectView {
    let stackView = UIStackView()
    let watchStack = UIStackView()
    let watchLabel = UILabel()
    let hoursLabel = UILabel()
    let videoLessonsLabel = UILabel()
    let progressView = UIView()
    let downloadStack = UIStackView()
    let downloadLabel = UILabel()
    let gbLabel = UILabel()
    let sourceFilesLabel = UILabel()
    let searchStack = UIStackView()
    let searchLabel = UILabel()
    let itemCountLabel = UILabel()
    let wordsImagesLabel = UILabel()

    var stackViewWidthConstraint: NSLayoutConstraint?

    override init(effect: UIVisualEffect?) {
        if effect == nil {
            super.init(effect: UIBlurEffect(style: .dark))
        } else {
            super.init(effect: effect)
        }
        self.setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        self.contentView.addSubview(self.stackView)
        self.setupStackView()
        self.setupWatchStack()
        self.setupDownloadStack()
        self.setupSearchStack()

        // Adapt visibility based on trait collection (e.g., Regular or Compact)
        self.adaptStackVisibility()
    }

    private func setupStackView() {
        self.stackView.axis = .horizontal
        self.stackView.distribution = .equalSpacing
        self.stackView.alignment = .center
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.addArrangedSubview(self.watchStack)
        // self.stackView.addArrangedSubview(self.downloadStack)
        self.stackView.addArrangedSubview(self.searchStack)

        NSLayoutConstraint.activate([
            self.stackView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
            self.stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20)
        ])

        // Initialize with default width
        self.stackViewWidthConstraint = self.stackView.widthAnchor.constraint(equalToConstant: 300)
        self.stackViewWidthConstraint?.isActive = true
    }

    private func setupWatchStack() {
        self.watchStack.axis = .vertical
        self.watchStack.distribution = .equalCentering
        self.watchStack.alignment = .leading
        self.watchStack.spacing = 3
        self.watchStack.translatesAutoresizingMaskIntoConstraints = false
        self.watchStack.addArrangedSubview(self.watchLabel)
        self.watchStack.addArrangedSubview(self.hoursLabel)
        self.watchStack.addArrangedSubview(self.videoLessonsLabel)

        let lineView = UIView()
        lineView.backgroundColor = UIColor(red: 0.686, green: 0.278, blue: 0.725, alpha: 1)
        lineView.layer.cornerRadius = 3
        lineView.translatesAutoresizingMaskIntoConstraints = false
        self.watchStack.addArrangedSubview(lineView)
        NSLayoutConstraint.activate([
            lineView.heightAnchor.constraint(equalToConstant: 3),
            lineView.leadingAnchor.constraint(equalTo: self.watchStack.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: self.watchStack.trailingAnchor)
        ])

        self.watchLabel.text = "WATCH"
        self.watchLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        self.watchLabel.textColor = .white.withAlphaComponent(0.6)
        self.hoursLabel.text = "44 Hours"
        self.hoursLabel.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        self.hoursLabel.textColor = .white
        self.videoLessonsLabel.text = "of video lessons"
        self.videoLessonsLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        self.videoLessonsLabel.textColor = .white
    }

    private func setupDownloadStack() {
        self.downloadStack.axis = .vertical
        self.downloadStack.distribution = .equalCentering
        self.downloadStack.alignment = .leading
        self.downloadStack.spacing = 3
        self.downloadStack.translatesAutoresizingMaskIntoConstraints = false
        self.downloadStack.addArrangedSubview(self.downloadLabel)
        self.downloadStack.addArrangedSubview(self.gbLabel)
        self.downloadStack.addArrangedSubview(self.sourceFilesLabel)

        let lineView = UIView()
        lineView.backgroundColor = UIColor(red: 0.686, green: 0.278, blue: 0.725, alpha: 1)
        lineView.layer.cornerRadius = 3
        lineView.translatesAutoresizingMaskIntoConstraints = false
        self.downloadStack.addArrangedSubview(lineView)
        NSLayoutConstraint.activate([
            lineView.heightAnchor.constraint(equalToConstant: 3),
            lineView.leadingAnchor.constraint(equalTo: self.downloadStack.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: self.downloadStack.trailingAnchor)
        ])

        self.downloadLabel.text = "DOWNLOAD"
        self.downloadLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        self.downloadLabel.textColor = .white.withAlphaComponent(0.6)
        self.gbLabel.text = "10 GB"
        self.gbLabel.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        self.gbLabel.textColor = .white
        self.sourceFilesLabel.text = "of source files"
        self.sourceFilesLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        self.sourceFilesLabel.textColor = .white
    }

    private func setupSearchStack() {
        self.searchStack.axis = .vertical
        self.searchStack.distribution = .equalCentering
        self.searchStack.alignment = .leading
        self.searchStack.spacing = 3
        self.searchStack.translatesAutoresizingMaskIntoConstraints = false
        self.searchStack.addArrangedSubview(self.searchLabel)
        self.searchStack.addArrangedSubview(self.itemCountLabel)
        self.searchStack.addArrangedSubview(self.wordsImagesLabel)

        let lineView = UIView()
        lineView.backgroundColor = UIColor(red: 0.686, green: 0.278, blue: 0.725, alpha: 1)
        lineView.layer.cornerRadius = 3
        lineView.translatesAutoresizingMaskIntoConstraints = false
        self.searchStack.addArrangedSubview(lineView)
        NSLayoutConstraint.activate([
            lineView.heightAnchor.constraint(equalToConstant: 3),
            lineView.leadingAnchor.constraint(equalTo: self.searchStack.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: self.searchStack.trailingAnchor)
        ])

        self.searchLabel.text = "SEARCH"
        self.searchLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        self.searchLabel.textColor = .white.withAlphaComponent(0.6)
        self.itemCountLabel.text = "50,000"
        self.itemCountLabel.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        self.itemCountLabel.textColor = .white
        self.wordsImagesLabel.text = "words and images"
        self.wordsImagesLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        self.wordsImagesLabel.textColor = .white
    }

    private func adaptStackVisibility() {
        if self.traitCollection.horizontalSizeClass == .regular &&
            self.traitCollection.verticalSizeClass == .regular {
            self.stackViewWidthConstraint?.constant = 450
            self.stackView.insertArrangedSubview(self.downloadStack, at: 1)
        } else {
            self.stackViewWidthConstraint?.constant = 300
            self.downloadStack.removeFromSuperview()
        }
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.horizontalSizeClass != previousTraitCollection?.horizontalSizeClass {
            self.adaptStackVisibility()
        }
    }
}
