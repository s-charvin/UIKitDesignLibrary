//
//  MyCategoryView.swift
//  EventPage
//
//  Created by scw on 2024/1/24.
//

import Foundation
import UIKit
import SnapKit

class MyCategoryView: UIViewController {
    enum Orientation {
        case horizontal, vertical
    }

    enum SelectedType {
        case scroll, click
    }

    var orientation: Orientation = .horizontal
    var selectedIndex: Int = 0

    // 标签选项显示区域
    lazy var tabView: MyCategoryViewTabView = {
        let collectionView = MyCategoryViewTabView(
            orientation: self.orientation == .horizontal ? .horizontal : .vertical
        )
        return collectionView
    }()

    // 内容区域 UIScrollView
    lazy var containerView: MyCategoryViewContainerView = {
        let collectionView = MyCategoryViewContainerView(
            orientation: self.orientation == .horizontal ? .horizontal : .vertical
        )
        return collectionView
    }()

    var tabDataSource: MyCategoryViewTabViewDataSource? {
        didSet {
            guard let tabDataSource = self.tabDataSource else { return }
            self.tabView.dataSource = tabDataSource
            tabDataSource.registerCellClass(in: self.tabView)
        }
    }

    var containerDataSource: MyCategoryViewContainerViewDataSource? {
        didSet {
            guard let containerDataSource = self.containerDataSource else { return }
            self.containerView.dataSource = containerDataSource
        }
    }

    init (orientation: Orientation = .horizontal) {
        self.orientation = orientation
        super.init(nibName: nil, bundle: nil)
        self.tabView.eventHandler = self
        self.containerView.eventHandler = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
    }

    private func setupViews() {
        self.view.addSubview(self.containerView.view)
        self.view.addSubview(self.tabView.view)

        // 使用 NSlayoutConstraint 进行布局
        self.tabView.view.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.view.translatesAutoresizingMaskIntoConstraints = false

        switch self.orientation {
        case .horizontal:
            NSLayoutConstraint.activate([
                self.tabView.view.topAnchor.constraint(equalTo: self.view.topAnchor),
                self.tabView.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                self.tabView.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                self.tabView.view.heightAnchor.constraint(equalToConstant: 44),

                self.containerView.view.topAnchor.constraint(equalTo: self.tabView.view.bottomAnchor),
                self.containerView.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                self.containerView.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                self.containerView.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
            ])
        case .vertical:
            NSLayoutConstraint.activate([
                self.tabView.view.topAnchor.constraint(equalTo: self.view.topAnchor),
                self.tabView.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                self.tabView.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                self.tabView.view.widthAnchor.constraint(equalToConstant: 44),

                self.containerView.view.topAnchor.constraint(equalTo: self.view.topAnchor),
                self.containerView.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                self.containerView.view.leadingAnchor.constraint(equalTo: self.tabView.view.trailingAnchor),
                self.containerView.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
            ])
        }
    }

    func setSelectIndex(_ index: Int, type: SelectedType = .click) {
        self.selectedIndex = index
        if type == .scroll {
            self.tabView.setSelectedIndex(index, animated: true)
            self.containerView.setSelectedIndex(index, animated: true)
        } else {
            self.tabView.setSelectedIndex(index, animated: true)
            self.containerView.setSelectedIndex(index, animated: false)
        }
    }
}

// MARK: - MyCategoryViewTabViewEventHandlerProtocol
extension MyCategoryView: MyCategoryViewTabViewEventHandler {
    func tabView(_ tabView: MyCategoryViewTabView, didSelectItemAt indexPath: IndexPath) {
//        self.selectedIndex = indexPath.item
        self.setSelectIndex(indexPath.item, type: .click)
    }
}

// MARK: - MyCategoryViewContainerViewEventHandlerProtocol
extension MyCategoryView: MyCategoryViewContainerViewEventHandler {
    func containerView(_ containerView: MyCategoryViewContainerView, didSelectItemAt indexPath: IndexPath) {
//        self.selectedIndex = indexPath.item
        self.setSelectIndex(indexPath.item, type: .scroll)
    }

    func containerView(_ containerView: MyCategoryViewContainerView, didScrollTo index: Int, percent: CGFloat) {
        self.tabView.scrollTo(index, percent: percent)
    }
}
