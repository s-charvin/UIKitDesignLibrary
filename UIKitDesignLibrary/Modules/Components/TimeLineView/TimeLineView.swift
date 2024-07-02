//
//  TimeLineView.swift
//  EventPage
//
//  Created by scw on 2024/1/19.
//

import UIKit
import SnapKit
enum TimeLineViewType: Int {
    case all
    case bottom
    case top
    case none
}

enum TimeLineOrientation: Int {
    case horizontal
    case vertical
}

class TimeLineView: UIView {
    var type: TimeLineViewType = .none // 节点类型, 顶部, 中部, 底部
    var orientation: TimeLineOrientation = .vertical

    var lineColor: UIColor = .init(red: 220 / 255, green: 231 / 255, blue: 255 / 255, alpha: 1.0) // 连接线颜色
    var lineWidth: CGFloat = 2 // 连接线宽度

    var nodeBackgroundColor: UIColor = .white // 节点背景
    var nodeColor: UIColor = .init(red: 65 / 255, green: 129 / 255, blue: 254 / 255, alpha: 1.0) // 节点颜色
    var nodeBorderWidth: CGFloat = 2 // 节点线宽
    var nodeOffset: CGFloat? // 节点相对父节点或顶部的距离偏移
    var nodeGap: CGFloat = 0 // 节点与连接线的缝隙
    var nodeImage: UIImage? // 节点底图

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawWithFrame(frame: bounds)
    }

    private func drawLineInFrame(frame: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()
        let path = UIBezierPath(rect: frame)
        UIColor.black.setStroke()  // Assume black color for simplicity, adjust as needed
        path.stroke()
        context?.restoreGState()
    }

    private func drawNodeAtPosition(position: CGPoint, size: CGSize, frame: CGRect) {
        if let nodeImage = self.nodeImage {
            let imageRect = CGRect(origin: position, size: size)
            nodeImage.draw(in: imageRect)
        } else {
            let nodeRect = CGRect(origin: position, size: size)
            let nodePath = UIBezierPath(ovalIn: nodeRect)
            if self.nodeBorderWidth > 0 {
                nodePath.lineWidth = self.nodeBorderWidth
                self.nodeColor.setStroke()
                nodePath.stroke()
            } else {
                self.nodeColor.setFill()
                nodePath.fill()
            }
        }
    }

    private func drawWithFrame(frame: CGRect) {
        let nodeOffsetValue = calculateNodeOffset(frame: frame)
        let linePosition = calculateLinePosition(frame: frame)

        switch self.type {
        case .bottom:
            drawBottomLines(frame: frame, nodeOffsetValue: nodeOffsetValue, linePosition: linePosition)
        case .top:
            drawTopLines(frame: frame, nodeOffsetValue: nodeOffsetValue, linePosition: linePosition)
        case .all:
            drawAllLines(frame: frame, nodeOffsetValue: nodeOffsetValue, linePosition: linePosition)
        case .none:
            break
        }

        drawNode(frame: frame, nodeOffsetValue: nodeOffsetValue)
    }

    private func calculateNodeOffset(frame: CGRect) -> CGFloat {
        return self.nodeOffset ?? (self.orientation == .vertical ? frame.height / 2.0 : frame.width / 2.0)
    }

    private func calculateLinePosition(frame: CGRect) -> (x: CGFloat, y: CGFloat) {
        let lineY = (frame.height - self.lineWidth) / 2.0
        let lineX = (frame.width - self.lineWidth) / 2.0
        return (lineX, lineY)
    }

    private func drawBottomLines(frame: CGRect, nodeOffsetValue: CGFloat, linePosition: (x: CGFloat, y: CGFloat)) {
        if self.orientation == .horizontal {
            drawLineInFrame(frame: CGRect(
                x: nodeOffsetValue + self.nodeGap + frame.height / 2.0,
                y: linePosition.y,
                width: frame.width - (nodeOffsetValue + self.nodeGap + frame.height / 2.0),
                height: self.lineWidth
            ))
        } else {
            drawLineInFrame(frame: CGRect(
                x: linePosition.x,
                y: nodeOffsetValue + self.nodeGap + frame.width / 2.0,
                width: self.lineWidth,
                height: frame.height - (nodeOffsetValue + self.nodeGap + frame.width / 2.0)
            ))
        }
    }

    private func drawTopLines(frame: CGRect, nodeOffsetValue: CGFloat, linePosition: (x: CGFloat, y: CGFloat)) {
        if self.orientation == .horizontal {
            drawLineInFrame(frame: CGRect(
                x: 0,
                y: linePosition.y,
                width: nodeOffsetValue - self.nodeGap - frame.height / 2.0,
                height: self.lineWidth
            ))
        } else {
            drawLineInFrame(frame: CGRect(
                x: linePosition.x,
                y: 0,
                width: self.lineWidth,
                height: nodeOffsetValue - self.nodeGap - frame.width / 2.0
            ))
        }
    }

    private func drawAllLines(frame: CGRect, nodeOffsetValue: CGFloat, linePosition: (x: CGFloat, y: CGFloat)) {
        drawTopLines(frame: frame, nodeOffsetValue: nodeOffsetValue, linePosition: linePosition)
        drawBottomLines(frame: frame, nodeOffsetValue: nodeOffsetValue, linePosition: linePosition)
    }

    private func drawNode(frame: CGRect, nodeOffsetValue: CGFloat) {
        let nodePosition = CGPoint(
            x: self.orientation == .vertical ? 0 : nodeOffsetValue - frame.width / 2.0,
            y: self.orientation == .vertical ? nodeOffsetValue - frame.height / 2.0 : 0)
        let nodeSize = CGSize(
            width: self.orientation == .vertical ? frame.width : frame.height,
            height: self.orientation == .vertical ? frame.width : frame.height)
        drawNodeAtPosition(position: nodePosition, size: nodeSize, frame: frame)
    }

    private func drawLine(frame: CGRect) {
        let rectanglePath = UIBezierPath(rect: frame)
        self.lineColor.setFill()
        rectanglePath.fill()
    }
}
