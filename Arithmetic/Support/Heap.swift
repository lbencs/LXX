//
//  Heap.swift
//  Arithmetic
//
//  Created by lben on 2021/4/17.
//

import Foundation

public struct Heap<T> {
    public typealias Index = Int
    private var _nodes: [T] = []
    private let _orderCriteria: (_ lhs: T, _ rhs: T) -> Bool

    public init(sort: @escaping (_ lhs: T, _ rhs: T) -> Bool) {
        _orderCriteria = sort
    }

    public init(nodes: [T], sort: @escaping (_ lhs: T, _ rhs: T) -> Bool) {
        self.init(sort: sort)
        _heapify(nodes)
    }

    public var isEmpty: Bool { _nodes.isEmpty }
    public var count: Int { _nodes.count }
    public var peek: T? { _nodes.first }

    public mutating func insert(_ value: T) {
        _nodes.append(value)
        _shiftUp(count - 1)
    }

    public mutating func insert<S: Sequence>(_ sequence: S) where S.Iterator.Element == T {
        isEmpty ? _heapify(sequence) : sequence.forEach({ self.insert($0) })
    }

    @discardableResult
    public mutating func remove() -> T? {
        return remove(at: 0)
    }

    @discardableResult
    public mutating func remove(at index: Int) -> T? {
        guard index < count else { return nil }
        defer {
            _nodes[index] = _nodes[count - 1]
            _nodes.removeLast()
            _shiftDown(from: index, until: count - 1)
        }
        return _nodes[index]
    }

    public mutating func replace(index: Int, value: T) {
        guard index < count else { return }
        remove(at: index)
        insert(value)
    }

    // MARK: - private

    private mutating func _heapify<S: Sequence>(_ sequence: S) where S.Iterator.Element == T {
        _nodes = Array(sequence)
        // 从第一个非叶子节点开始向下调整
        // 每次调整局部生成一个堆
        for i in stride(from: (count - 1).parent, through: 0, by: -1) {
            _shiftDown(i)
        }
    }

    private mutating func _shiftDown(_ index: Index) {
        _shiftDown(from: index, until: count - 1)
    }

    private mutating func _shiftDown(from startIndex: Index, until endIndex: Index) {
        guard startIndex < endIndex else { return }
        var lc = startIndex.leftChild
        let rc = lc + 1

        if rc <= endIndex && _orderCriteria(_nodes[rc], _nodes[lc]) {
            lc = rc
        }
        if lc <= endIndex && _orderCriteria(_nodes[lc], _nodes[startIndex]) {
            _nodes.swapAt(lc, startIndex)
        }
        _shiftDown(from: lc, until: endIndex)
    }

    private mutating func _shiftUp(_ index: Index) {
        // 插入，如果小于父节点，必然小于兄弟节点
        var parent = index.parent
        var child = index
        let childValue = _nodes[child]
        while child > 0 && _orderCriteria(childValue, _nodes[parent]) {
            _nodes[child] = _nodes[parent]
            child = parent
            parent = child.parent
        }
        _nodes[child] = childValue
    }
}

// MARK: - Searching

extension Heap where T: Equatable {
    public func index(of node: T) -> Int? {
        return _nodes.firstIndex(where: { $0 == node })
    }

    @discardableResult
    public mutating func remove(node: T) -> T? {
        if let index = index(of: node) {
            return remove(at: index)
        }
        return nil
    }
}
