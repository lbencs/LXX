//
//  DoublyLinkedlist.swift
//  LXX
//
//  Created by lben on 2021/2/25.
//

import Foundation

class DoublyLinkedlist<Value: Equatable> {
    var head: Node<Value>?
    var tail: Node<Value>?

    func addToHead(node: Node<Value>) {
        node.prev = nil
        if let headNode = head {
            headNode.prev = node
            node.next = headNode
            head = node
        } else {
            head = node
            tail = node
        }
    }

    func remove(note: Node<Value>) {
        if note.value == head?.value {
            head = note.next
        }
        if note.value == tail?.value {
            tail = note.prev
        }
        note.prev?.next = note.next
        note.next?.prev = note.prev
        note.next = nil
        note.prev = nil
    }

    func removeLatest() -> Node<Value>? {
        guard let tailNode = tail else {
            return nil
        }

        guard let prev = tailNode.prev else {
            // 只有一个节点
            head = nil
            tail = nil
            tailNode.prev = nil
            tailNode.next = nil
            return tailNode
        }

        tailNode.prev = nil
        tailNode.next = nil
        prev.next = nil
        tail = prev
        return tailNode
    }

    func moveNodeToHead(node: Node<Value>) {
        remove(note: node)
        addToHead(node: node)
    }

    func values() -> [Value] {
        var node = head
        var result: [Value] = []
        while node != nil {
            if let value = node?.value {
                result.append(value)
            }
            node = node?.next
        }
        return result
    }
}
