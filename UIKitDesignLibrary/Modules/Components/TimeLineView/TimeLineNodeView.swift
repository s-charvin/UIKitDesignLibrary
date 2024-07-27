import UIKit


class TimeLineNodeView: UIView {
    enum Orientation {
        case vertical
        case horizontal
    }

    enum NodePosition {
        case start
        case end
        case none
    }

    var orientation: Orientation = .horizontal

    var line: TimeLineBaseLine? // = TimeLineDashedLine()
    var node: TimeLineBaseNode? // = CircleNode()

    var nodePosition: NodePosition = .start
    var gap: CGFloat = 4

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = .clear
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else { return }

        // Draw Node
        if let node = self.node {
            let nodeRect = self.getNodeRect(in: rect)
            node.draw(in: context, rect: nodeRect, position: self.nodePosition, orientation: self.orientation)
        }

        // Draw Line
        if let line = self.line {
            let lineRect = self.getLineRect(in: rect)
            line.draw(in: context, rect: lineRect, orientation: self.orientation)
        }
    }

    private func getLineRect(in rect: CGRect) -> CGRect {
        var lineRect: CGRect = .zero
        guard let node = self.node else { return lineRect }

        if self.orientation == .vertical {
            lineRect = CGRect(
                x: rect.minX,
                y: self.nodePosition == .start ? rect.minY + node.size.height + self.gap : rect.minY,
                width: rect.width,
                height: rect.height - node.size.height - self.gap
            )
        } else {
            lineRect = CGRect(
                x: self.nodePosition == .start ? rect.minX + node.size.width + self.gap : rect.minX,
                y: rect.minY,
                width: rect.width - node.size.width - self.gap,
                height: rect.height
            )
        }
        return lineRect
    }

    private func getNodeRect(in rect: CGRect) -> CGRect {
        var nodeRect: CGRect = .zero
        guard let node = self.node else { return nodeRect }

        switch self.nodePosition {
        case .start:
            if self.orientation == .vertical {
                nodeRect = CGRect(
                    x: rect.midX - node.size.width / 2,
                    y: self.nodePosition == .start ? rect.minY : rect.maxY - node.size.height,
                    width: node.size.width,
                    height: node.size.height
                )
            } else {
                nodeRect = CGRect(
                    x: self.nodePosition == .start ? rect.minX : rect.maxX - node.size.width,
                    y: rect.midY - node.size.height / 2,
                    width: node.size.width,
                    height: node.size.height
                )
            }
        case .end:
            if self.orientation == .vertical {
                nodeRect = CGRect(
                    x: rect.midX - node.size.width / 2,
                    y: self.nodePosition == .start ? rect.minY : rect.maxY - node.size.height,
                    width: node.size.width,
                    height: node.size.height
                )
            } else {
                nodeRect = CGRect(
                    x: self.nodePosition == .start ? rect.minX : rect.maxX - node.size.width,
                    y: rect.midY - node.size.height / 2,
                    width: node.size.width,
                    height: node.size.height
                )
            }
        case .none:
            break
        }
        return nodeRect
    }
}
