//
//  DesignCodeAppContentPageBuilder.swift
//  UIKitDesignLibrary
//
//  Created by charvin on 2024/7/16.
//

import Foundation

import UIKit
extension DesignCodeApp {
    class ContentPageModuleBuilder: ViperBuilder {
        static func getView(router: ViperRouter? = nil) -> ViperView? {
            let viewController = ContentPageViewController()
            let presenter: ViperPresenter = ContentPagePresenter()
            let interactor: ViperInteractor = ContentPageInteractor()
            let wireframe: ViperWireframe = ContentPageWireframe()

            self.viperAssemble(
                for: viewController,
                presenter: presenter,
                interactor: interactor,
                wireframe: wireframe,
                router: router)
            return viewController
        }
    }
}
