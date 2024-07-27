//
//  TimeLineViewController.swift
//  UIKitDesignLibrary
//
//  Created by charvin on 2024/7/10.
//

import UIKit

struct TimeLineConfiguration {
    let rect: CGRect
    let orientation: TimeLineNodeView.Orientation
    let nodePosition: TimeLineNodeView.NodePosition
}

class TimeLineViewController: UIViewController, ViperView {
    var eventHandler: ViperPresenter?
    var dataSource: ViperPresenter?

    var routeSource: UIViewController? {
        return self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        
        self.setupTimeLineViews()
        self.setupHorizontalTimeLine()
    }

    func setupTimeLineViews() {
        let configurations: [TimeLineConfiguration] = [
            TimeLineConfiguration(
                rect: CGRect(x: 50, y: 100, width: 10, height: 200),
                orientation: .vertical,
                nodePosition: .start
            ),
            TimeLineConfiguration(
                rect: CGRect(x: 70, y: 100, width: 10, height: 200),
                orientation: .vertical,
                nodePosition: .end
            ),
            TimeLineConfiguration(
                rect: CGRect(x: 90, y: 100, width: 10, height: 200),
                orientation: .vertical,
                nodePosition: .none
            ),
            TimeLineConfiguration(
                rect: CGRect(x: 110, y: 100, width: 200, height: 10),
                orientation: .horizontal,
                nodePosition: .start
            ),
            TimeLineConfiguration(
                rect: CGRect(x: 110, y: 120, width: 200, height: 10),
                orientation: .horizontal,
                nodePosition: .end
            ),
            TimeLineConfiguration(
                rect: CGRect(x: 110, y: 140, width: 200, height: 10),
                orientation: .horizontal,
                nodePosition: .none
            )
        ]

        for configuration in configurations {
            let timeLineView = TimeLineNodeView(frame: configuration.rect)
            timeLineView.backgroundColor = .white
            timeLineView.gap = 0
            timeLineView.nodePosition = configuration.nodePosition
            timeLineView.orientation = configuration.orientation

            let line2 = TimeLineGradientLine()
            line2.colors = [
                UIColor(red: 168 / 255, green: 237 / 255, blue: 234 / 255, alpha: 1.0),
                UIColor(red: 254 / 255, green: 214 / 255, blue: 227 / 255, alpha: 1.0)
            ]
            line2.direction = .startToEnd
            line2.locations = [0, 1]
            line2.width = 4
            timeLineView.line = line2

            let node = TimeLineTriangleNode()
            node.color = .black
            node.size = CGSize(width: 10, height: 10)
            timeLineView.node = node

            self.view.addSubview(timeLineView)
        }
    }

    func setupHorizontalTimeLine() {
        let scrollView = UIScrollView(frame: CGRect(x: 20, y: 300, width: self.view.bounds.width - 40, height: 60))
        scrollView.contentSize = CGSize(width: 1200, height: 60)
        scrollView.backgroundColor = .lightGray
        self.view.addSubview(scrollView)

        for i in 0..<10 {
            let xPosition = i * 100
            let timeLineView = TimeLineNodeView(frame: CGRect(x: xPosition, y: 0, width: 100, height: 60))
            timeLineView.backgroundColor = .white
            timeLineView.gap = 0
            timeLineView.nodePosition = .end
            timeLineView.orientation = .horizontal

            let line = TimeLineGradientLine()
            line.colors = [.black, .black]
            line.width = 2
            timeLineView.line = line

            let node = TimeLineCircleNode()
            node.color = .black
            node.size = CGSize(width: 10, height: 10)
            timeLineView.node = node

            scrollView.addSubview(timeLineView)
        }
    }
}
