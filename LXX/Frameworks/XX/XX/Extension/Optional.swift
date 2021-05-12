//
//  Optional.swift
//  XX
//
//  Created by lben on 2021/4/12.
//

import Foundation

public protocol NilOrEmptyable {
    var isEmpty: Bool { get }
}

extension String: NilOrEmptyable {}
extension Array: NilOrEmptyable {}
extension Dictionary: NilOrEmptyable {}
extension Set: NilOrEmptyable {}

extension Optional where Wrapped: NilOrEmptyable {
    public var isNilOrEmpty: Bool {
        switch self {
        case let .some(value): return value.isEmpty
        default: return true
        }
    }
}
