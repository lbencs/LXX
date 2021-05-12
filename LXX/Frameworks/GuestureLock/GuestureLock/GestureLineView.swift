//
//  OOOGestureView.swift
//  OOOUnlock_swift
//
//  Created by lbencs on 2/23/16.
//  Copyright © 2016 lbencs. All rights reserved.
//

import UIKit
import XX

class GestureLineView: UIView {
    var endPoint: CGPoint! = .zero
    let lock: NSLock = NSLock()
    var path: Drawable?
    let pathLayer = ShapeLayer()

    var selected: [TouchPoint] = []
    var touchPoints: [TouchPoint]?

    var touchesBegan = Delegate<Void, Void>()
    var touchesEnd = Delegate<Void, [Int]>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.addSublayer(pathLayer)
        pathLayer.strokeColor = UIColor.blue.cgColor
        pathLayer.fillColor = backgroundColor?.cgColor
        pathLayer.generateGrapha.delegate(on: self) { (self, _) -> Drawable? in
            self.path
        }
    }

    func render(statys: TouchPointStatus) {
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch: UITouch = touches.first {
            endPoint = touch.location(in: self)
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            super.touchesMoved(touches, with: event)
            return
        }
        endPoint = touch.location(in: self)
        for touchPoint in touchPoints! {
            let inRect = convert(touchPoint.frame, to: self)
            if !selected.contains(where: { $0.value == touchPoint.value }), inRect.contains(endPoint) {
                selected.append(touchPoint)
                touchPoint.renderWith(status: .selected)
                break
            }
        }
        var points = selected.map({ $0.frame.center })
        points.append(endPoint)
        path = BrokenLine(points: points, width: 8)
        pathLayer.draw()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        selected = []
//        path = BrokenLine(points: [], width: 8)
//        pathLayer.draw()
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        selected = []
//        path = BrokenLine(points: [], width: 8)
//        pathLayer.draw()
    }
}
