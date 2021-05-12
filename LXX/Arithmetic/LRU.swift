//
//  LRU.swift
//  LXX
//
//  Created by lben on 2021/2/25.
//

import Foundation

class _Container<Key: Hashable, Value: Equatable> {
    struct ValueWapper: Equatable {
        let key: Key
        let value: Value
        static func == (lhs: Self, rhs: Self) -> Bool { lhs.key == rhs.key }
    }

    let capacity: Int = 5
    var cache: [Key: Node<ValueWapper>] = [:]
    var doublyLinkList = DoublyLinkedlist<ValueWapper>()

    func value(for key: Key) -> Value? {
        guard let node = cache[key] else {
            return nil
        }
        doublyLinkList.moveNodeToHead(node: node)
        arith_print("list: \(doublyLinkList.values().map({ $0.value }))")
        return node.value.value
    }

    func set(value: Value, for key: Key) {
        if let node = cache[key] {
            // update
            node.value = ValueWapper(key: key, value: value)
            doublyLinkList.moveNodeToHead(node: node)
            return
        }
        // append
        let node = Node(ValueWapper(key: key, value: value))
        if cache.count > capacity, let last = doublyLinkList.removeLatest() {
            // remove last
            cache.removeValue(forKey: last.value.key)
        }

        // add new
        cache[key] = node
        doublyLinkList.addToHead(node: node)

        arith_print("list: \(doublyLinkList.values().map({ $0.value }))")
    }
}

class LRUCache<Key: Hashable, Value: Equatable> {
    /*
     x 数组的问题： 移动次数过多
     x map
     链表，查找效率问题
     */

    let container = _Container<Key, Value>()

    func value(for key: Key) -> Value? {
        return container.value(for: key)
    }

    func set(value: Value, for key: Key) {
        container.set(value: value, for: key)
    }
}

