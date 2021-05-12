//
//  BitTree.swift
//  DomeUI
//
//  Created by lben on 2019/4/2.
//  Copyright © 2019 lben. All rights reserved.
//

import Foundation

// 二叉树
final class BiTree<T: Comparable>: BinaryTreeProtocol {
    var value: T
    var leftChild: BiTree<T>?
    var rightChild: BiTree<T>?
    init(value: T) {
        self.value = value
    }
}

// 二叉排序树
final class BiSortTree<T: Comparable>: BinarySortTreeProtocol {
    var value: T
    weak var leftChild: BiSortTree<T>?
    var rightChild: BiSortTree<T>?
    var parent: BiSortTree<T>?
    init(value: T) {
        self.value = value
    }
}

@objc
final class Solution: NSObject {
    @objc static func test() {
        biSortTree()
    }

    static func biSortTree() {
        if let root = BiSortTree.create(from: [62, 88, 58, 47, 35, 73, 51, 99, 37, 93]) {
            print("中序遍历:\(root.inorder())")
            print("remove value 51")
            root.remove(value: 51)
            print("中序遍历:\(root.inorder())")

            print("insert value 51")
            root.insert(value: 51)
            print("中序遍历:\(root.inorder())")
            print(root.inorder())
        }
    }

    static func biTree() {
        let root = BiTree(value: 1)

        let left = BiTree(value: 2)
        left.leftChild = BiTree(value: 4)
        left.rightChild = BiTree(value: 5)

        let right = BiTree(value: 3)
        right.leftChild = BiTree(value: 6)
        right.rightChild = BiTree(value: 7)

        root.leftChild = left
        root.rightChild = right

        print(root.inorder())
        print(root.preorder())
        print(root.postorder())
        print(root.levelorder())
    }
}
