//
//  ContentPageRouter.swift
//  UIKitDesignLibrary
//
//  Created by charvin on 2024/7/16.
//

import Foundation
import UIKit

protocol DesignCodeAppContentPageRouter: ViperRouter {
    func viewForContentPage(title: String, caption: String, content: String, image: String, progress: String) -> UIViewController
}
