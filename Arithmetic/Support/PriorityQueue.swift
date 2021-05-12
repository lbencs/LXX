//
//  PriorityQueue.swift
//  Arithmetic
//
//  Created by lben on 2021/4/29.
//

import Foundation

public struct PriorityQueue<T> {
    fileprivate var _heap: Heap<T>

    public init(sort: @escaping (T, T) -> Bool) {
        _heap = Heap(sort: sort)
    }

    public init(queues: [T], sort: @escaping (T, T) -> Bool) {
        _heap = Heap(nodes: queues, sort: sort)
    }

    public var isEmpty: Bool { _heap.isEmpty }

    public var count: Int { _heap.count }
    public var peek: T? { _heap.peek }

    public mutating func enqueue(element: T) {
        _heap.insert(element)
    }

    @discardableResult
    public mutating func dequeue() -> T? {
        return _heap.remove()
    }

    public mutating func changePriority(index i: Int, value: T) {
        return _heap.replace(index: i, value: value)
    }
}
