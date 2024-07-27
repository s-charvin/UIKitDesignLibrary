import Foundation
import UIKit
extension DesignCodeApp {
    class HomePageWireframe: ViperWireframe {
        // MARK: - ViperWireframe
        weak var view: ViperView?
        var router: ViperRouter?

        func showContent(title: String, caption: String, content: String, image: String, progress: String) {
            guard let router = self.router as? DesignCodeAppContentPageRouter else { return }
            guard let targetVC = self.view as? UIViewController else { return }
            let viewController = router.viewForContentPage(title: title, caption: caption, content: content, image: image, progress: progress)
            router.viperPresent(viewController, to: targetVC, animated: true, completion: nil)        }
    }
}
