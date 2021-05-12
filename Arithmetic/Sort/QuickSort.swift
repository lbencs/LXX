//
//  QuickSort.swift
//  Arithmetic
//
//  Created by lben on 2021/4/18.
//

import Foundation
extension Sort.Bubble {
    // 不稳定
    struct Quick: SwapAble {
        class Solution {
            // - leetcode - 912
            //  Input: nums = [5,1,1,2,0,0]
            //  1. ->
            //  Output: [0,0,1,1,2,5]

            func sortArray(_ nums: [Int]) -> [Int] {
//                return Quick.sort(nums, compared: <)
                var nums = nums
                Quick.sortBySlowFastPoint(left: 0, right: nums.count - 1, nums: &nums)
                return nums
            }
        }

        static func sortBySlowFastPoint(left: Int, right: Int, nums: inout [Int]) {
            if left < right {
                let partitionIndex = partitionAfterSortOnce(left: left, right: right, compared: >, &nums)
                sortBySlowFastPoint(left: left, right: partitionIndex - 1, nums: &nums)
                sortBySlowFastPoint(left: partitionIndex + 1, right: right, nums: &nums)
            }
        }

        ///
        static func partitionAfterSortOnce<T: Comparable>(left: Int, right: Int, compared: @escaping (_ lhs: T, _ rhs: T) -> Bool, _ nums: inout [T]) -> Int {
            let centerIndex = (right + left) / 2
            (nums[centerIndex], nums[right]) = (nums[right], nums[centerIndex])
            var index = left
            for i in left ..< right {
                if compared(nums[i], nums[right]) {
                    (nums[index], nums[i]) = (nums[i], nums[index])
                    index += 1
                }
            }
            (nums[index], nums[right]) = (nums[right], nums[index])
            return index
        }

        static func sort<T>(_ arr: [T], compared: @escaping (_ lhs: T, _ rhs: T) -> Bool) -> [T] {
            func sort(left: Int, right: Int, _ nums: inout [T]) {
                guard left < right else { return }
                if right - 1 == left {
                    if !compared(nums[left], nums[right]) {
                        (nums[left], nums[right]) = (nums[right], nums[left])
                    }
                    return
                }
                let piovtIndex: Int = (right + left) / 2
                let piovt = nums[piovtIndex]
                var former: Int = left
                var last: Int = right - 1
                (nums[piovtIndex], nums[right]) = (nums[right], nums[piovtIndex])

                while former < last {
                    // TODO: #lben -  只能大于 or 等于 缺陷
                    while former < last, compared(nums[former], piovt) {
                        former += 1
                    }
                    while former < last, !compared(nums[last], piovt) {
                        last -= 1
                    }
                    if former < last {
                        (nums[former], nums[last]) = (nums[last], nums[former])
                        former += 1
                        last -= 1
                    }
                }
                while compared(nums[former], piovt), former < right {
                    former += 1
                }
                (nums[former], nums[right]) = (nums[right], nums[former])
                sort(left: left, right: former - 1, &nums)
                sort(left: former + 1, right: right, &nums)
            }

            guard arr.count > 1 else { return arr }
            var arr = arr
            sort(left: 0, right: arr.count - 1, &arr)
            return arr
        }

        static func findMedian<T: Comparable & BinaryInteger>(in arr: [T]) -> Float {
            guard !arr.isEmpty else { return 0 }
            guard arr.count > 1 else { return Float(arr[0]) }
            guard arr.count > 2 else { return Float(arr[0] + arr[1]) / 2 }

            let center = arr.count / 2
            if arr.count % 2 == 0 {
                // 有两个
            } else {
                // 只有1个
            }

            return 1
        }
    }
}
