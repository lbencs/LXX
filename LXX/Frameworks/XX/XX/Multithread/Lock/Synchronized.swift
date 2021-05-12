//
//  synchronized.swift
//  LXX
//
//  Created by lben on 2021/2/8.
//

import Foundation

public func synchronized(_ obj: AnyObject, _ closure: () throws -> Void) rethrows {
    objc_sync_enter(obj)
    defer { objc_sync_exit(obj) }
    try closure()
}

@discardableResult
public func synchronized<T>(_ lock: AnyObject, _ body: () throws -> T) rethrows -> T {
    objc_sync_enter(lock)
    defer { objc_sync_exit(lock) }
    return try body()
}
