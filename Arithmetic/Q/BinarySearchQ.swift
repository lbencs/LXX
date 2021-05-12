//
//  BinarySearch.swift
//  Arithmetic
//
//  Created by lben on 2021/5/8.
//

import Foundation

struct BinarySearchQ {
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

    // MARK: - 173. Binary Search Tree Iterator

    class BSTIterator {
        let _root: TreeNode?
        var _stack: [TreeNode] = []

        init(_ root: TreeNode?) {
            _root = root
            _push(node: root)
        }

        private func _push(node: TreeNode?) {
            var node = node
            while let q = node {
                _stack.push(q)
                node = q.left
            }
        }

        func next() -> Int {
            let node = _stack.pop()!
            _push(node: node.right)
            return node.val
        }

        func hasNext() -> Bool {
            return !_stack.isEmpty
        }
    }

    // MARK: - 98. Validate Binary Search Tree

    func isValidBST(_ root: TreeNode?) -> Bool {
        guard let root = root else { return false }
        // 中序遍历
        var stack = [TreeNode]()
        var p: TreeNode? = root
        var preValue: Int = .min
        while p != nil || !stack.isEmpty {
            while let q = p {
                stack.push(q)
                p = q.left
            }
            if let top = stack.pop() {
                if preValue >= top.val { return false }
                preValue = top.val
                p = top.right
            }
        }
        return true
    }

    // MARK: - 704. Binary Search

    func search_704(_ nums: [Int], _ target: Int) -> Int {
        var left = 0, right = nums.endIndex - 1
        while left <= right {
            let center = left + ((right - left) >> 1)
            if nums[center] == target {
                return center
            } else if nums[center] < target {
                left = center + 1
            } else {
                right = center - 1
            }
        }
        return -1
    }

    // MARK: - 33. Search in Rotated Sorted Array

    #if false
        func search(_ nums: [Int], _ target: Int) -> Int {
            var rotateIndex = 0
            while rotateIndex < nums.endIndex - 1, nums[rotateIndex] < nums[rotateIndex + 1] {
                rotateIndex += 1
            }

            func search(_ nums: [Int], _ target: Int, left: Int, right: Int) -> Int {
                guard left <= right else { return -1 }
                var left = left, right = right
                while left <= right {
                    let center = left + ((right - left) >> 1)
                    if nums[center] == target {
                        return center
                    } else if nums[center] < target {
                        left = center + 1
                    } else {
                        right = center - 1
                    }
                }
                return -1
            }

            if target >= nums[0] {
                //
                return search(nums, target, left: 0, right: rotateIndex)
            } else {
                return search(nums, target, left: rotateIndex + 1, right: nums.endIndex - 1)
            }
        }
    #endif
    func search(_ nums: [Int], _ target: Int) -> Int {
        // 有一边一定有一个最小递增
        var left = 0, right = nums.endIndex - 1
        while left <= right {
            let mid = left + (right - left) >> 1
            if nums[mid] == target { return mid }
            // - >
            if nums[mid] > target {
                if nums[left] == target { return left }
                if nums[left] > target {
                    left = mid + 1
                } else {
                    right = mid - 1
                }
            } else {
                // nums[mid] < target
                if nums[right] == target { return right }
                if nums[right] > target {
                    left = mid + 1
                } else {
                    right = mid - 1
                }
            }
        }
        return -1
    }
}

extension BinarySearchQ: Testable {
    static func test() {
//        print(BinarySearchQ().search([4, 5, 6, 7, 8, 1, 2, 3], 8) == 4)
//        print(BinarySearchQ().search([3, 1], 1) == 1)
//        print(BinarySearchQ().search([1, 3], 1) == 0)
//        print(BinarySearchQ().search([4, 5, 6, 7, 0, 1, 2], 0) == 4)
//        print(BinarySearchQ().search([4, 5, 6, 7, 0, 1, 2], 3) == -1)
//        print(BinarySearchQ().search([6, 7, 0, 1, 2, 3, 4, 5], 4) == 6)
//        print(BinarySearchQ().search([0, 1, 2, 3, 4, 5, 6, 7], 3) == 3)
//        print(BinarySearchQ().search([1], 1) == 0)
//        print(BinarySearchQ().search([1], 0) == -1)
//        print(BinarySearchQ().search([1], 1) == 0)
//        print("end")
    }
}
