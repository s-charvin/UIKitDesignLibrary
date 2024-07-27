import Foundation
import UIKit

protocol DesignCodeAppHomePageViewEventHandler: ViperPresenter {
    func playButtonTapped()
    func chapterTapped(at index: Int)
}
