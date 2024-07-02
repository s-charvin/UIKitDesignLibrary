import UIKit
import SnapKit


class MyCategoryViewContainerViewDataSourceExample: MyCategoryViewLazyLoadContainerViewDataSource {
    override init() {
        super.init()
        for i in 0...15 {
            self.addContentViewProvider(at: i) {
                let view = UIView()
                view.backgroundColor = UIColor(
                    red: CGFloat.random(in: 0...255) / 255.0,
                    green: CGFloat.random(in: 0...255) / 255.0,
                    blue: CGFloat.random(in: 0...255) / 255.0,
                    alpha: 1
                )
                return view
            }
        }
    }
}

class MyCategoryTestViewController: UIViewController {
    lazy var myCategoryView: MyCategoryView = {
        let view = MyCategoryView()

        let dataSource = MyCategoryViewTitleTabViewDataSource()
        dataSource.titles = (0...15).map { "Tab \($0)" }
        dataSource.titleNormalColor = .black
        dataSource.titleSelectedColor = .red
        dataSource.titleNormalFont = UIFont.systemFont(ofSize: 17)
        dataSource.titleSelectedFont = UIFont.boldSystemFont(ofSize: 20)
        dataSource.itemSpacing = 10
        dataSource.tabContentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        // dataSource.spacingAverageEnabled = true
        view.tabDataSource = dataSource
        view.containerDataSource = MyCategoryViewContainerViewDataSourceExample()
        view.selectedIndex = 1
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
    }

    private func setupViews() {
        self.view.addSubview(self.myCategoryView.view)

        // 使用 SnapKit 进行布局
        self.myCategoryView.view.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
