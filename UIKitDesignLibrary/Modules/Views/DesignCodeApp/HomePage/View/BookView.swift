//
//  BookView.swift
//  UIKitDesignLibrary
//
//  Created by charvin on 2024/4/23.
//

import UIKit
extension DesignCodeApp {
    class BookView: UIView {
        let imageView = UIImageView()
        let label1 = UILabel()
        let label2 = UILabel()

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
            self.setupLabelView()
        }

        func setupLabelView() {
            self.addSubview(self.label1)
            self.label1.text = "An interactive book on how to design and code an iOS app."
            self.label1.textColor = .black
            self.label1.font = .systemFont(ofSize: 22, weight: .medium)
            self.label1.textAlignment = .center
            self.label1.numberOfLines = 0
            self.label1.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                self.label1.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 20),
                self.label1.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
                self.label1.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30)
            ])

            self.addSubview(self.label2)
            self.label2.text = "For beginners and designers."
            self.label2.textColor = .lightGray
            self.label2.font = .systemFont(ofSize: 22, weight: .medium)
            self.label2.textAlignment = .center
            self.label2.numberOfLines = 0
            self.label2.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                self.label2.topAnchor.constraint(equalTo: self.label1.bottomAnchor, constant: 0),
                self.label2.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
                self.label2.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30)
            ])
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
}
