import UIKit

class DesignCodeAppHomePageModuleBuilder: ViperBuilder {
    static func getView(router: ViperRouter? = nil) -> ViperView? {
        let viewController = DesignCodeAppHomePageViewController()
        let presenter: ViperPresenter = DesignCodeAppHomePageViewPresenter()
        let interactor: ViperInteractor = DesignCodeAppHomePageInteractor()
        let wireframe: ViperWireframe = DesignCodeAppHomePageWireframe()

        self.viperAssemble(
            for: viewController,
            presenter: presenter,
            interactor: interactor,
            wireframe: wireframe,
            router: nil)
        return viewController
    }
}
