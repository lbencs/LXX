//
//  BinarySearchTreeable.swift
//  Arithmetic
//
//  Created by lben on 2021/4/30.
//

import Foundation

protocol BinarySearchTreeNodeable: Nodeable {
    var parent: Self? { get set }
    init(value aValue: T, left: Self?, right: Self?, parent: Self?)
}

extension BinarySearchTreeNodeable {
    var isLeftChild: Bool { parent?.left === self }
    var isRightChild: Bool { parent?.right === self }
    var isRoot: Bool { parent == nil }
    var oneChild: Self? {
        if let lc = left { return lc }
        if let rc = right { return rc }
        return nil
    }

    init(value aValue: T, left: Self?, right: Self?, parent: Self?) {
        self.init(value: aValue, left: left, right: right)
        self.parent = parent
    }
}

extension BinarySearchTreeNodeable where T: Comparable {
    func contain(_ aValue: T) -> Bool {
        if value == aValue {
            return true
        } else if value < aValue {
            return right?.contain(aValue) ?? false
        } else {
            return left?.contain(aValue) ?? false
        }
    }

    func insert(_ aValue: T) {
        if value < aValue {
            //
            if let rc = right {
                rc.insert(aValue)
            } else {
                right = Self(value: aValue, left: nil, right: nil, parent: self)
            }
        } else if value > aValue {
            if let lc = left {
                lc.insert(aValue)
            } else {
                left = Self(value: aValue, left: nil, right: nil, parent: self)
            }
        }
    }

    func search(_ aValue: T) -> Self? {
        if value == aValue {
            return self
        } else if value < aValue {
            return right?.search(aValue)
        } else {
            return left?.search(aValue)
        }
    }

    /// 返回移除的Node
    @discardableResult func remove(_ aValue: T) -> Self? {
        if value == aValue {
            if let _ = left, let rc = right {
                // both
                let minNode = rc.min()
                (value, minNode.value) = (minNode.value, value)
                // 只可能存在右节点
                if minNode.isLeftChild {
                    minNode.parent?.left = minNode.right
                } else {
                    minNode.parent?.right = minNode.right
                }
                minNode.right?.parent = minNode.parent
                
                minNode.right = nil
                minNode.left = nil
                minNode.parent = nil
                return minNode
            } else if let child = oneChild {
                // left or right
                (value, child.value) = (child.value, value)
                left = child.left
                right = child.right
                child.left?.parent = self
                child.right?.parent = self

                child.parent = nil
                child.left = nil
                child.right = nil
                return child
            } else {
                if isLeftChild {
                    parent?.left = nil
                } else {
                    parent?.right = nil
                }
                parent = nil
                return self
            }
        } else if value < aValue {
            return right?.remove(aValue)
        } else {
            return left?.remove(aValue)
        }
    }

    func min() -> Self {
        return left?.min() ?? self
    }
}

protocol BinarySearchTreeable: BinaryTreeable where TreeNode: BinarySearchTreeNodeable, T: Comparable {
}

extension BinarySearchTreeable {
    func insert(_ value: TreeNode.T) {
        guard root != nil else {
            root = TreeNode(value: value)
            return
        }
        root?.insert(value)
    }

    func search(_ value: T) -> TreeNode? {
        return root?.search(value)
    }

    @discardableResult func remove(_ aValue: T) -> TreeNode? {
        let rm = root?.remove(aValue)
        if rm === root {
            root = nil
        }
        return rm
    }
}
