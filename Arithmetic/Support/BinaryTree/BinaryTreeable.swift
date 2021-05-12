//
//  Treeable.swift
//  Arithmetic
//
//  Created by lben on 2021/4/30.
//

import Foundation

protocol Nodeable: AnyObject {
    associatedtype T
    var value: T { get set }
    var left: Self? { get set }
    var right: Self? { get set }
    init(value aValue: T)
    init(value: T, left: Self?, right: Self?)
}

extension Nodeable {
    var hasRightChild: Bool { left != nil }
    var hasLeftChild: Bool { right != nil }
    var hasBothChild: Bool { hasLeftChild && hasRightChild }
    var isLeaf: Bool { left == nil && right == nil }
    /// 递归
    var count: Int { (left?.count ?? 0) + 1 + (right?.count ?? 0) }

    init(value aValue: T, left: Self?, right: Self?) {
        self.init(value: aValue)
        self.left = left
        self.right = right
    }
}

extension Nodeable {
    func maxDepth() -> Int {
        if let lc = left, let rc = right {
            return max(lc.maxDepth(), rc.maxDepth()) + 1
        } else if let lc = left {
            return lc.maxDepth() + 1
        } else if let rc = right {
            return rc.maxDepth() + 1
        }
        return 1
    }
}

protocol BinaryTreeable: AnyObject {
    associatedtype TreeNode: Nodeable
    typealias T = TreeNode.T
    var root: TreeNode? { get set }
}

extension BinaryTreeable {
    func preorder() -> [T] {
        guard let _root = root else { return [] }
        var stack = [_root], res: [T] = []
        while let node = stack.pop() {
            res.append(node.value)
            if let right = node.right {
                stack.push(right)
            }
            if let left = node.left {
                stack.push(left)
            }
        }
        return res
    }

    func inorder() -> [T] {
        guard let _root = root else { return [] }
        var stack: [TreeNode] = [], res: [T] = []
        var p: TreeNode? = _root
        while p != nil || !stack.isEmpty {
            while let _p = p {
                stack.push(_p)
                p = _p.left
            }
            if let node = stack.pop() {
                res.append(node.value)
                p = node.right
            }
        }
        return res
    }

    func postorder() -> [T] {
        guard let _root = root else { return [] }
        var stack: [TreeNode] = [], res: [T] = []
        var p: TreeNode? = _root, last: TreeNode?
        while p != nil || !stack.isEmpty {
            while let _p = p {
                stack.push(_p)
                p = _p.left
            }
            if let node = stack.peek() {
                if let right = node.right, right !== last {
                    stack.push(right)
                    p = right.left
                } else {
                    res.append(node.value)
                    last = node
                    stack.pop()
                }
            }
        }
        return res
    }
}
