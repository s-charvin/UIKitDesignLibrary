//
//  MyCategoryViewBaseTab.swift
//  UIKitDesignLibrary
//
//  Created by charvin on 2024/5/8.
//


import Foundation
import UIKit

protocol MyCategoryViewTabItemProtocol {
    var index: Int { get set }
    var isSelected: Bool { get set }
    var itemWidth: CGFloat { get set }
}

class MyCategoryViewTabItem: MyCategoryViewTabItemProtocol {
    var index: Int = 0
    var isSelected = false
    var itemWidth: CGFloat = 0
}

protocol MyCategoryViewTabCell {
    associatedtype Item: MyCategoryViewTabItem
    var item: Item? { get set }
    func reloadData()
}
