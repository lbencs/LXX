//
//  LinkedList.swift
//  Arithmetic
//
//  Created by lben on 2021/4/16.
//

import Foundation
/**
 单链表 -> 双向链表
 */
class LinkedList<T>: CustomStringConvertible {
    // Node
    class Node<T> {
        var value: T
        init(value: T) {
            self.value = value
        }

        var next: Node<T>?
    }

    private var _head: Node<T>?
    private var _tail: Node<T>?

    var head: Node<T>? { _head }
    var tail: Node<T>? { _tail }

    private(set) var count: Int = 0

    var isEmpty: Bool { _head == nil }

    func empty() {
        while head != nil {
            removeHead()
        }
        count = 0
    }

    func insertTo(head value: T) {
        defer {
            count += 1
        }
        let node = Node<T>(value: value)
        if _head == nil {
            _head = node
            _tail = node
            return
        }
        node.next = _head
        _head = node
    }

    func headValue() -> T? {
        return _head?.value
    }

    @discardableResult
    func removeHead() -> T? {
        defer {
            count -= 1
        }
        let node = _head
        if _head === _tail {
            _head = nil
            _tail = nil
        } else {
            _head = _head?.next
        }
        return node?.value
    }

    func insertTo(tail value: T) {
        defer {
            count += 1
        }
        let node = Node<T>(value: value)
        if _head == nil {
            _head = node
            _tail = node
            return
        }
        _tail?.next = node
        _tail = node
    }

    func reverse() {
        var next = _head?.next
        _head?.next = nil
        while next != nil {
            let tmp = next?.next
            next?.next = _head
            _head = next
            next = tmp
        }
    }

    var description: String {
        var res: String = "["
        var p = head
        while let q = p {
            res.append("\(q.value),")
            p = q.next
        }
        res.append("]")
        return res
    }
}

extension LinkedList {
    func findKthFromEnd(_ k: Int) -> T? {
        var former = head
        var latter = head
        var k = k - 1
        while k > 0, latter != nil {
            latter = latter?.next
            k -= 1
        }
        while latter?.next != nil {
            former = former?.next
            latter = latter?.next
        }
        return former?.value
    }
}
