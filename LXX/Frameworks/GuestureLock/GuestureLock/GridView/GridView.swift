//
//  GridView.swift
//  GuestureLock
//
//  Created by lben on 2021/1/21.
//

import UIKit

open class GridView: UIView {
    let touchPoints: [TouchPoint]

    public init(touchPoints: [TouchPoint]) {
        self.touchPoints = touchPoints.sorted(by: { $0.value < $1.value })
        super.init(frame: .zero)

        makeup()
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override open func layoutSubviews() {
        super.layoutSubviews()
        let spaceWidth: CGFloat = (frame.width - kTouchPointSize * 3) / 2.0
        for (index, element) in touchPoints.enumerated() {
            let x: CGFloat = (CGFloat)(index % 3) * spaceWidth + (CGFloat)(index % 3) * kTouchPointSize
            let y: CGFloat = (CGFloat)(index / 3) * spaceWidth + (CGFloat)(index / 3) * kTouchPointSize
            element.frame = CGRect(x: x, y: y, width: kTouchPointSize, height: kTouchPointSize)
            element.renderWith(status: .normal)
        }
    }

    func makeup() {
        for point in touchPoints {
            addSubview(point)
        }
        backgroundColor = .white
    }
}
