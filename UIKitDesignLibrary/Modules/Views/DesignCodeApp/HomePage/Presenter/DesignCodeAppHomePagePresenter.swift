import Foundation
import UIKit

class DesignCodeAppHomePageViewPresenter: ViperPresenter,
    DesignCodeAppHomePageViewEventHandler,
    DesignCodeAppHomePageViewDataSource {
    weak var view: ViperView?
    var wireframe: ViperWireframe?
    var interactor: ViperInteractor?
}
