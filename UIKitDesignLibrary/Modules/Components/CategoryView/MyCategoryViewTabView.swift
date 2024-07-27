//
//  MyCategoryViewTabView.swift
//  UIKitDesignLibrary
//
//  Created by charvin on 2024/5/8.
//

import Foundation
import UIKit

protocol MyCategoryViewTabViewEventHandler {
    func tabView(_ tabView: MyCategoryViewTabView, didSelectItemAt indexPath: IndexPath)
}

extension MyCategoryViewTabViewEventHandler {
    func tabView(_ tabView: MyCategoryViewTabView, didSelectItemAt indexPath: IndexPath) {
//        tabView.selectedIndex = indexPath.item
        tabView.setSelectedIndex(indexPath.item, animated: true)
    }
}

protocol MyCategoryViewTabViewDataSource {
    var identifier: String { get set }
    var tabItems: [Int: MyCategoryViewTabItem] { get set }
    var itemSpacing: CGFloat { get set }
    var tabContentInset: UIEdgeInsets { get set }
    var spacingAverageEnabled: Bool { get set }

    func count() -> Int
    func items() -> [Int: MyCategoryViewTabItem]
    func registerCellClass(in tabView: MyCategoryViewTabView, with identifier: String)

    func tabView(_ tabView: MyCategoryViewTabView, numberOfItemsInSection section: Int) -> Int
    func tabView(_ tabView: MyCategoryViewTabView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    // 设置标签栏的内边距, 比如左右边距
    func tabView(_ tabView: MyCategoryViewTabView, insetForSectionAt section: Int) -> UIEdgeInsets
    // 设置每个标签的宽度
    func tabView(_ tabView: MyCategoryViewTabView, sizeForItemAt indexPath: IndexPath) -> CGSize
    // 当滚动方向为垂直（.vertical）时，一行定义为横向的单元格序列，因此此值表示行间的垂直距离。
    // 当滚动方向为水平（.horizontal）时，一行定义为纵向的单元格序列，此时此值表示行间的水平距离。
    func tabView(_ tabView: MyCategoryViewTabView, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    // 在垂直滚动模式下，此间距是单元格在横向上的间距。
    // 在水平滚动模式下，此间距是单元格在纵向上的间距。
    func tabView(_ tabView: MyCategoryViewTabView, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat

    subscript(index: Int) -> MyCategoryViewTabItem? { get set }
}

extension MyCategoryViewTabViewDataSource {
    func registerCellClass(in tabView: MyCategoryViewTabView) {
        self.registerCellClass(in: tabView, with: self.identifier)
    }

    func tabView(_ tabView: MyCategoryViewTabView, numberOfItemsInSection section: Int) -> Int {
        // 标签项严格要求只有一个 section
        if section != 0 {
            return 0
        }
        return self.count()
    }

    func tabView(_ tabView: MyCategoryViewTabView, insetForSectionAt section: Int) -> UIEdgeInsets {
        return self.tabContentInset
    }

    func tabView(_ tabView: MyCategoryViewTabView, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.itemSpacing
    }

    func tabView(_ tabView: MyCategoryViewTabView, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return self.itemSpacing
    }

    subscript(index: Int) -> MyCategoryViewTabItem? {
        // 下标获取标签数据项, 支持负数反向索引, 正向和反向越界均返回 nil
        get {
            let index = index < 0 ? self.items().count + index : index
            if index >= self.items().count {
                return nil
            }
            return self.tabItems[index]
        }

        set {
            let index = index < 0 ? self.items().count + index : index
            guard let newValue = newValue else { return } // 不能设置 nil
            self.tabItems[index] = newValue
        }
    }
}


class MyCategoryViewTabView: UIViewController {
    enum Orientation {
        case horizontal, vertical
    }

    var dataSource: MyCategoryViewTabViewDataSource? {
        didSet {
            if let tabItems = self.dataSource?.items() {
                for (index, item) in tabItems {
                    item.isSelected = index == self.selectedIndex
                }
            }
            self.collectionView.reloadData()
        }
    }
    var eventHandler: MyCategoryViewTabViewEventHandler?

    private var collectionView: UICollectionView
    private var selectedIndex: Int = 0

    init (orientation: Orientation = .horizontal) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = orientation == .horizontal ? .horizontal : .vertical
        layout.minimumLineSpacing = 0
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.collectionView.backgroundColor = .clear
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.scrollsToTop = false
        super.init(nibName: nil, bundle: nil)
        self.eventHandler = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "defaultCell")
        self.view.addSubview(self.collectionView)
    }

    override func viewDidLayoutSubviews() {
        // 确保 collectionView 的 frame 与 view 的 bounds 一致, 即使发生设备旋转或尺寸变化
        super.viewDidLayoutSubviews()
        self.collectionView.frame = self.view.bounds

        let itemSpacing = self.dataSource?.itemSpacing ?? 0
        let tabContentInset = self.dataSource?.tabContentInset ?? UIEdgeInsets.zero
        let spacingAverageEnabled = self.dataSource?.spacingAverageEnabled ?? false
        
        var totalItemWidth: CGFloat = 0
        var totalContentWidth: CGFloat = 0

        totalContentWidth = tabContentInset.left + tabContentInset.right
        for index in 0..<(self.dataSource?.count() ?? 0) {
            let item = self.dataSource?[index]
            totalItemWidth += item?.itemWidth ?? 0
            totalContentWidth += item?.itemWidth ?? 0 + itemSpacing
        }

        if spacingAverageEnabled && totalContentWidth < self.collectionView.bounds.width {
            var spaceCount = (self.dataSource?.count() ?? 0) - 1
            if tabContentInset.left > 0 {
                spaceCount += 1
            }
            if tabContentInset.right > 0 {
                spaceCount += 1
            }
            let averageSpacing = (self.collectionView.bounds.width - totalItemWidth) / CGFloat(spaceCount)
            self.dataSource?.tabContentInset = UIEdgeInsets(
                top: tabContentInset.top,
                left: averageSpacing,
                bottom: tabContentInset.bottom,
                right: averageSpacing
            )
            self.dataSource?.itemSpacing = averageSpacing
            totalContentWidth = self.collectionView.bounds.width
        }

        self.refreshLayout()
    }

    func setSelectedIndex(_ index: Int, animated: Bool) {
        let oldIndex = self.selectedIndex
        if index < 0 || index >= (self.dataSource?.count() ?? 0) {
            return
        }
        if index == self.selectedIndex {
            return
        }
        self.selectedIndex = index

        // 刷新选中状态
        guard let selectedTabItem = self.dataSource?[self.selectedIndex] else {
            return
        }
        if let oldTabItem = self.dataSource?[oldIndex] {
            oldTabItem.isSelected = false
        }
        selectedTabItem.isSelected = true
        self.refreshCell(at: oldIndex)
        self.refreshCell(at: self.selectedIndex)
//        self.refreshLayout()

        if self.selectedIndex < self.collectionView.numberOfItems(inSection: 0) {
            self.collectionView.selectItem(
                at: IndexPath(item: index, section: 0),
                animated: true,
                scrollPosition: .centeredHorizontally
            )
        }
    }

    func refreshCell(at index: Int) {
        let cell = self.collectionView.cellForItem(
            at: IndexPath(item: index, section: 0)
        ) as? (any MyCategoryViewTabCell)
        cell?.reloadData()
    }

    // 刷新布局
    func refreshLayout() {
        let itemSpacing = self.dataSource?.itemSpacing ?? 0
        let tabContentInset = self.dataSource?.tabContentInset ?? UIEdgeInsets.zero

        var selectedItemX = tabContentInset.left
        for index in 0..<self.selectedIndex {
            selectedItemX += (self.dataSource?[index]?.itemWidth ?? 0) + itemSpacing
        }
        let selectedItemWidth = self.dataSource?[self.selectedIndex]?.itemWidth ?? 0
        let totalContentWidth = self.collectionView.contentSize.width

//        var totalContentWidth: CGFloat = 0
//        totalContentWidth = tabContentInset.left + tabContentInset.right
//        for index in 0..<((self.viewDataSource?.count() ?? 0)) {
//         let item = self.viewDataSource?[index]
//         totalContentWidth += (item?.itemWidth ?? 0) + itemSpacing
//        }
//        totalContentWidth -= itemSpacing

        let minX: CGFloat = 0
        let maxX = totalContentWidth - self.collectionView.bounds.size.width
        let targetX = selectedItemX - self.collectionView.bounds.size.width / 2 + selectedItemWidth / 2
        self.collectionView.setContentOffset(
            CGPoint(x: max(min(maxX, targetX), minX), y: 0), animated: true)
    }

    // MARK: 模拟 UICollectionView 操作
    func dequeueReusableCell(withReuseIdentifier identifier: String, for indexPath: IndexPath) -> UICollectionViewCell {
        return self.collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
    }

    func register(_ cellClass: AnyClass?, forCellWithReuseIdentifier identifier: String) {
        self.collectionView.register(cellClass, forCellWithReuseIdentifier: identifier)
    }

    func scrollTo(_ index: Int, percent: CGFloat) {
        print("""
            scrollTo index: \(index),
            percent: \(percent)
        """)
        if index < 0 || index >= (self.dataSource?.count() ?? 0) {
            return
        }
        // 滚动到指定位置
        let itemSpacing = self.dataSource?.itemSpacing ?? 0
        let tabContentInset = self.dataSource?.tabContentInset ?? UIEdgeInsets.zero

        var selectedItemX = tabContentInset.left
        for i in 0..<self.selectedIndex {
            selectedItemX += (self.dataSource?[i]?.itemWidth ?? 0) + itemSpacing
        }
        // 目的 index 在当前选项左侧或右侧, 需要设置的偏移是不一样的
        let minTargetOffset = 0
        let maxTargetOffset = self.collectionView.contentSize.width - self.collectionView.bounds.width
        var targetOffset = selectedItemX - self.collectionView.bounds.width / 2 + (self.dataSource?[self.selectedIndex]?.itemWidth ?? 0) / 2
        if index < self.selectedIndex {
            targetOffset += percent * (self.dataSource?[index]?.itemWidth ?? 0) + itemSpacing
        } else {
            targetOffset += percent * (self.dataSource?[self.selectedIndex]?.itemWidth ?? 0) + itemSpacing
        }
        targetOffset = max(min(maxTargetOffset, targetOffset), CGFloat(minTargetOffset))

        self.collectionView.setContentOffset(
            CGPoint(
                x: targetOffset,
                y: 0
            ),
            animated: false
        )

//
//        var totalContentWidth: CGFloat = 0
//        totalContentWidth = tabContentInset.left + tabContentInset.right
//        for index in 0..<(self.viewDataSource?.count() ?? 0) {
//            let item = self.viewDataSource?[index]
//            totalContentWidth += item?.itemWidth ?? 0 + itemSpacing
//        }
//        totalContentWidth -= itemSpacing
//
//        let minX: CGFloat = 0
//        let maxX = totalContentWidth - self.collectionView.bounds.size.width
//        let targetX = (self.collectionView.bounds.size.width - itemSpacing) * CGFloat(index) + self.collectionView.bounds.size.width * percent
//        self.collectionView.setContentOffset(
//            CGPoint(x: max(min(maxX, targetX), minX), y: 0), animated: false)

    }
}

// MARK: - UICollectionViewDelegate
extension MyCategoryViewTabView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1 // 标签项不需要分组
    }

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        guard let dataSource = self.dataSource else {
            return 0
        }
        return dataSource.tabView(self, numberOfItemsInSection: section)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let dataSource = self.dataSource else {
            // dataSource 不存在时, 理应 cell 数量为 0
            // 因此不会进入此分支, 但为了保险起见, 还是返回一个默认的随机背景 cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "defaultCell", for: indexPath)
            cell.backgroundColor = UIColor(
                red: CGFloat.random(in: 0...1),
                green: CGFloat.random(in: 0...1),
                blue: CGFloat.random(in: 0...1),
                alpha: 1
            )
            return cell
        }
        return dataSource.tabView(self, cellForItemAt: indexPath)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MyCategoryViewTabView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        guard let dataSource = self.dataSource else {
            return UIEdgeInsets.zero
        }
        return dataSource.tabView(self, insetForSectionAt: section)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        guard let dataSource = self.dataSource else {
            return CGSize.zero
        }
        return dataSource.tabView(self, sizeForItemAt: indexPath)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        guard let dataSource = self.dataSource else {
            return 0
        }
        return dataSource.tabView(self, minimumLineSpacingForSectionAt: section)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        guard let dataSource = self.dataSource else {
            return 0
        }
        return dataSource.tabView(self, minimumInteritemSpacingForSectionAt: section)
    }
}

// MARK: - UICollectionViewDelegate
extension MyCategoryViewTabView: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        // 选中标签时的操作
        self.eventHandler?.tabView(self, didSelectItemAt: indexPath)
    }
}

// MARK: - MyCategoryViewTabViewEventHandler
// 提供默认的 tabView 事件处理方法, 选中标签时切换 selectedIndex
// 与其他组件配合使用时, 可以实现协议并替换事件处理源 eventHandler
extension MyCategoryViewTabView: MyCategoryViewTabViewEventHandler {
    func tabView(_ tabView: MyCategoryViewTabView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.item
    }
}
