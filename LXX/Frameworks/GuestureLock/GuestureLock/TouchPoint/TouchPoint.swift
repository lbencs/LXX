//
//  Point.swift
//  GuestureLock
//
//  Created by lben on 2021/1/19.
//

import UIKit

/// Status
public enum TouchPointStatus {
    case normal
    case selected
    case error
}

public protocol TouchPoint: UIView {
    var value: Int { get }
    func renderWith(status: TouchPointStatus)
}
