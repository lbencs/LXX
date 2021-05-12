//
//  LRU.swift
//  Arithmetic
//
//  Created by lben on 2021/4/19.
//

import Foundation

protocol LRUCacheValueable {
    associatedtype Key: Hashable
    associatedtype Value
    var key: Key { get }
    var value: Value { get }
}

class LRUCache<T: LRUCacheValueable> {
    private struct Value {
        let key: String
        let value: String
    }

    var maxCount: Int = 100
    typealias Node = DoublyLinkedList<T>.Node<T>
    typealias LinkedList = DoublyLinkedList<T>

    private var _lock = NSLock()
    private var _map: [T.Key: Node] = [:]
    private var _linkedList = LinkedList()

    private var _isFull: Bool {
        return _map.count >= 100
    }

    private func _removeOldest() {
        if let value = _linkedList.removeLast() {
            _map.removeValue(forKey: value.key)
        }
    }

    private func _insertValueToHead(value: T) {
        let node = Node(value: value)
        _map[value.key] = node
        _linkedList.insertToHead(node)
    }

    private func _moveNodeToHead(node: Node) {
        _linkedList.moveToHead(node)
    }

    func save(value: T) {
        _lock.lock(); defer { _lock.unlock() }
        if _isFull { _removeOldest() }
        _insertValueToHead(value: value)
    }

    func value(for key: T.Key) -> T? {
        // TODO: #lben -  可以优化，将读与更新分割开来
        // 将map 与链表的异步独立开来
        _lock.lock(); defer { _lock.unlock() }
        if let node = _map[key] {
            _moveNodeToHead(node: node)
            return node.value
        }
        return nil
    }
}
