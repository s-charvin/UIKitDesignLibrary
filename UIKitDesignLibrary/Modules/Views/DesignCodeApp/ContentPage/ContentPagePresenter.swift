//
//  ContentPagePresenter.swift
//  UIKitDesignLibrary
//
//  Created by charvin on 2024/7/16.
//

import Foundation

extension DesignCodeApp {
    class ContentPagePresenter: ViperPresenter {
        var view: ViperView?
        var interactor: ViperInteractor?
        var wireframe: ViperWireframe?
    }
}

extension DesignCodeApp.ContentPagePresenter: DesignCodeAppContentPageEventHandler {
    func closeButtonTapped() {
        guard let wireframe = self.wireframe as? DesignCodeApp.ContentPageWireframe else { return }
        wireframe.dissmissView()
    }
}
