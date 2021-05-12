//
//  TreeQ.swift
//  Arithmetic
//
//  Created by lben on 2021/4/22.
//

import Foundation

struct TreeQ {
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

    // MARK: - 102. Binary Tree Level Order Traversal

    ///  https://leetcode.com/problems/binary-tree-level-order-traversal/
    /// Input: root = [3,9,20,null,null,15,7]
    /// Output: [[3],[9,20],[15,7]]
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        guard nil != root else { return [] }
        let queue = LinkedList<TreeNode>()
        queue.insertTo(head: root!)
        var res: [[Int]] = []
        // 通过 2 * rootIndex 获取子节点，当树比较大时，很容易导致index超出最大数
        while !queue.isEmpty {
            var elemes: [Int] = []
            for _ in 0 ..< queue.count {
                let root = queue.removeHead()!
                if let lc = root.left {
                    queue.insertTo(tail: lc)
                }
                if let rc = root.right {
                    queue.insertTo(tail: rc)
                }
                elemes.append(root.val)
            }
            res.append(elemes)
        }
        return res
    }

    // MARK: - 104. Maximum Depth of Binary Tree

    /// https://leetcode.com/problems/maximum-depth-of-binary-tree/
    func maxDepth(_ root: TreeNode?) -> Int {
        var linkedList: [TreeNode] = []
        var latestPopNode: TreeNode?
        var level: Int = 1
        var maxLevel: Int = 0
        var node = root
        linkedList.append(root!)
        while node != nil || !linkedList.isEmpty {
            while let left = node?.left {
                linkedList.insert(left, at: 0)
                node = left
                level += 1
            }
            maxLevel = max(level, maxLevel)
            if let top = linkedList.first {
                if let right = top.right, right !== latestPopNode {
                    linkedList.insert(right, at: 0)
                    level += 1
                    node = right
                    maxLevel = max(level, maxLevel)
                } else {
                    let node = linkedList.removeFirst()
                    latestPopNode = node
                    level -= 1
                }
            }
        }
        return maxLevel
    }

    /// 树与层数关系
    func level(with index: Int) -> Int {
        switch index {
        case 1: return 1
        case 2 ..< 4: return 2
        case 4 ..< 8: return 3
        case 8 ..< 16: return 4
        case 16 ..< 32: return 5
        case 32 ..< 64: return 6
        case 64 ..< 128: return 7
        case 128 ..< 256: return 8
        case 256 ..< 512: return 8
        case 512 ..< 1024: return 9
        case 1024 ..< 2014: return 10
        default: return Int(log2(Float(index))) + 1
        }
    }
}

extension TreeQ: Testable {
    static func test() {
    }
}
