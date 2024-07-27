//
//  TimeLineRouter.swift
//  UIKitDesignLibrary
//
//  Created by charvin on 2024/7/10.
//

import Foundation
import UIKit

protocol TimeLineRouter: ViperRouter {
    func viewForTimeLine() -> UIViewController
}
