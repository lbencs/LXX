//
//  MergeQ.swift
//  Arithmetic
//
//  Created by lben on 2021/4/28.
//

import Foundation

struct MergeQ {
    public class ListNode {
        public var val: Int
        public var next: ListNode?
        public init() { val = 0; next = nil }
        public init(_ val: Int) { self.val = val; next = nil }
        public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next }
    }

    // MARK: - 4. Median of Two Sorted Arrays

    // https://leetcode.com/problems/median-of-two-sorted-arrays/
    // 给定两个大小分别为 m 和 n 的正序（从小到大）数组 nums1 和 nums2。请你找出并返回这两个正序数组的 中位数 。
    func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
        // 进阶：你能设计一个时间复杂度为 O(log (m+n)) 的算法解决此问题吗？

        let total = nums1.count + nums2.count
        let medianIndex: Int
        let isDoubleMedian: Bool

        if total % 2 == 0 {
            isDoubleMedian = true
            medianIndex = total / 2 - 1
        } else {
            isDoubleMedian = false
            medianIndex = total / 2
        }
        var nums_1_index: Int = 0
        var nums_2_index: Int = 0

        var currentIndex: Int = -1
        var currentValue: Int = 0

        while nums_1_index < nums1.count, nums_2_index < nums2.count {
            if currentIndex == medianIndex {
                return isDoubleMedian ? Double(currentValue + min(nums1[nums_1_index], nums2[nums_2_index])) / 2 : Double(currentValue)
            }
            if nums1[nums_1_index] < nums2[nums_2_index] {
                currentValue = nums1[nums_1_index]
                nums_1_index += 1
            } else {
                currentValue = nums2[nums_2_index]
                nums_2_index += 1
            }
            currentIndex += 1
        }

        while nums_1_index < nums1.count {
            if currentIndex == medianIndex {
                return isDoubleMedian ? Double(currentValue + nums1[nums_1_index]) / 2 : Double(currentValue)
            }
            currentValue = nums1[nums_1_index]
            nums_1_index += 1
            currentIndex += 1
        }

        while nums_2_index < nums2.count {
            if currentIndex == medianIndex {
                return isDoubleMedian ? Double(currentValue + nums2[nums_2_index]) / 2 : Double(currentValue)
            }
            currentValue = nums2[nums_2_index]
            nums_2_index += 1
            currentIndex += 1
        }

        return Double(currentIndex == medianIndex ? currentValue : 0)
    }

    // MARK: - 88. Merge Sorted Array

    func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        guard n > 0 else { return }
        guard m != 0 else {
            nums1 = nums2
            return
        }
        // m will not be 0
        var p = m, q = n, index = nums1.count - 1
        while p > 0, q > 0 {
            if nums1[p - 1] < nums2[q - 1] {
                nums1[index] = nums2[q - 1]
                q -= 1
            } else {
                nums1[index] = nums1[p - 1]
                p -= 1
            }
            index -= 1
        }
        nums1[0 ..< q] = nums2[0 ..< q]
    }

    // MARK: - 23. Merge k Sorted Lists

    /**
     Priority Queue
     1. 两两合并
     2. 递归？
     3. 堆栈太大 ->
     5. 数组存起来
     */

    func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
        let lists = lists.compactMap({ $0 })
        guard !lists.isEmpty else { return nil }
        guard lists.count > 1 else { return lists[0] }
        var priorityQueue = PriorityQueue<ListNode>(queues: lists, sort: { $0.val < $1.val })
        let head: ListNode? = priorityQueue.peek
        var p = head

        while let node = priorityQueue.dequeue() {
            if let next = node.next {
                priorityQueue.enqueue(element: next)
            }
            node.next = nil
            p?.next = node
            p = node
        }
        return head
    }

    // MARK: - 56. Merge Intervals

    func merge(_ intervals: [[Int]]) -> [[Int]] {
        guard intervals.count > 1 else { return intervals }
        let re = intervals
            .sorted(by: { $0[0] < $1[0] })
            .reduce([[Int]]()) { res, arr in
                if let last = res.last {
                    var res = res
                    if last[1] >= arr[0] {
                        res[res.count - 1] = [last[0], max(arr[1], last[1])]
                    } else {
                        res.append(arr)
                    }
                    return res
                } else {
                    return [arr]
                }
            }
        return re
    }
}

extension MergeQ: Testable {
    static func test() {
    }
}
