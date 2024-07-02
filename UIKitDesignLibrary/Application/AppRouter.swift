import UIKit
import Factory

class AppRouter: ViperRouter {
    static var shared = AppRouter()
    static let container = Container.shared
}

extension AppRouter: DesignCodeAppHomePageRouter {
    func viewForDesignCodeAppHomePage() -> UIViewController {
        return AppRouter.container.designCodeAppHomePage() ?? UIViewController()
    }
    func viewForMyCategoryTest() -> UIViewController {
        return AppRouter.container.myCategory()
    }
}

extension Container {
    var router: Factory<AppRouter> {
        Factory(self) {
            AppRouter.shared
        }
    }

    // 空白欢迎页
    var blankPage: Factory<UIViewController> {
        Factory(self) {
            let pageView = UIViewController()
            pageView.view.backgroundColor = .white
            let label = UILabel()
            label.text = "Welcome to ...."
            label.textColor = .black
            label.font = UIFont.systemFont(ofSize: 20)
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            pageView.view.addSubview(label)
            NSLayoutConstraint.activate([
                label.centerXAnchor.constraint(equalTo: pageView.view.centerXAnchor),
                label.centerYAnchor.constraint(equalTo: pageView.view.centerYAnchor)
            ])
            return pageView
        }
    }
    // DesignCodeAppHomePage 页面

    var designCodeAppHomePage: Factory<DesignCodeAppHomePageViewController?> {
        Factory(self) {
            guard let viewController = DesignCodeAppHomePageModuleBuilder.getView(
                router: self.router()) as? DesignCodeAppHomePageViewController
            else {
                return nil
            }
            return viewController
        }.singleton
    }

    // MyCategory 测试页面
    var myCategory: Factory<MyCategoryTestViewController> {
        Factory(self) {
            let viewController = MyCategoryTestViewController()
            return viewController
        }
    }
}
