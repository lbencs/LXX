//
//  Draw.swift
//  POPDemo
//
//  Created by lben on 2021/4/13.
//

import UIKit

protocol Render {
    func move(to point: CGPoint)
    func addLine(to point: CGPoint)
    func addArc(center: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat, clockwise: Bool)
}

extension CGContext: Render {}

struct TestRender: Render {
    func move(to point: CGPoint) {}
    func addLine(to point: CGPoint) {}
    func addArc(center: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat, clockwise: Bool) {}
}

protocol Drawble {
    func draw(render: Render)
}

struct Polygon: Drawble {
    var corners: [CGPoint] = []
    func draw(render: Render) {
        guard let latest = corners.last else { return }
        render.move(to: latest)
        for p in corners {
            render.addLine(to: p)
        }
    }
}

struct Diagram: Drawble {
    var elements: [Drawble] = []
    func draw(render: Render) {
        for ele in elements {
            ele.draw(render: render)
        }
    }
}

struct Cycle: Drawble {
    let center: CGPoint
    let radius: CGFloat
    func draw(render: Render) {
        render.move(to: center)
        render.addArc(center: center, radius: radius, startAngle: 0, endAngle: .pi * 2, clockwise: true)
    }
}

struct Line: Drawble {
    let start = CGPoint.zero
    let end = CGPoint(x: 0, y: 100)

    func draw(render: Render) {
        render.move(to: start)
        render.addLine(to: end)
    }
}
