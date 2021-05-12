//
//  BinarySearchTree.swift
//  Arithmetic
//
//  Created by lben on 2021/4/30.
//

import Foundation

/**
 AVL

 */

/**
 BST
 - 左孩子 `<` 父亲节点 `<` 右孩子
 - 中序遍历 `->` 获得递增排序数
 - 知道后序遍历 `->` 可以推导出整科二叉树搜索树 ps: 中序遍历已知
 1、已知后序 `->`生成搜索二叉树
 2、二叉搜索树的构建
 3、平衡二叉查找树（平衡二叉树）`->`
 4、如何处理节点相同的情况
 */

public final class BinarySearchTree<T: Comparable>: BinarySearchTreeable {
    typealias TreeNode = Node<T>
    public final class Node<T>: BinarySearchTreeNodeable {
        var value: T
        var parent: Node<T>?
        var left: Node<T>?
        var right: Node<T>?
        init(value aValue: T) {
            value = aValue
        }
    }

    var root: TreeNode?
    init(root value: T? = nil) {
        if let value = value {
            root = TreeNode(value: value)
        }
    }

    convenience init(values: [T]) {
        self.init()
        values.forEach { self.insert($0) }
    }
}

func BinarySearchTreeTest() {
    return
    var bst = BinarySearchTree<Int>(root: 1)
    let node2 = BinarySearchTree<Int>.TreeNode(value: 2)
    let node3 = BinarySearchTree<Int>.TreeNode(value: 3)
    let node4 = BinarySearchTree<Int>.TreeNode(value: 4)
    let node5 = BinarySearchTree<Int>.TreeNode(value: 5)
    let node6 = BinarySearchTree<Int>.TreeNode(value: 6)
    let node7 = BinarySearchTree<Int>.TreeNode(value: 7)
    node3.left = node2
    bst.root?.left = node3
    node4.left = node5
    node4.right = node6
    node6.left = node7
    bst.root?.right = node4
    print("preorder", bst.preorder())
    print("inorder", bst.inorder())
    print("postorder", bst.postorder())

    bst = BinarySearchTree<Int>.init(values: [1, 3, 5, 6, 9, 0, 10, 4])
    print("inorder", bst.inorder())
    print("postorder", bst.postorder())
//    print("search", bst.search(100)?.value ?? "null")
    bst.remove(1)
    print("inorder - 1", bst.inorder())
    bst.remove(5)
    print("inorder - 5", bst.inorder())
    bst.remove(3)
    print("inorder - 3", bst.inorder())
    bst.remove(6)
    print("inorder - 6", bst.inorder())
    bst.remove(10)
    print("inorder - 10", bst.inorder())
    bst.remove(4)
    print("inorder - 4", bst.inorder())
    bst.remove(0)
    print("inorder - 0", bst.inorder())
    bst.remove(9)
    print("inorder - 9", bst.inorder())
    
    
}
