//
//  OOOUnlockView.swift
//  OOOUnlock_swift
//
//  Created by lbencs on 2/23/16.
//  Copyright © 2016 lbencs. All rights reserved.
//

import UIKit

let kWindowWidth = UIApplication.shared.windows[0].frame.size.width
let kTouchPointSize: CGFloat = 70.0

open class _GestureLockView<T: TouchPoint>: UIView {
}

protocol GestureLockViewDelegate {
    func lockView(_ lockView: GestureLockView, didFinishedSelected numbers: [Int])
}

open class GestureLockView: UIView {
    let gridView: GridView
    let gestureView: GestureLineView

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public init(gridView aGridView: GridView) {
        gridView = aGridView
        gestureView = GestureLineView()
        super.init(frame: .zero)
        gestureView.touchPoints = gridView.touchPoints
        makeup()
    }

    func render(to status: TouchPointStatus) {
        gestureView.render(statys: status)
    }

    override open var frame: CGRect {
        didSet { setNeedsDisplay() }
    }

    override open func layoutSubviews() {
        super.layoutSubviews()
        gridView.frame = bounds
        gestureView.frame = gridView.bounds
    }

    // MARK: - Private

    private func makeup() {
        gestureView.insertSubview(gridView, at: 0)
        addSubview(gestureView)
    }
}
