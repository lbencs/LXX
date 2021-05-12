//
//  Node.swift
//  LXX
//
//  Created by lben on 2021/2/25.
//

import Foundation

final
class Node<Value: Equatable> {
    var value: Value

    var next: Node<Value>?
    var prev: Node<Value>?

    init(_ value: Value) {
        self.value = value
    }
}
