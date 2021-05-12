//
//  Construct Binary Search Tree.swift
//  Arithmetic
//
//  Created by lben on 2021/5/7.
//

import Foundation

struct ConstructBinaryTreeQ {
    public class TreeNode {
        public var val: Int
        public var left: TreeNode?
        public var right: TreeNode?
        public init() { val = 0; left = nil; right = nil }
        public init(_ val: Int) { self.val = val; left = nil; right = nil }
        public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
            self.val = val
            self.left = left
            self.right = right
        }
    }

    // MARK: - 1008. Construct Binary Search Tree from Preorder Traversal

    /**
     [8,5,1,7,10,12]
     */
    func bstFromPreorder(_ preorder: [Int]) -> TreeNode? {
        /**
         1. 排序 获取到中序遍历，然后再构建
         2. 先序，根 + 小于根 + 大于根
            2.1. 递归
            2.2. 尾递归
         */
        func findFinalSmall(_ n: Int, lhs: Int, rhs: Int) -> Int? {
            guard lhs <= rhs else { return nil }
            if lhs == rhs { return preorder[lhs] < n ? lhs : nil }
            if lhs == rhs - 1 {
                // TODO: #lben -  优化二分查找代码
                var res: Int?
                if preorder[lhs] < n {
                    res = lhs
                }
                if preorder[rhs] < n {
                    res = rhs
                }
                return res
            }
            let center = (lhs + rhs) / 2
            if preorder[center] < n {
                return findFinalSmall(n, lhs: center, rhs: rhs)
            } else {
                return findFinalSmall(n, lhs: lhs, rhs: center - 1)
            }
        }

        func build(lhs: Int, rhs: Int) -> TreeNode? {
            guard lhs <= rhs else { return nil }
            let first = preorder[lhs]
            let root = TreeNode(first)
            if let finalSmall = findFinalSmall(first, lhs: lhs + 1, rhs: rhs) {
                root.left = build(lhs: lhs + 1, rhs: finalSmall)
                root.right = build(lhs: finalSmall + 1, rhs: rhs)
            } else {
                root.right = build(lhs: lhs + 1, rhs: rhs)
            }
            return root
        }

        return build(lhs: 0, rhs: preorder.endIndex - 1)
    }

    // MARK: - 106. Construct Binary Tree from Inorder and Postorder Traversal

    #if false
        func buildTree(_ inorder: [Int], _ postorder: [Int]) -> TreeNode? {
            guard !inorder.isEmpty, !postorder.isEmpty else {
                return nil
            }
            let last = postorder.last!
            let root = TreeNode(last)
            let index = inorder.firstIndex(of: last)!
            if index > 0 {
                let leftInorder = Array(inorder[0 ..< index])
                let leftPostorder = postorder.filter({ leftInorder.contains($0) })
                root.left = buildTree(leftInorder, leftPostorder)
            } else {
                root.left = nil
            }

            if index + 1 < inorder.count {
                let rightInorder = Array(inorder[(index + 1) ..< inorder.count])
                let rightPostorder = postorder.filter({ rightInorder.contains($0) })
                root.right = buildTree(rightInorder, rightPostorder)
            } else {
                root.right = nil
            }
            return root
        }
    #endif
    #if false
        func buildTree(_ inorder: [Int], _ postorder: [Int]) -> TreeNode? {
            let count = inorder.count

            guard count != 0 else {
                return nil
            }
            guard count != 1 else {
                return TreeNode(inorder[0])
            }
            let last = postorder.last!
            let root = TreeNode(last)
            let index = inorder.firstIndex(of: last)!

            if index == 0 {
                // all left
                root.left = nil
                root.right = buildTree(Array(inorder[1 ..< count]), Array(postorder[0 ..< (count - 1)]))
            } else if index == count - 1 {
                // all right
                root.left = buildTree(Array(inorder[0 ..< count - 1]), Array(postorder[0 ..< count - 1]))
                root.right = nil
            } else {
                let leftInorder = Array(inorder[0 ..< index])
                let rightInorder = Array(inorder[(index + 1) ..< count])
                var leftPostorder: [Int] = []
                var rightPostorder: [Int] = []
                for e in postorder where e != last {
                    if leftInorder.contains(e) {
                        leftPostorder.append(e)
                    } else {
                        rightPostorder.append(e)
                    }
                }
                root.left = buildTree__toolong(leftInorder, leftPostorder)
                root.right = buildTree__toolong(rightInorder, rightPostorder)
            }
            return root
        }
    #endif

    #if false
        func _buildTree(_ inorder: [Int], _ postorder: inout [Int]) -> TreeNode? {
            let count = inorder.count
            guard count != 0 else { return nil }
            let last = postorder.removeLast()
            let root = TreeNode(last)
            let index = inorder.firstIndex(of: last)!
            root.right = _buildTree(Array(inorder[(index + 1) ..< count]), &postorder)
            root.left = _buildTree(Array(inorder[0 ..< index]), &postorder)
            return root
        }

        func buildTree(_ inorder: [Int], _ postorder: [Int]) -> TreeNode? {
            var postorder = postorder
            return _buildTree(inorder, &postorder)
        }
    #endif

    func buildTree(_ inorder: [Int], _ postorder: [Int]) -> TreeNode? {
        // 递归 -> 尾递归
        var postIndex = postorder.endIndex - 1
        var map: [Int: Int] = [:]
        for (i, n) in inorder.enumerated() {
            map[n] = i
        }

        func build(lhs: Int, rhs: Int) -> TreeNode? {
            guard lhs <= rhs else { return nil }
            let last = postorder[postIndex]
            postIndex -= 1
            let inIndex = map[last]!
            let node = TreeNode(last)
            node.right = build(lhs: inIndex + 1, rhs: rhs)
            node.left = build(lhs: lhs, rhs: inIndex - 1)
            return node
        }

        return build(lhs: 0, rhs: inorder.endIndex - 1)
    }

    // MARK: - 105. Construct Binary Tree from Preorder and Inorder Traversal

    func buildTree_105(_ preorder: [Int], _ inorder: [Int]) -> TreeNode? {
        var preIndex = 0
        var map: [Int: Int] = [:]
        for (i, n) in inorder.enumerated() {
            map[n] = i
        }

        func build(lhs: Int, rhs: Int) -> TreeNode? {
            guard lhs <= rhs else { return nil }
            let last = preorder[preIndex]
            preIndex += 1
            let inIndex = map[last]!
            let node = TreeNode(last)
            node.right = build(lhs: inIndex + 1, rhs: rhs)
            node.left = build(lhs: lhs, rhs: inIndex - 1)
            return node
        }
        return build(lhs: 0, rhs: inorder.endIndex - 1)
    }
}

extension ConstructBinaryTreeQ: Testable {
    static func test() {
        //        Input: inorder = [9,3,15,20,7], postorder = [9,15,7,20,3]
//        ConstructBinaryTreeQ().buildTree([2, 3, 1], [3, 2, 1])
//        ConstructBinaryTreeQ().buildTree([9, 3, 15, 20, 7], [9, 15, 7, 20, 3])
//        ConstructBinaryTreeQ().buildTree([1, 2, 3, 4], [2, 1, 4, 3])

        ConstructBinaryTreeQ().bstFromPreorder([8, 5, 1, 7, 10, 12])
    }
}
