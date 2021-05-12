//
//  LinkedList.swift
//  LXX
//
//  Created by lben on 2021/2/25.
//

import Foundation

class LinkedList<Value: Equatable> {
    var head: Node<Value>?
    var tail: Node<Value>?

    init() {}

    convenience init(values: [Value]) {
        self.init()
        values.forEach { value in
            insetTail(value: value)
        }
    }

    func insetTail(value: Value) {
        let node = Node(value)
        if tail == nil {
            // 空链表
            head = node
            tail = node
        } else {
            tail?.next = node
            tail = node
        }
    }

    func values() -> [Value] {
        var values: [Value] = []
        var node = head
        while let n = node {
            values.append(n.value)
            node = node?.next
        }
        return values
    }
}
