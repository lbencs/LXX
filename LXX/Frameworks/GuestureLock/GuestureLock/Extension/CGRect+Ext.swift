//
//  CGRect+Ext.swift
//  GuestureLock
//
//  Created by lben on 2021/1/21.
//

import UIKit

public extension CGRect {
    var center: CGPoint { .init(x: minX + width / 2.0, y: minY + height / 2.0) }
    var leftTop: CGPoint { return .init(x: minX, y: minY) }
    var rightTop: CGPoint { return .init(x: maxX, y: minY) }
    var leftBottom: CGPoint { return .init(x: minX, y: maxY) }
    var rightBottom: CGPoint { .init(x: maxX, y: maxY) }
}
