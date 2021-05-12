//
//  DoublyLinkedList.swift
//  Arithmetic
//
//  Created by lben on 2021/4/19.
//

import Foundation

class DoublyLinkedList<T>: CustomStringConvertible {
    class Node<T> {
        let value: T
        init(value aValue: T) {
            value = aValue
        }

        var next: Node<T>?
        var prev: Node<T>?
    }

    private var _head: Node<T>?
    private var _tail: Node<T>?

    var head: Node<T>? { _head }
    var tail: Node<T>? { _tail }

    var isEmpty: Bool { _head == nil }
    var last: T? { _tail?.value }
    var first: T? { _head?.value }

    @discardableResult
    func removeLast() -> T? {
        guard let tail = _tail, _head !== _tail else {
            _head = nil
            _tail = nil
            return nil
        }
        _tail = tail.prev
        _tail?.next = nil
        tail.prev = nil
        tail.next = nil
        return tail.value
    }

    @discardableResult
    func removeFirst() -> T? {
        guard let head = _head else {
            return nil
        }
        _head = head.next
        _head?.prev = nil
        head.next = nil
        return head.value
    }

    func insertToHead(_ node: Node<T>) {
        if _head == nil {
            _head = node
            _tail = node
            return
        }
        _head?.prev = node
        node.next = _head
        _head = node
    }

    func appendToTail(_ value: T) {
        appendToTail(.init(value: value))
    }

    func appendToTail(_ node: Node<T>) {
        guard !isEmpty else {
            insertToHead(node)
            return
        }
        node.next = nil
        node.prev = tail
        tail?.next = node
        _tail = node
    }

    func moveToHead(_ node: Node<T>) {
        node.prev?.next = node.next
        node.next?.prev = node.prev
        node.next = nil
        node.prev = nil
        insertToHead(node)
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

extension DoublyLinkedList: Sequence {
    func makeIterator() -> some IteratorProtocol {
        return [Element]().makeIterator()
    }
}
