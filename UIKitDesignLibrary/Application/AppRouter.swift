import UIKit
import Factory

class AppRouter: ViperRouter {
    static var shared = AppRouter()
    static let container = Container.shared
}

extension AppRouter: DesignCodeAppHomePageRouter {

    func viewForDesignCodeAppHomePage() -> UIViewController {
        return AppRouter.container.designCodeAppHomePage()
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
            let view_ = UIViewController()
            view_.view.backgroundColor = .white
            let label = UILabel()
            label.text = "Welcome to ...."
            label.textColor = .black
            label.font = UIFont.systemFont(ofSize: 20)
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            view_.view.addSubview(label)
            NSLayoutConstraint.activate([
                label.centerXAnchor.constraint(equalTo: view_.view.centerXAnchor),
                label.centerYAnchor.constraint(equalTo: view_.view.centerYAnchor)
            ])
            return view_
        }
    }
    
    var designCodeAppHomePage: Factory<DesignCodeAppHomePageViewController> {
        Factory(self) {
            DesignCodeAppHomePageModuleBuilder.getView(router: self.router()) as! DesignCodeAppHomePageViewController
        }.singleton
    }

}



