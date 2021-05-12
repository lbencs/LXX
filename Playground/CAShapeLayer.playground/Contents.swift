//: A UIKit based Playground for presenting user interface

import PlaygroundSupport
import UIKit

public extension CGRect {
    var center: CGPoint { .init(x: minX + width / 2.0, y: minY + height / 2.0) }
    var leftTop: CGPoint { return .init(x: minX, y: minY) }
    var rightTop: CGPoint { return .init(x: maxX, y: minY) }
    var leftBottom: CGPoint { return .init(x: minX, y: maxY) }
    var rightBottom: CGPoint { .init(x: maxX, y: maxY) }
}

class GraphicView: UIView {
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.move(to: rect.leftTop)
        context.addLine(to: rect.rightBottom)
        context.setLineWidth(2)
        UIColor.red.set()
        context.strokePath()
    }
}

class CAShapeView: UIView {
    let shapeLayer = CAShapeLayer()
    init() {
        super.init(frame: .zero)
        _makeup()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    func _makeup() {
        layer.addSublayer(shapeLayer)
        shapeLayer.backgroundColor = UIColor.blue.cgColor
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.fillColor = UIColor.yellow.cgColor
        shapeLayer.lineWidth = 2.0
    }

    override var frame: CGRect {
        didSet {
            guard frame != .zero else { return }
            guard frame != oldValue else { return }
            let path = UIBezierPath()
            path.move(to: frame.leftTop)
            path.addLine(to: frame.rightBottom)
            shapeLayer.path = path.cgPath
            shapeLayer.frame = layer.bounds
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        shapeLayer.frame = layer.bounds
    }
}









class MyViewController: UIViewController {
    override func loadView() {
        let label = CAShapeView()
        label.frame = CGRect(x: 150, y: 200, width: 200, height: 200)
        view = label
    }
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
