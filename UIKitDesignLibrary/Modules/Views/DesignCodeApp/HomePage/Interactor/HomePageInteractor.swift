import Combine
import Foundation

extension DesignCodeApp {
    class HomePageInteractor: ViperInteractor {
        var dataSource: ViperPresenter?
        var eventHandler: ViperPresenter?

        var dataSevice: DesignCodeAppHomePageDataSourceInterface?
    }
}
