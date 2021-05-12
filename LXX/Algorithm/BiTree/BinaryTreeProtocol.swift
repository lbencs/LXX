//
//  BinaryTreeProtocol.swift
//  DomeUI
//
//  Created by lben on 2019/4/2.
//  Copyright © 2019 lben. All rights reserved.
//

import Foundation

/// 树节点
protocol BinaryTreeProtocol: class {
    associatedtype T: Comparable
    var value: T { get set }
    var leftChild: Self? { get set }
    var rightChild: Self? { get set }
    init(value: T)
}

extension BinaryTreeProtocol {
    /// 判断是否为叶子节点
    ///
    /// - Returns: Bool
    func isLeaf() -> Bool {
        return leftChild == nil && rightChild == nil
    }

    /// 后续遍历
    ///
    /// - Returns: 后续遍历数据集
    func postorder() -> [T] {
        if isLeaf() {
            return [value]
        }
        return (leftChild?.preorder() ?? []) + (rightChild?.preorder() ?? []) + [value]
    }

    /// 先续遍历
    ///
    /// - Returns: 先续遍历数据集
    func preorder() -> [T] {
        if isLeaf() {
            return [value]
        }
        return [value] + (leftChild?.preorder() ?? []) + (rightChild?.preorder() ?? [])
    }

    /// 中序遍历
    ///
    /// - Returns: 返回遍历数据集合
    func inorder() -> [T] {
        if isLeaf() {
            return [value]
        }
        return (leftChild?.inorder() ?? []) + [value] + (rightChild?.inorder() ?? [])
    }

    /// 层序遍历
    ///
    /// - Returns: [T]
    func levelorder() -> [T] {
        var result = [T]()
        var queue = [self]
        while !queue.isEmpty {
            let root = queue.removeFirst()
            result.append(root.value)
            if let left = root.leftChild {
                queue.append(left)
            }
            if let right = root.rightChild {
                queue.append(right)
            }
        }
        return result
    }

    func depthFirstOrder() -> [T] {
        return []
    }

    func breadFirstOrder() -> [T] {
        return []
    }

    func depthFirstSearch(target: T) -> Bool {
        return true
    }

    func breadFirstSearch(target: T) -> Bool {
        return true
    }
}
