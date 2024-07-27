//
//  TestmonialViewController.swift
//  UIKitDesignLibrary
//
//  Created by charvin on 2024/7/15.
//

import UIKit
extension DesignCodeApp {
    class TestmonialViewController: UIViewController, ViperView {
        var eventHandler: ViperPresenter?
        var dataSource: ViperPresenter?
        
        var routeSource: UIViewController? {
            return self
        }

        var collectionView: UICollectionView
        let statsStackView = UIStackView()
        let peopleCount = UILabel()
        let peopleLearning = UILabel()
        let deviderLine = UIView()
        let logoStackView = UIStackView()
        let googleLogo = UIImageView()
        let appleLogo = UIImageView()
        let stripeLogo = UIImageView()
        override func viewDidLoad() {
            super.viewDidLoad()
            self.view.backgroundColor = UIColor(red: 32 / 250, green: 38 / 250, blue: 43 / 250, alpha: 1)
            self.setupCollectionView()
            self.setupStatsStackView()
            self.setupLogoStackView()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        init() {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 20
            layout.minimumInteritemSpacing = 20
            layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            super.init(nibName: nil, bundle: nil)
        }

        func setupCollectionView() {
            self.collectionView.translatesAutoresizingMaskIntoConstraints = false
            self.collectionView.backgroundColor = .clear
            self.collectionView.showsHorizontalScrollIndicator = false
            self.collectionView.clipsToBounds = false
            self.collectionView.dataSource = self
            self.collectionView.delegate = self
            self.collectionView.register(
                TestmonialCollectionViewCell.self,
                forCellWithReuseIdentifier: "TestmonialCollectionViewCell"
            )

            self.view.addSubview(self.collectionView)
            NSLayoutConstraint.activate([
                self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50),
                self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                self.collectionView.heightAnchor.constraint(equalToConstant: 235)
            ])
        }

        func setupStatsStackView() {
            self.statsStackView.axis = .vertical
            self.statsStackView.spacing = 0
            self.statsStackView.distribution = .equalCentering
            self.view.addSubview(self.statsStackView)
            self.statsStackView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                self.statsStackView.topAnchor.constraint(equalTo: self.collectionView.bottomAnchor, constant: 50),
                self.statsStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            ])

            self.peopleCount.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
            self.peopleCount.textColor = .white
            self.peopleCount.text = "26,000 people"
            self.statsStackView.addArrangedSubview(self.peopleCount)

            self.peopleLearning.font = UIFont.systemFont(ofSize: 15)
            self.peopleLearning.textColor = .white.withAlphaComponent(0.5)
            self.peopleLearning.text = "are learning with Design+Code"
            self.statsStackView.addArrangedSubview(self.peopleLearning)

            self.deviderLine.backgroundColor = UIColor(red: 175 / 255, green: 71 / 255, blue: 185 / 255, alpha: 1)
            self.deviderLine.layer.cornerRadius = 1.5
            self.statsStackView.addArrangedSubview(self.deviderLine)
            self.deviderLine.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                self.deviderLine.widthAnchor.constraint(equalToConstant: 220),
                self.deviderLine.heightAnchor.constraint(equalToConstant: 3),
                self.deviderLine.centerXAnchor.constraint(equalTo: self.statsStackView.centerXAnchor)
            ])
        }

        func setupLogoStackView() {
            self.logoStackView.axis = .horizontal
            self.logoStackView.spacing = 50
            self.logoStackView.distribution = .equalCentering
            self.view.addSubview(self.logoStackView)
            self.logoStackView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                self.logoStackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50),
                self.logoStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            ])

            self.googleLogo.image = UIImage(named: "Logo-Google")
            self.logoStackView.addArrangedSubview(self.googleLogo)

            self.appleLogo.image = UIImage(named: "Logo-Apple")
            self.logoStackView.addArrangedSubview(self.appleLogo)

            self.stripeLogo.image = UIImage(named: "Logo-Stripe")
            self.logoStackView.addArrangedSubview(self.stripeLogo)
        }
    }

    class TestmonialCollectionViewCell: UICollectionViewCell {
        let containerView = UIView()
        let label = UILabel()
        let quoteBegin = UIImageView()
        let quoteEnd = UIImageView()
        let stackView = UIStackView()
        let fullName = UILabel()
        let jobDescription = UILabel()
        let avatarImage = UIImageView()

        override init(frame: CGRect) {
            super.init(frame: frame)
            self.setupViews()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        func setupViews() {
            self.backgroundColor = .clear
            self.clipsToBounds = false
            self.setupContainerView()
            self.setupLabel()
            self.setupQuoteBegin()
            self.setupQuoteEnd()
            self.setupStackView()
            self.setupFullName()
            self.setupJobDescription()
            self.setupAvatarImageView()
        }

        func setupContainerView() {
            self.containerView.backgroundColor = .white
            self.containerView.layer.cornerRadius = 14
            self.containerView.layer.shadowOpacity = 0.25
            self.containerView.layer.shadowOffset = CGSize(width: 0, height: 10)
            self.containerView.layer.shadowRadius = 20
            self.addSubview(self.containerView)
            self.containerView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                self.containerView.topAnchor.constraint(equalTo: self.topAnchor),
                self.containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                self.containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                self.containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])
        }

        func setupLabel() {
            self.label.font = UIFont.systemFont(ofSize: 18)
            self.label.textColor = .darkGray
            self.label.numberOfLines = 0
            self.label.textAlignment = .left
            self.containerView.addSubview(self.label)
            self.label.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                self.label.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 20),
                self.label.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 54),
                self.label.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -20)
            ])
        }

        func setupQuoteBegin() {
            self.quoteBegin.image = UIImage(named: "Quote-Begin")
            self.containerView.addSubview(self.quoteBegin)
            self.quoteBegin.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                self.quoteBegin.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 20),
                self.quoteBegin.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 16),
                self.quoteBegin.widthAnchor.constraint(equalToConstant: 23),
                self.quoteBegin.heightAnchor.constraint(equalToConstant: 18)
            ])
        }

        func setupQuoteEnd() {
            self.quoteEnd.image = UIImage(named: "Quote-End")
            self.containerView.addSubview(self.quoteEnd)
            self.quoteEnd.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                self.quoteEnd.bottomAnchor.constraint(equalTo: self.label.bottomAnchor),
                self.quoteEnd.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -7),
                self.quoteEnd.widthAnchor.constraint(equalToConstant: 12),
                self.quoteEnd.heightAnchor.constraint(equalToConstant: 9)
            ])
        }

        func setupStackView() {
            self.stackView.axis = .vertical
            self.stackView.spacing = 0
            self.containerView.addSubview(self.stackView)
            self.stackView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                self.stackView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 54),
                self.stackView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -20),
                self.stackView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -14)
            ])
        }

        func setupFullName() {
            self.fullName.font = UIFont.systemFont(ofSize: 15, weight: .medium)
            self.fullName.textColor = .black
            self.stackView.addArrangedSubview(self.fullName)
        }

        func setupJobDescription() {
            self.jobDescription.font = UIFont.systemFont(ofSize: 15)
            self.jobDescription.textColor = .darkGray
            self.stackView.addArrangedSubview(self.jobDescription)
        }

        func setupAvatarImageView() {
            self.avatarImage.layer.cornerRadius = 12
            self.avatarImage.layer.masksToBounds = true
            self.avatarImage.clipsToBounds = true
            self.containerView.addSubview(self.avatarImage)
            self.avatarImage.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                self.avatarImage.trailingAnchor.constraint(equalTo: self.stackView.leadingAnchor, constant: -10),
                self.avatarImage.centerYAnchor.constraint(equalTo: self.stackView.centerYAnchor),
                self.avatarImage.widthAnchor.constraint(equalToConstant: 24),
                self.avatarImage.heightAnchor.constraint(equalToConstant: 24)
            ])
        }
    }
}

extension DesignCodeApp.TestmonialViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let dataSource = self.dataSource as? DesignCodeAppHomePageTestmonialDataSource else {
            return 0
        }
        return dataSource.getTestmonialNum()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TestmonialCollectionViewCell", for: indexPath) as? DesignCodeApp.TestmonialCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard let dataSource = self.dataSource as? DesignCodeAppHomePageTestmonialDataSource else {
            return cell
        }

        cell.label.text = dataSource.getTestmonialContent(for: indexPath.row)
        cell.fullName.text = dataSource.getTestmonialFullName(for: indexPath.row)
        cell.jobDescription.text = dataSource.getTestmonialJobDescription(for: indexPath.row)
        cell.avatarImage.image = UIImage(named: dataSource.getTestmonialAvatar(for: indexPath.row))
        return cell
    }
}

extension DesignCodeApp.TestmonialViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 304, height: 235)
    }
}

protocol DesignCodeAppHomePageTestmonialDataSource: ViperPresenter {
    func getTestmonialNum() -> Int
    func getTestmonialContent(for index: Int) -> String
    func getTestmonialFullName(for index: Int) -> String
    func getTestmonialJobDescription(for index: Int) -> String
    func getTestmonialAvatar(for index: Int) -> String
}
