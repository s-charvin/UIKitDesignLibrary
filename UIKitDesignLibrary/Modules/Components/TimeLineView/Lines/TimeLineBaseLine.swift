//
//  BaseLine.swift
//  UIKitDesignLibrary
//
//  Created by charvin on 2024/7/12.
//

import UIKit

protocol TimeLineBaseLine {
    var width: CGFloat { get set }
    func draw(in context: CGContext, rect: CGRect, orientation: TimeLineNodeView.Orientation)
}

class TimeLineDashedLine: TimeLineBaseLine {
    enum Position: Int {
        case bottom
        case top
        case middle
    }
    var width: CGFloat = 1
    var color: UIColor = .black
    var dashPattern: [CGFloat]?
    var position: Position = .middle

    init(width: CGFloat, color: UIColor, dashPattern: [CGFloat]? = nil) {
        self.color = color
        self.width = width
        self.dashPattern = dashPattern
    }

    init() {}

    func draw(in context: CGContext, rect: CGRect, orientation: TimeLineNodeView.Orientation) {
        var startPoint: CGPoint = .zero
        var endPoint: CGPoint = .zero

        switch self.position {
        case .bottom:
            if orientation == .horizontal {
                startPoint = CGPoint(x: rect.minX, y: rect.maxY - self.width / 2)
                endPoint = CGPoint(x: rect.maxX, y: rect.maxY - self.width / 2)
            } else if orientation == .vertical {
                startPoint = CGPoint(x: rect.minX + self.width / 2, y: rect.minY)
                endPoint = CGPoint(x: rect.minX + self.width / 2, y: rect.maxY)
            }
        case .top:
            if orientation == .horizontal {
                startPoint = CGPoint(x: rect.minX, y: rect.minY + self.width / 2)
                endPoint = CGPoint(x: rect.maxX, y: rect.minY + self.width / 2)
            } else if orientation == .vertical {
                startPoint = CGPoint(x: rect.minX + self.width / 2, y: rect.minY)
                endPoint = CGPoint(x: rect.minX + self.width / 2, y: rect.maxY)
            }
        case .middle:
            if orientation == .horizontal {
                startPoint = CGPoint(x: rect.minX, y: rect.midY)
                endPoint = CGPoint(x: rect.maxX, y: rect.midY)
            } else if orientation == .vertical {
                startPoint = CGPoint(x: rect.midX, y: rect.minY)
                endPoint = CGPoint(x: rect.midX, y: rect.maxY)
            }
        }
        
        context.setStrokeColor(self.color.cgColor)
        context.setLineWidth(self.width)
        if let dashPattern = self.dashPattern {
            context.setLineDash(phase: 0, lengths: dashPattern)
        }
        context.move(to: startPoint)
        context.addLine(to: endPoint)
        context.strokePath()
    }
}


class TimeLineGradientLine: TimeLineBaseLine {
    enum GradientDirection {
        case startToEnd
        case endToStart
    }

    var width: CGFloat = 1
    var colors: [UIColor] = [.red, .purple]
    var locations: [NSNumber] = [0, 1]
    var direction: GradientDirection = .startToEnd

    init(width: CGFloat, colors: [UIColor], locations: [NSNumber], direction: GradientDirection) {
        self.width = width
        self.colors = colors
        self.locations = locations
        self.direction = direction
    }

    init() {}

    func draw(in context: CGContext, rect: CGRect, orientation: TimeLineNodeView.Orientation) {
        var startPoint: CGPoint = .zero
        var endPoint: CGPoint = .zero
        var lineRect: CGRect = .zero
        if orientation == .horizontal {
            startPoint = CGPoint(x: rect.minX, y: rect.midY)
            endPoint = CGPoint(x: rect.maxX, y: rect.midY)
            lineRect = CGRect(
                x: startPoint.x,
                y: startPoint.y - self.width / 2,
                width: endPoint.x - startPoint.x,
                height: self.width
            )
        } else if orientation == .vertical {
            startPoint = CGPoint(x: rect.midX, y: rect.minY)
            endPoint = CGPoint(x: rect.midX, y: rect.maxY)
            lineRect = CGRect(
                x: startPoint.x - self.width / 2,
                y: startPoint.y,
                width: self.width,
                height: endPoint.y - startPoint.y
            )
        }

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = lineRect
        gradientLayer.colors = self.colors.map { $0.cgColor }
        gradientLayer.locations = self.locations

        switch self.direction {
        case .startToEnd:
            if orientation == .horizontal {
                gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
                gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
            } else {
                gradientLayer.startPoint = CGPoint(x: 0.5, y: 1)
                gradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
            }
        case .endToStart:
            if orientation == .horizontal {
                gradientLayer.startPoint = CGPoint(x: 1, y: 0.5)
                gradientLayer.endPoint = CGPoint(x: 0, y: 0.5)
            } else {
                gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
                gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
            }
        }
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        guard let gradientContext = UIGraphicsGetCurrentContext() else { return }
        gradientLayer.render(in: gradientContext)
        guard let gradientImage = UIGraphicsGetImageFromCurrentImageContext() else { return }
        UIGraphicsEndImageContext()

        if let cgImage = gradientImage.cgImage {
            context.clip(to: lineRect)
            context.draw(cgImage, in: lineRect)
        }
    }
}
