//
//  MyCategoryViewTabViewCon.swift
//  UIKitDesignLibrary
//
//  Created by charvin on 2024/5/21.
//

import Foundation
import UIKit


protocol MyCategoryViewDisplayable {}
extension UIView: MyCategoryViewDisplayable {}
extension UIViewController: MyCategoryViewDisplayable {}

protocol MyCategoryViewContainerViewDataSource {
    // 一个索引类型字典, 保存有效的内容列表
    var identifier: String { get set }
    var contentViews: [Int: MyCategoryViewDisplayable] { get set }
    func count() -> Int
    func isEmpty() -> Bool

    func registerCellClass(in containerView: UICollectionView) // 可以重载以自定义 cell
    func getContentView(at index: Int) -> MyCategoryViewDisplayable
    func containerView(_ containerView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
}

extension MyCategoryViewContainerViewDataSource {
    func count() -> Int {
        return self.contentViews.count
    }

    func isEmpty() -> Bool {
        return self.contentViews.isEmpty
    }

    func registerCellClass(in containerView: UICollectionView) {
        containerView.register(
            MyCategoryViewDisplayableCell.self,
            forCellWithReuseIdentifier: self.identifier
        )
    }

    func containerView(_ containerView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = containerView.dequeueReusableCell(
            withReuseIdentifier: self.identifier,
            for: indexPath
        ) as? MyCategoryViewDisplayableCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: self.getContentView(at: indexPath.item))
        return cell
    }
}

protocol MyCategoryViewContainerViewEventHandler {
    func containerView(_ containerView: MyCategoryViewContainerView, didSelectItemAt indexPath: IndexPath)
    func containerView(_ containerView: MyCategoryViewContainerView, didScrollTo index: Int, percent: CGFloat)
}

extension MyCategoryViewContainerViewEventHandler {
    func containerView(_ containerView: MyCategoryViewContainerView, didSelectItemAt indexPath: IndexPath) {}
    func containerView(_ containerView: MyCategoryViewContainerView, didScrollTo index: Int, percent: CGFloat) {}
}

class MyCategoryViewDisplayableCell: UICollectionViewCell {
    func configure(with displayable: MyCategoryViewDisplayable) {
        self.contentView.subviews.forEach { $0.removeFromSuperview() } // 移除旧的子视图

        if let view = displayable as? UIView {
            view.frame = self.contentView.bounds
            self.contentView.addSubview(view)
        } else if let viewController = displayable as? UIViewController {
            viewController.view.frame = self.contentView.bounds
            self.contentView.addSubview(viewController.view)
        }
    }
}

class MyCategoryViewLazyLoadContainerViewDataSource: MyCategoryViewContainerViewDataSource {
    var identifier: String = "defaultCell"
    var contentViews: [Int: MyCategoryViewDisplayable] = [:]
    var contentViewProviders: [Int: () -> MyCategoryViewDisplayable] = [:]

    func addContentViewProvider(at index: Int, provider: @escaping () -> MyCategoryViewDisplayable) {
        self.contentViewProviders[index] = provider
        // 为了获取正确的 view 数量, 需要创建一个占位
        self.contentViews[index] = nil
    }

    func getContentView(at index: Int) -> MyCategoryViewDisplayable {
        if let contentView = self.contentViews[index] {
            return contentView
        } else if let provider = self.contentViewProviders[index] {
            let contentView = provider()
            self.contentViews[index] = contentView
            return contentView
        } else {
            fatalError("No content view or provider found for index \(index)")
        }
    }

    func count() -> Int {
        return self.contentViewProviders.count
    }

    func isEmpty() -> Bool {
        return self.contentViewProviders.isEmpty
    }
}

class MyCategoryViewContainerView: UIViewController {
    enum Orientation {
        case horizontal, vertical
    }

    var contentView: UICollectionView

    var viewDataSource: MyCategoryViewContainerViewDataSource? {
        didSet {
            self.viewDataSource?.registerCellClass(in: self.contentView)
            self.contentView.reloadData()
        }
    }

    var eventHandler: MyCategoryViewContainerViewEventHandler?
    var selectedIndex: Int = 0

    var initContentListPercent: CGFloat = 0.01 { // 初始化内容列表百分比
        didSet {
            if self.initContentListPercent <= 0 || self.initContentListPercent >= 1 {
                assertionFailure("initContentListPercent 值范围为开区间(0,1)，即不包括 0 和 1")
            }
        }
    }

    var contentCellBackgroundColor: UIColor = .clear // 内容区域 cell 背景颜色

    init (orientation: Orientation = .horizontal) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = orientation == .horizontal ? .horizontal : .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        self.contentView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        self.contentView.isPagingEnabled = true
        self.contentView.showsHorizontalScrollIndicator = false
        self.contentView.showsVerticalScrollIndicator = false
        self.contentView.scrollsToTop = false
        self.contentView.bounces = false
        self.contentView.backgroundColor = .clear
        if #available(iOS 10.0, *) {
            self.contentView.isPrefetchingEnabled = false
        }
        if #available(iOS 11.0, *) {
            self.contentView.contentInsetAdjustmentBehavior = .never
        }
        super.init(nibName: nil, bundle: nil)
        self.contentView.delegate = self
        self.contentView.dataSource = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let viewDataSource = self.viewDataSource, !viewDataSource.isEmpty() else {
            return
        }

        if self.contentView.frame == .zero || self.contentView.bounds.size != self.view.bounds.size {
            self.contentView.frame = self.view.bounds
            self.contentView.collectionViewLayout.invalidateLayout()
            self.contentView.setContentOffset(
                CGPoint(x: self.view.bounds.size.width * CGFloat(self.selectedIndex), y: 0),
                animated: false
            )
            self.contentView.reloadData()
            self.contentView.setNeedsLayout()
        } else {
            self.contentView.frame = self.view.bounds
            self.contentView.collectionViewLayout.invalidateLayout()
            self.contentView.setNeedsLayout()
        }
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        // 检查窗口大小是否发生变化
        if previousTraitCollection?.horizontalSizeClass != traitCollection.horizontalSizeClass ||
            previousTraitCollection?.verticalSizeClass != traitCollection.verticalSizeClass {
            self.contentView.reloadData()
        }
    }

    func setupViews() {
        self.view.addSubview(self.contentView)
    }

    func setSelectedIndex(_ index: Int, animated: Bool) {
        self.selectedIndex = index
        self.contentView.setContentOffset(
            CGPoint(x: self.view.bounds.size.width * CGFloat(index), y: 0),
            animated: animated
        )
    }
}

extension MyCategoryViewContainerView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewDataSource?.count() ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return self.viewDataSource?.containerView(self.contentView, cellForItemAt: indexPath) ?? UICollectionViewCell()
    }
}

extension MyCategoryViewContainerView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.view.bounds.size
    }
}

// MA
extension MyCategoryViewContainerView: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView)  {
        guard scrollView.isTracking || scrollView.isDragging else {
            return
        }
        guard let viewDataSource = self.viewDataSource, !viewDataSource.isEmpty() else {
            return
        }

        let selectedItemOffset = CGFloat(self.selectedIndex) * scrollView.bounds.size.width
        let scrollTargetOffset = scrollView.contentOffset.x
        if scrollTargetOffset == selectedItemOffset {
            return
        }

        // 右滑 offset 变大, 左滑 offset 变小

        let scrollOffset = scrollTargetOffset - selectedItemOffset
        let scrollPercent = scrollOffset / scrollView.bounds.size.width

        let targetIndex = scrollOffset > 0 ? self.selectedIndex + 1 : self.selectedIndex - 1
        self.eventHandler?.containerView(self, didScrollTo: targetIndex, percent: scrollPercent)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let curSelectedIndex = self.selectedIndex
        let index = Int(scrollView.contentOffset.x / scrollView.bounds.size.width)
        self.selectedIndex = index
        if curSelectedIndex != index {
            self.eventHandler?.containerView(self, didSelectItemAt: IndexPath(item: index, section: 0))
        }
    }
}
