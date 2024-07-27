//
//  TimeLineBaseNode.swift
//  UIKitDesignLibrary
//
//  Created by charvin on 2024/7/12.
//

import UIKit

protocol TimeLineBaseNode {
    var size: CGSize { get set }
    func draw(in context: CGContext, rect: CGRect, position: TimeLineNodeView.NodePosition, orientation: TimeLineNodeView.Orientation)
}

// Circle Node Class
class TimeLineCircleNode: TimeLineBaseNode {
    var color: UIColor = .black
    var size = CGSize(width: 3, height: 3)

    init(color: UIColor, size: CGSize) {
        self.color = color
        self.size = size
    }

    init() {}

    func draw(in context: CGContext, rect: CGRect, position: TimeLineNodeView.NodePosition, orientation: TimeLineNodeView.Orientation) {
        context.setFillColor(self.color.cgColor)
        context.fillEllipse(in: rect)
    }
}

class TimeLineSquareNode: TimeLineBaseNode {
    var color: UIColor = .black
    var size = CGSize(width: 3, height: 3)

    init(color: UIColor, size: CGSize) {
        self.color = color
        self.size = size
    }

    init() {}

    func draw(in context: CGContext, rect: CGRect, position: TimeLineNodeView.NodePosition, orientation: TimeLineNodeView.Orientation) {
        context.setFillColor(self.color.cgColor)
        context.fill(rect)
    }
}

class TimeLineImageNode: TimeLineBaseNode {
    var size = CGSize(width: 3, height: 3)
    var image: UIImage?

    init(image: UIImage, size: CGSize) {
        self.image = image
        self.size = size
    }

    init() {
    }

    func draw(in context: CGContext, rect: CGRect, position: TimeLineNodeView.NodePosition, orientation: TimeLineNodeView.Orientation) {
        if let image = self.image {
            image.draw(in: rect)
        }
    }
}

class TimeLineTriangleNode: TimeLineBaseNode {
    var color: UIColor = .black
    var size = CGSize(width: 3, height: 3)

    init(color: UIColor, size: CGSize) {
        self.color = color
        self.size = size
    }

    init() {}

    func draw(in context: CGContext, rect: CGRect, position: TimeLineNodeView.NodePosition, orientation: TimeLineNodeView.Orientation) {
        context.setFillColor(self.color.cgColor)
        let path = CGMutablePath()
   
        if orientation == .vertical {
            if position == .start {
                path.move(to: CGPoint(x: rect.midX, y: rect.minY))
                path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
                path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            } else {
                path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
                path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
                path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
            }
        } else {
            if position == .start {
                path.move(to: CGPoint(x: rect.minX, y: rect.midY))
                path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
                path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            } else {
                path.move(to: CGPoint(x: rect.maxX, y: rect.midY))
                path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
                path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
            }
        }

        path.closeSubpath()
        context.addPath(path)
        context.fillPath()
    }
}

class TimeLineDiamondNode: TimeLineBaseNode {
    var color: UIColor = .black
    var size = CGSize(width: 3, height: 3)

    init(color: UIColor, size: CGSize) {
        self.color = color
        self.size = size
    }

    init() {}

    func draw(in context: CGContext, rect: CGRect, position: TimeLineNodeView.NodePosition, orientation: TimeLineNodeView.Orientation) {
        context.setFillColor(self.color.cgColor)
        let path = CGMutablePath()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        path.closeSubpath()
        context.addPath(path)
        context.fillPath()
    }
}

class TimeLineOpenArrowNode: TimeLineBaseNode {
    var color: UIColor = .black
    var size = CGSize(width: 3, height: 3)
    var lineWidth: CGFloat?

    init(color: UIColor, size: CGSize) {
        self.color = color
        self.size = size
    }

    init() {}

    func draw(in context: CGContext, rect: CGRect, position: TimeLineNodeView.NodePosition, orientation: TimeLineNodeView.Orientation) {
        context.setStrokeColor(self.color.cgColor)
        let width = self.lineWidth ?? max(1.0, min(min(rect.width, rect.height) * 0.05, 0.0))
        context.setLineWidth(width)

        let path = CGMutablePath()

        if orientation == .vertical {
            if position == .start {
                path.move(to: CGPoint(x: rect.minX, y: rect.midY))
                path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
                path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
            } else {
                path.move(to: CGPoint(x: rect.minX, y: rect.midY))
                path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
                path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
            }
        } else {
            if position == .start {
                path.move(to: CGPoint(x: rect.midX, y: rect.minY))
                path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
                path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
            } else {
                path.move(to: CGPoint(x: rect.midX, y: rect.minY))
                path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
                path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
            }
        }
        context.addPath(path)
        context.strokePath()
    }
}

class TimeLineTailArrowNode: TimeLineBaseNode {
    var color: UIColor = .black
    var size = CGSize(width: 3, height: 3)

    init(color: UIColor, size: CGSize) {
        self.color = color
        self.size = size
    }

    init() {}

    func draw(in context: CGContext, rect: CGRect, position: TimeLineNodeView.NodePosition, orientation: TimeLineNodeView.Orientation) {
        context.setStrokeColor(self.color.cgColor)

        let path = CGMutablePath()

        if orientation == .vertical {
            if position == .start {
                path.move(to: CGPoint(x: rect.midX, y: rect.minY))
                path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
                path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY - rect.height / 4))
                path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
                path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
            } else {
                path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
                path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
                path.addLine(to: CGPoint(x: rect.midX, y: rect.minY + rect.height / 4))
                path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
                path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
            }
        } else {
            if position == .start {
                path.move(to: CGPoint(x: rect.minX, y: rect.midY))
                path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
                path.addLine(to: CGPoint(x: rect.maxX - rect.width / 4, y: rect.midY))
                path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
                path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
            } else {
                path.move(to: CGPoint(x: rect.maxX, y: rect.midY))
                path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
                path.addLine(to: CGPoint(x: rect.minX + rect.width / 4, y: rect.midY))
                path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
                path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
            }
        }
        path.closeSubpath()
        context.addPath(path)
        context.fillPath()
    }
}
