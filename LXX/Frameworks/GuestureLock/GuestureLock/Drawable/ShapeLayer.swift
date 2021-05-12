//
//  ShapeLayer.swift
//  GuestureLock
//
//  Created by lben on 2021/1/21.
//

import UIKit
import XX

class ShapeLayer: CAShapeLayer {
    private var closure: (() -> Drawable?)?

    let generateGrapha = Delegate<ShapeLayer, Drawable?>()

    override init() {
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // TODO: #lben -  为什么要实现这个初始化方法
    override init(layer: Any) {
        super.init(layer: layer)
    }

    override var frame: CGRect {
        didSet {
            draw()
        }
    }

    func draw() {
        guard let bezierPath = generateGrapha(self)?.draw() else {
            path = nil
            return
        }
        //
        switch bezierPath.lineCapStyle {
        case .butt: lineCap = .butt
        case .round: lineCap = .round
        case .square: lineCap = .square
        @unknown default: fatalError()
        }
        //
        switch bezierPath.lineJoinStyle {
        case .bevel: lineJoin = .bevel
        case .miter: lineJoin = .miter
        case .round: lineJoin = .round
        @unknown default: fatalError()
        }
        lineWidth = bezierPath.lineWidth
        path = bezierPath.cgPath
    }
}
