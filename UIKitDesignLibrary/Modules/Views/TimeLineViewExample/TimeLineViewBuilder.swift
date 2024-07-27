//
//  TimeLineViewBuilder.swift
//  UIKitDesignLibrary
//
//  Created by charvin on 2024/7/10.
//

import UIKit

class TimeLineViewBuilder: ViperBuilder {
    static func getView(router: ViperRouter?) -> ViperView? {
        let view = TimeLineViewController()
        let presenter = TimeLinePresenter()
        let interactor = TimeLineInteractor()
        let wireframe = TimeLineWireframe()

        self.viperAssemble(
            for: view,
            presenter: presenter,
            interactor: interactor,
            wireframe: wireframe,
            router: router
        )

        return view
    }
}
