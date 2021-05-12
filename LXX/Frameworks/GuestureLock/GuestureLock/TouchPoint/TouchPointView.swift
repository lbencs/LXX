//
//  OOOTouchPoint.swift
//  OOOUnlock_swift
//
//  Created by lbencs on 2/23/16.
//  Copyright © 2016 lbencs. All rights reserved.
//

import UIKit

open class TouchPointView: UIView, TouchPoint {
    let cycleLayer = ShapeLayer()

    let cycleCenterLayer = ShapeLayer()

    var cycleColor: Color<TouchPointStatus> = [
        .normal: .lightGray,
        .selected: .blue,
        .error: .red
    ]

    public let value: Int

    open func renderWith(status: TouchPointStatus) {
        cycleLayer.strokeColor = cycleColor(status)?.cgColor
        cycleLayer.fillColor = backgroundColor?.cgColor
        cycleCenterLayer.fillColor = cycleColor(status)?.cgColor
        cycleLayer.draw()
        cycleCenterLayer.draw()
    }

    public init(value: Int) {
        self.value = value
        super.init(frame: .zero)
        makeup()
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func makeup() {
        backgroundColor = .white
        cycleLayer.generateGrapha.delegate(on: self, block: { (_, layer) -> Drawable? in
            Cycle(center: layer.frame.center, radius: layer.frame.width / 2.0, width: 2)
        })
        cycleCenterLayer.generateGrapha.delegate(on: self, block: { (_, layer) -> Drawable? in
            SolidCircle(center: layer.frame.center, radius: 10)
        })

        layer.addSublayer(cycleLayer)
        layer.addSublayer(cycleCenterLayer)
    }

    open override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        cycleLayer.frame = self.layer.bounds
        cycleCenterLayer.frame = self.layer.bounds
    }
}
