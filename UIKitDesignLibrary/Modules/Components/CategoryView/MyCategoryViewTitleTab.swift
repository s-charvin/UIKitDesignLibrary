//
//  MyCategoryViewTitleTab.swift
//  UIKitDesignLibrary
//
//  Created by charvin on 2024/5/8.
//

import Foundation
import UIKit

class MyCategoryViewTitleTabViewDataSource: MyCategoryViewTabViewDataSource {
    var identifier = "DefaultTitleTabCell"
    var tabItems: [Int: MyCategoryViewTabItem] = [:]
    var itemSpacing: CGFloat = 0
    var spacingAverageEnabled = false
    var tabContentInset: UIEdgeInsets = .zero

    var titles: [String] = []
    var titleNumberOfLines: Int = 1
    var titleNormalColor: UIColor = .black
    var titleSelectedColor: UIColor = .red
    var titleNormalFont: UIFont = .systemFont(ofSize: 15)
    var titleSelectedFont: UIFont?

    func count() -> Int {
        return self.titles.count
    }

    func items() -> [Int: MyCategoryViewTabItem] {
        if self.tabItems.count != self.titles.count {
            for index in 0..<self.titles.count {
                let newItem = self.createTabItem(for: index)
                self.tabItems[index] = newItem
            }
        }
        return self.tabItems
    }

    func registerCellClass(in tabView: MyCategoryViewTabView, with identifier: String = "MyCategoryViewTitleTabCell") {
        self.identifier = identifier
        tabView.register(
            MyCategoryViewTitleTabCell.self,
            forCellWithReuseIdentifier: identifier
        )
    }

    func tabView(_ tabView: MyCategoryViewTabView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = tabView.dequeueReusableCell(
            withReuseIdentifier: self.identifier,
            for: indexPath
        ) as? MyCategoryViewTitleTabCell else {
            return UICollectionViewCell()
        }
        cell.item = self[indexPath.item] as? MyCategoryViewTitleTabCell.Item
        cell.reloadData()
        return cell
    }

    func tabView(_ tabView: MyCategoryViewTabView, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let item = self[indexPath.item] as? MyCategoryViewTitleTabItem else { return .zero }
        let width = item.itemWidth
        return CGSize(width: width, height: tabView.view.bounds.height)
    }

    private func widthForTitle(_ title: String) -> CGFloat {
        let textWidth = NSString(string: title).boundingRect(
            with: CGSize(width: CGFloat.infinity, height: CGFloat.infinity),
            options: [.usesFontLeading, .usesLineFragmentOrigin],
            attributes: [NSAttributedString.Key.font: self.titleSelectedFont ?? self.titleNormalFont],
            context: nil
        ).size.width
        return CGFloat(ceilf(Float(textWidth)))
    }

    func createTabItem(for index: Int) -> MyCategoryViewTabItem {
        guard index >= 0, index < self.titles.count else {
            fatalError("Index out of range")
        }
        let title = self.titles[index]
        let item = MyCategoryViewTitleTabItem()
        item.index = index
        item.title = title
        item.textWidth = self.widthForTitle(title)
        item.itemWidth = item.textWidth
        item.titleNumberOfLines = self.titleNumberOfLines
        item.titleNormalColor = self.titleNormalColor
        item.titleSelectedColor = self.titleSelectedColor
        item.titleNormalFont = self.titleNormalFont
        item.titleSelectedFont = self.titleSelectedFont ?? self.titleNormalFont
        return item
    }
}

class MyCategoryViewTitleTabItem: MyCategoryViewTabItem {
    var title: String = ""
    var titleNumberOfLines: Int = 1
    var textWidth: CGFloat = 0
    var titleNormalColor: UIColor = .black
    var titleSelectedColor: UIColor = .red
    var titleNormalFont: UIFont = .systemFont(ofSize: 15)
    var titleSelectedFont: UIFont = .systemFont(ofSize: 15)
}

class MyCategoryViewTitleTabCell: UICollectionViewCell, MyCategoryViewTabCell {
    typealias Item = MyCategoryViewTitleTabItem
    var item: Item?
    let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        guard let item = self.item else { return }

        // 使用 sizeThatFits 方法确保标签的高度适合标签内容
        let labelSize = self.titleLabel.sizeThatFits(self.contentView.bounds.size)
        var labelBounds = CGRect(x: 0, y: 0, width: labelSize.width, height: labelSize.height)

        // 使用 textWidth 来限制标签的宽度
        labelBounds.size.width = item.textWidth
        self.titleLabel.bounds = labelBounds
        self.titleLabel.center = self.contentView.center
    }

    func setupViews() {
        self.titleLabel.textAlignment = .center
        self.contentView.addSubview(self.titleLabel)
        self.reloadData()
    }

    func reloadData() {
        guard let item = self.item else { return }
        self.titleLabel.text = item.title
        self.titleLabel.textColor = item.isSelected ? item.titleSelectedColor : item.titleNormalColor
        self.titleLabel.font = item.isSelected ? item.titleSelectedFont : item.titleNormalFont
        self.setNeedsLayout() // 重新布局
    }
}
