import Foundation
import UIKit

class DesignCodeAppHomePageViewPresenter: ViperPresenter,
                                          DesignCodeAppHomePageViewEventHandler,
                                          DesignCodeAppHomePageViewDataSource {

    weak var view: ViperView? = nil
    var wireframe: ViperWireframe? = nil
    var interactor: ViperInteractor? = nil

}
