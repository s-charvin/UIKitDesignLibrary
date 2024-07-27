//
//  ContentPageWireframe.swift
//  UIKitDesignLibrary
//
//  Created by charvin on 2024/7/16.
//

import Foundation
import UIKit

extension DesignCodeApp {
    class ContentPageWireframe: ViperWireframe {
        var view: ViperView?
        var router: ViperRouter?

        func dissmissView() {
            guard let targetVC = self.view as? UIViewController else { return }
            self.router?.viperDismiss(targetVC, animated: true, completion: nil)
        }
    }
}
