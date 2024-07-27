//
//  DataSource.swift
//  UIKitDesignLibrary
//
//  Created by charvin on 2024/7/16.
//

// cards 的数据源协议
protocol DesignCodeAppHomePageChapterCardsDataSource: ViperPresenter {
    func getSectionsNum() -> Int
    func getSectionTitle(for index: Int) -> String
    func getSectionCaption(for index: Int) -> String
    func getSectionContent(for index: Int) -> String
    func getSectionImage(for index: Int) -> String
}
