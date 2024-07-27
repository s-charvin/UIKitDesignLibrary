import UIKit
extension DesignCodeApp {
    class HomePageModuleBuilder: ViperBuilder {
        static func getView(router: ViperRouter? = nil) -> ViperView? {
            let viewController = HomePageViewController()
            let presenter: ViperPresenter = HomePageViewPresenter()
            let interactor: ViperInteractor = HomePageInteractor()
            let wireframe: ViperWireframe = HomePageWireframe()

            self.viperAssemble(
                for: viewController,
                presenter: presenter,
                interactor: interactor,
                wireframe: wireframe,
                router: router)
            return viewController
        }

        static func injectDataService(
            for viewController: ViperView,
            dataService: DesignCodeAppHomePageDataSourceInterface
        ) {
            guard let interactor = viewController.dataSource?.interactor as? HomePageInteractor
            else { return }
            interactor.dataSevice = dataService
        }
    }
}
