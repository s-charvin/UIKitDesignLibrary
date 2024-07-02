//
//  BookView.swift
//  UIKitDesignLibrary
//
//  Created by charvin on 2024/4/23.
//

import UIKit


class DesignCodeAppBookView: UIView {
    let imageView = UIImageView()

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
    }

    func setupImageView() {
        self.addSubview(self.imageView)
        self.imageView.image = UIImage(named: "Art-Book")
        self.imageView.contentMode = .scaleAspectFit
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 50)
        ])
    }
}
