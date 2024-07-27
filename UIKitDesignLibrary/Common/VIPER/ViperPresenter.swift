import Foundation

protocol ViperPresenter: AnyObject {
    var view: ViperView? { get set } // weak

    var wireframe: ViperWireframe? { get set }
    var interactor: ViperInteractor? { get set }
}
