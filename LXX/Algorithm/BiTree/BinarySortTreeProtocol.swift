//
//  BinarySortTreeProtocol.swift
//  DomeUI
//
//  Created by lben on 2019/4/2.
//  Copyright © 2019 lben. All rights reserved.
//

import Foundation

protocol BinarySortTreeProtocol: BinaryTreeProtocol {
    var parent: Self? { get set }
}

extension BinarySortTreeProtocol {
    /// 插入一个数据到二叉排序树
    ///
    /// - Parameter value: 插入的数据
    func insert(value aValue: T) {
        if aValue > value {
            // 插入右子树
            if let right = rightChild {
                right.insert(value: aValue)
            } else {
                rightChild = Self(value: aValue)
            }
        } else {
            // 插入左子树
            if let left = leftChild {
                left.insert(value: aValue)
            } else {
                leftChild = Self(value: aValue)
            }
        }
    }

    /// 删除结点
    ///
    /// - Parameter aValue: 需要删除的节点值
    func remove(value aValue: T) {
        if value == aValue {
            // 移除自己
            _remove()
        } else if value < aValue {
            // 从左子树移除
            leftChild?.remove(value: aValue)
        } else {
            // 从右子树移除
            rightChild?.remove(value: aValue)
        }
    }

    func _remove() {
        // 如何移除自己
        if leftChild != nil {
            //
            // 找到父亲节点
        } else {
        }
    }

    /// 前驱节点
    ///
    /// - Returns: 返回前驱节点
    func predecessor() -> Self {
        return self
    }

    func _parent() -> Self {
        //
        return self
    }

    /**
     三种情况
     1. 左子树为空，右子树（可为空、可非空）直接下沉
     2. 左子树不为空，右子树为空，左子树直接下沉
     3. 左子树不为空，右子树不为空，右子树下沉，左子树添加到右子树最低左子树上
     */
    private func _removeSelf(from father: Self) {
    }

    /// 查找指定value在排序树中的位置
    ///
    /// - Parameters:
    ///   - aValue: 值
    ///   - father: 父亲节点，根节点的父亲节点为nil
    /// - Returns: （查找的节点，父亲节点）
    private func _find(value aValue: T, father: Self?) -> (Self?, Self?) {
        if aValue == value {
            return (self, father)
        } else if aValue > value {
            return rightChild?._find(value: aValue, father: self) ?? (nil, nil)
        } else {
            return leftChild?._find(value: aValue, father: self) ?? (nil, nil)
        }
    }

    /// 排序树中是否存在aValue这个值
    ///
    /// - Parameter aValue: 查找的值
    /// - Returns: true or false
    func find(value aValue: T) -> Self? {
        if aValue == value {
            return self
        } else if aValue > value {
            return rightChild?.find(value: aValue) ?? nil
        } else {
            return leftChild?.find(value: aValue) ?? nil
        }
    }

    /// 构建一颗二叉排序树
    ///
    /// - Parameter arr: 数据数组
    /// - Returns: 返回二叉排序树根节点
    static func create(from arr: [T]) -> Self? {
        guard !arr.isEmpty else {
            return nil
        }
        var arr = arr
        let tree = Self(value: arr.remove(at: 0))
        for ele in arr {
            tree.insert(value: ele)
        }
        return tree
    }

    /// 最小值
    ///
    /// - Returns: <#return value description#>
    func minimun() -> Self {
        var node = self
        while let next = node.leftChild {
            node = next
        }
        return node
    }

    /// 最大值
    ///
    /// - Returns: <#return value description#>
    func maximum() -> Self {
        var node = self
        while let next = node.rightChild {
            node = next
        }
        return node
    }
}
