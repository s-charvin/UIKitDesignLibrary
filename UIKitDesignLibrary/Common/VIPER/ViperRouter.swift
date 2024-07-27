import UIKit

protocol Routable {
    var viewController: UIViewController? { get }
    var window: UIWindow? { get }
}

extension UIViewController: Routable {
    var viewController: UIViewController? {
        return self
    }
    var window: UIWindow? {
        return nil
    }
}

extension UIWindow: Routable {
    var viewController: UIViewController? {
        return self.rootViewController
    }

    open override var window: UIWindow? {
        return self
    }
}

protocol ViperRouter: AnyObject {
    func viperPush(
        _ viewController: Routable,
        to destination: Routable,
        animated: Bool
    )

    func viperPop(
        _ viewController: Routable,
        animated: Bool
    ) -> Routable?

    func viperPresent(
        _ viewControllerToPresent: Routable,
        to source: Routable,
        animated: Bool,
        completion: (() -> Void)?
    )

    func viperDismiss(
        _ viewController: Routable,
        animated: Bool,
        completion: (() -> Void)?
    )
}


extension ViperRouter {
    // 将一个视图控制器推送到另一个视图控制器的导航堆栈中。这要求目标视图控制器必须已经嵌入在一个 UINavigationController 中。
    func viperPush(_ viewController: Routable, to destination: Routable, animated: Bool) {
        guard let navigationController = destination.viewController?.navigationController else {
            assertionFailure("Destination view controller is not embedded in a UINavigationController")
            return
        }
        guard let vcToPush = viewController.viewController else {
            assertionFailure("View controller is not embedded in a UINavigationController")
            return
        }
        navigationController.pushViewController(vcToPush, animated: animated)
    }

    // 从指定视图控制器的导航堆栈中移除顶部的视图控制器。
    func viperPop(_ viewController: Routable, animated: Bool) -> Routable? {
        guard let nvToPop = viewController.viewController?.navigationController else {
            assertionFailure("View controller is not embedded in a UINavigationController")
            return nil
        }
        return nvToPop.popViewController(animated: animated)
    }

    // 将一个视图控制器暂时推送到另一个视图控制器的模态堆栈中。
    func viperPresent(_ viewController: Routable, to destination: Routable, animated: Bool, completion: (() -> Void)?) {
        guard let vcToPresent = viewController.viewController else {
            assertionFailure("View controller is not embedded in a UINavigationController")
            return
        }
        let destVC = destination.viewController
        if let navigationController = destVC?.navigationController {
            navigationController.present(vcToPresent, animated: animated, completion: completion)
        } else {
            destVC?.present(vcToPresent, animated: animated, completion: completion)
        }
    }
    // 从当前视图控制器模态堆栈中移除之前推送的视图控制器，返回到呈现它之前的状态。
    func viperDismiss(_ viewController: Routable, animated: Bool, completion: (() -> Void)?) {
        guard let vcToDismiss = viewController.viewController else {
            return
        }
        if vcToDismiss.presentingViewController == nil {
            assertionFailure("View controller is not presented")
        }
        vcToDismiss.dismiss(animated: animated, completion: completion)
    }
}
