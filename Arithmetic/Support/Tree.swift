//
//  Tree.swift
//  Arithmetic
//
//  Created by lben on 2021/4/16.
//

import Foundation

public class BinaryTree<T: Hashable> {
    typealias TreeNode = Node<T>
    private var _root: Node<T>?
    private var _tail: Node<T>?
    init(root: Node<T>) {
        _root = root
    }

    init<Queue: Sequence>(_ seq: Queue) where Queue.Element == T {
        for e in seq { insert(e) }
    }

    var root: Node<T>? { _root }
    private var _linkedList = LinkedList<Node<T>>()

    func insert(_ value: T) {
        let node = Node<T>(value: value)
        _linkedList.insertTo(tail: node)
        if _root == nil {
            _root = node
            return
        }
        while let r = _linkedList.head?.value {
            if r.left == nil {
                r.left = node
                break
            }
            if r.right == nil {
                r.right = node
                break
            }
            _linkedList.removeHead()
        }
    }

    static func isSameTree(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
        guard let lhs = p, let rhs = q else {
            return p == nil && q == nil
        }
        if lhs.value != rhs.value { return false }
        if !isSameTree(lhs.left, rhs.left) { return false }
        if !isSameTree(lhs.right, rhs.right) { return false }
        return true
    }

    // MARK: - height

    func height() -> Int { _depth_first_height_recursion(root) }
    func height2() -> Int { _depth_first_height() }
    func height3() -> Int {
        let list = NSMutableArray()
        _breadth_first_height_recursion(root, index: 1, list: list)
        let count = list.count
        return Int(ceil(log2(Double(count))))
    }
    func height4() -> Int {
        guard let _root = _root else {
            return 0
        }
        return _root.maxDepth()
    }

    func height5() -> Int { _breadth_first_height() }
    // 线索二叉树 Threaded
//    binary tree

    // MARK: - traversal

    func sequenceTraversal() -> [T] { _sequence(root) }
    func sequence() -> [T] {
        let arr = NSMutableArray()
        _sequenceByRecursion(root, index: 1, result: arr)
        return arr.filter({ !($0 is NSNull) }).compactMap({ ($0 as? Node<T>)?.value })
    }

    func postorderTraversal() -> [T] { _postorder(root) }
    func lrd() -> [T] { _LRD() }
    func preorderTraversal() -> [T] { _preorder(root) }
    func dlr() -> [T] { _DLR() }
    func inorderTraversal() -> [T] { _inorder(root) }
    func ldr() -> [T] { _LDR() }
}

// MARK: - Invert

extension BinaryTree {
    func invert() {
        guard let root = _root else { return }
        #if false
            var linkedList: [Node<T>] = []
            var p: Node<T>? = root
            var latestInvertNode: Node<T>?

            while p != nil || !linkedList.isEmpty {
                while let node = p {
                    linkedList.insert(node, at: 0)
                    p = node.left
                }
                if let node = linkedList.first {
                    if let right = node.right, right !== latestInvertNode {
                        linkedList.insert(right, at: 0)
                        p = right.left
                    } else {
                        let left = node.left
                        node.left = node.right
                        node.right = left
                        latestInvertNode = node
                        linkedList.removeFirst()
                    }
                }
            }
        #else
            var linkedList: [Node<T>] = [root]
            while !linkedList.isEmpty {
                let node = linkedList.removeFirst()
                let left = node.left
                node.left = node.right
                node.right = left

                if let node = node.left {
                    linkedList.insert(node, at: 0)
                }
                if let node = node.right {
                    linkedList.insert(node, at: 0)
                }
            }
        #endif
    }
}

// MARK: - Height

extension BinaryTree {
    struct _LevelWapper<NodeValue> {
        var level: Int
        var index: Int = 1
        let node: NodeValue
    }

    private func _breadth_first_height() -> Int {
        guard let root = _root else { return 0 }
        let linkedList = LinkedList<_LevelWapper<Node<T>>>()
        linkedList.insertTo(tail: _LevelWapper(level: 1, node: root))
        var height: Int = 1
        while let wapper = linkedList.removeHead() {
            if let left = wapper.node.left {
                let leftWapper = _LevelWapper(level: wapper.level + 1, node: left)
                linkedList.insertTo(tail: leftWapper)
                height = max(leftWapper.level, height)
            }
            if let right = wapper.node.right {
                let rightWapper = _LevelWapper(level: wapper.level + 1, node: right)
                linkedList.insertTo(tail: rightWapper)
                height = max(rightWapper.level, height)
            }
        }
        return height
    }

    private func _breadth_first_height_recursion(_ root: Node<T>?, index: Int, list: NSMutableArray) {
        guard let root = root else { return }
        if list.count < index {
            for i in list.count ..< index {
                list[i] = NSNull()
            }
        }
        _breadth_first_height_recursion(root.left, index: 2 * index, list: list)
        _breadth_first_height_recursion(root.right, index: 2 * index + 1, list: list)
    }

    private func _depth_first_height() -> Int {
        guard let root = _root else {
            return 0
        }
        let stack = Stack<Node<T>>()
        var map: [Node<T>: Int] = [:]

        var p: Node<T>? = root
        var level: Int = 1
        var maxLevel: Int = 1
        while p != nil || !stack.isEmpty {
            while let node = p {
                map[node] = level
                maxLevel = max(level, maxLevel)
                stack.push(node)
                p = node.left
                level = map[node]! + 1
            }
            if let top = stack.pop() {
                if let right = top.right {
                    p = right
                    level = map[top]! + 1
                }
            }
        }
        return maxLevel
    }

    private func _depth_first_height_recursion(_ root: Node<T>?) -> Int {
        guard let root = root else { return 0 }
        guard !root.isLeaf else { return 1 }
        return max(_depth_first_height_recursion(root.left), _depth_first_height_recursion(root.right)) + 1
    }
}

// MARK: - Order

extension BinaryTree {
    // MARK: sequence

    private func _sequenceByRecursion(_ root: Node<T>?, index: Int, result: NSMutableArray) {
        guard let root = root else {
            return
        }
        // 数组 -> index与二叉树的关系
        if result.count < index {
            // 数组占位
            for i in result.count ..< index {
                result[i] = NSNull()
            }
        }
        result[index] = root
        _sequenceByRecursion(root.left, index: 2 * index, result: result)
        _sequenceByRecursion(root.right, index: 2 * index + 1, result: result)
    }

    private func _sequence(_ root: Node<T>?) -> [T] {
        guard let root = root else { return [] }
        let linkedList = LinkedList<Node<T>>()
        linkedList.insertTo(tail: root)
        var res: [T] = [root.value]

        while let value = linkedList.removeHead() {
            if let left = value.left {
                linkedList.insertTo(tail: left)
                res.append(left.value)
            }
            if let right = value.right {
                linkedList.insertTo(tail: right)
                res.append(right.value)
            }
        }
        return res
    }

    // MARK: post order

    private func _LRD() -> [T] {
        // or
        // post-order = DRL反转
        let stack = Stack<Node<T>>()
        var p = _root
        var res: [T] = []
        // 哨兵对象
        var latestReadNode: Node<T>?

        while p != nil || !stack.isEmpty {
            while let node = p {
                stack.push(node)
                p = node.left
            }
            if let top = stack.top() {
                // 分为两种情况
                // 1. 子节点，直接pop
                // 2. 存在右孩子 -> 右孩子已读 or 未读两种情况
                if let right = top.right {
                    if let readed = latestReadNode, readed === right {
                        res.append(top.value)
                        latestReadNode = top
                        stack.pop()
                    } else {
                        stack.push(right)
                        p = right.left
                    }
                } else {
                    res.append(top.value)
                    latestReadNode = top
                    stack.pop()
                }
            }
        }
        return res
    }

    private func _postorder(_ root: Node<T>?) -> [T] {
        guard let root = root else { return [] }
        return _postorder(root.left) + _postorder(root.right) + [root.value]
    }

    // MARK: pre order

    private func _DLR() -> [T] {
        let stack = Stack<Node<T>>()
        var p = _root
        var res: [T] = []
        while p != nil || !stack.isEmpty {
            while let node = p {
                res.append(node.value)
                stack.push(node)
                p = node.left
            }
            p = stack.pop()?.right
        }
        return res
    }

    private func _preorder(_ root: Node<T>?) -> [T] {
        guard let root = root else { return [] }
        return [root.value] + _preorder(root.left) + _preorder(root.right)
    }

    // MARK: in order

    private func _LDR() -> [T] {
        let stack = Stack<Node<T>>()
        var p = _root
        var res: [T] = []
        while p != nil || !stack.isEmpty {
            while let node = p {
                stack.push(node)
                p = node.left
            }
            if let top = stack.pop() {
                res.append(top.value)
                p = top.right
            }
        }
        return res
    }

    private func _inorder(_ root: Node<T>?) -> [T] {
        guard let root = root else { return [] }
        return _inorder(root.left) + [root.value] + _inorder(root.right)
    }
}
