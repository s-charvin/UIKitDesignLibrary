//
//  DesignCodeAppHomePage.swift
//  UIKitDesignLibrary
//
//  Created by charvin on 2024/4/22.
//
import UIKit
import Foundation

class DesignCodeAppHomePageViewController: UIViewController, ViperView {
    var eventHandler: ViperViewEventHandler?
    var viewDataSource: ViperPresenter?

    let heroView = DesignCodeAppHeroView()
    let bookView = DesignCodeAppBookView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
    }

    func setupViews() {
        self.view.backgroundColor = .systemBackground
        self.setupHeroView()
        self.setupBookView()
    }

    func setupHeroView() {
        self.view.addSubview(self.heroView)
        self.heroView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.heroView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.heroView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.heroView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.heroView.heightAnchor.constraint(equalToConstant: 452)
        ])
    }

    func setupBookView() {
        self.view.addSubview(self.bookView)
        self.bookView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.bookView.topAnchor.constraint(equalTo: self.heroView.bottomAnchor),
            self.bookView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.bookView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.bookView.heightAnchor.constraint(equalToConstant: 348)
        ])
    }
}
