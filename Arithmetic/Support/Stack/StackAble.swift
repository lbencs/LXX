//
//  StackAble.swift
//  Arithmetic
//
//  Created by lben on 2021/4/30.
//

import Foundation

protocol StackAble {
    associatedtype T
    func peek() -> T?
    var isEmpty: Bool { get }
    var count: Int { get }
    mutating func push(_ value: T)
    @discardableResult mutating func pop() -> T?
}

extension Array: StackAble {
    typealias T = Element
    func peek() -> Element? { last }
    mutating func push(_ value: Element) { append(value) }
    @discardableResult mutating func pop() -> Element? { isEmpty ? nil : removeLast() }
}
