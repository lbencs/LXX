//
//  BinaryTree.swift
//  Arithmetic
//
//  Created by lben on 2021/4/21.
//

import Foundation


extension BinaryTree {
    // Node
    final
    class Node<T: Hashable>: Hashable, Nodeable {
        var value: T
        var left: Node<T>?
        var right: Node<T>?

        init(value: T) {
            self.value = value
        }

        init(value: T, left: Node<T>?, right: Node<T>?) {
            self.value = value
            self.left = left
            self.right = right
        }

        var isLeaf: Bool { left == nil && right == nil }
    }

    struct LevelWapper<Node> {
        var level: Int // 层
        var index: Int // index
        var value: Node
    }
}

extension BinaryTree.Node {
    static func == (lhs: BinaryTree.Node<T>, rhs: BinaryTree.Node<T>) -> Bool {
        return lhs.value == rhs.value && lhs.left == rhs.left && lhs.right == rhs.right
    }

    func hash(into hasher: inout Hasher) {
        let address = "\(Unmanaged.passUnretained(self).toOpaque())"
        hasher.combine(address)
    }
}
