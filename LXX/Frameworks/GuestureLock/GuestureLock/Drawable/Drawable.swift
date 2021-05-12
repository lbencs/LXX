//
//  Drawable.swift
//  GuestureLock
//
//  Created by lben on 2021/1/21.
//

import UIKit



protocol Drawable {
    func draw() -> UIBezierPath
}

struct BrokenLine: Drawable {
    let points: [CGPoint]
    let width: CGFloat
    
    func draw() -> UIBezierPath {
        let content = UIBezierPath()
        var points = self.points
        guard let first = points.popFirst() else { return content }
        content.move(to: first)
        for point in points {
            content.addLine(to: point)
        }
        content.lineWidth = width
        content.lineJoinStyle = .round
        content.lineCapStyle = .round
        return content
    }
}

struct Line: Drawable {
    var start: CGPoint
    var end: CGPoint
    var color: UIColor
    var width: CGFloat

    func draw() -> UIBezierPath {
        let content = UIBezierPath()
        content.move(to: start)
        content.addLine(to: end)
        content.lineWidth = width
        color.setStroke()
        content.stroke()
        return content
    }
}

struct SolidCircle: Drawable {
    var center: CGPoint
    var radius: CGFloat

    func draw() -> UIBezierPath {
        let content = UIBezierPath()
        content.addArc(withCenter: center, radius: radius, startAngle: 0, endAngle: .pi * 2, clockwise: true)
        content.close()
        return content
    }
}

struct Cycle: Drawable {
    var center: CGPoint
    var radius: CGFloat
    var width: CGFloat

    func draw() -> UIBezierPath {
        let content = UIBezierPath()
        content.addArc(withCenter: center, radius: radius, startAngle: 0, endAngle: .pi * 2, clockwise: true)
        content.lineWidth = width
        content.close()
        return content
    }
}

struct Grapha: Drawable, Equatable {
    var drawers: [Drawable] = []

    mutating func add(_ drawer: Drawable) {
        drawers.append(drawer)
    }

    func draw() -> UIBezierPath {
        return drawers
            .map({ $0.draw() })
            .reduce(UIBezierPath()) { res, path in
                res.append(path)
                return res
            }
    }

    static func == (lhs: Grapha, rhs: Grapha) -> Bool {
        guard lhs.drawers.count == rhs.drawers.count else {
            return false
        }
        return lhs.draw() == rhs.draw()
    }
}
