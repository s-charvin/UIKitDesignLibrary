import UIKit
import Factory

class AppRouter: ViperRouter {
    static var shared = AppRouter()
    static let container = Container.shared
}

extension AppRouter: DesignCodeAppHomePageRouter {
    func viewForHomePage() -> UIViewController {
        return AppRouter.container.designCodeAppHomePage() ?? UIViewController()
    }

    func viewForMyCategoryTest() -> UIViewController {
        return AppRouter.container.myCategory()
    }
}

extension AppRouter: DesignCodeAppContentPageRouter {
    func viewForContentPage(title: String, caption: String, content: String, image: String, progress: String) -> UIViewController {
        guard let viewController = AppRouter.container.designCodeAppContentPage() else {
            return UIViewController()
        }
        viewController.heroView.titleLabel.text = title
        viewController.heroView.captionLabel.text = caption
        viewController.heroView.contentLabel.text = content
        viewController.heroView.backgroundImageView.image = UIImage(named: image)
        viewController.heroView.progressView.text = progress
        return viewController
    }
}

extension AppRouter: TimeLineRouter {
    func viewForTimeLine() -> UIViewController {
        return AppRouter.container.timeLine()
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
    var designCodeAppHomePage: Factory<DesignCodeApp.HomePageViewController?> {
        Factory(self) {
            guard let viewController = DesignCodeApp.HomePageModuleBuilder.getView(
                router: self.router()) as? DesignCodeApp.HomePageViewController
            else {
                return nil
            }

            DesignCodeApp.HomePageModuleBuilder.injectDataService(
                for: viewController,
                dataService: DesignCodeAppDataSevice())
            return viewController
        }.singleton
    }

    // DesignCodeAppContentPage 页面
    var designCodeAppContentPage: Factory<DesignCodeApp.ContentPageViewController?> {
        Factory(self) {
            guard let viewController = DesignCodeApp.ContentPageModuleBuilder.getView(
                router: self.router()) as? DesignCodeApp.ContentPageViewController
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

    // TimeLine 展示页面
    var timeLine: Factory<TimeLineViewController> {
        Factory(self) {
            let viewController = TimeLineViewController()
            return viewController
        }
    }
}
