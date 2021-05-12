//
//  nSumQ.swift
//  Arithmetic
//
//  Created by lben on 2021/5/7.
//

import Foundation

struct NSumQ {
    // MARK: - 1. 2Sum

    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        // to map
        var map = [Int: Int]()
        for i in 0 ..< nums.count {
            let anther = target - nums[i]
            // 插入，向前比较
            if let index = map[anther], index != i {
                return [index, i]
            }
            map[nums[i]] = i
        }
        return []
    }

    // MARK: - 15. 3Sum

    /**
     Input: nums = [-1,0,1,2,-1,-4]
     Output: [[-1,-1,2],[-1,0,1]]
     */
    // TODO: #lben -  回溯
    func threeSum(_ nums: [Int]) -> [[Int]] {
        let count = nums.count
        guard count >= 3 else { return [] }
        let nums = nums.sorted()
        var res: [[Int]] = []

        for i in 0 ..< count - 2 {
            // two sum
            if !(i == 0 || nums[i] != nums[i - 1]) {
                // same i
                continue
            }
            let sum = 0 - nums[i]
            var low = i + 1
            var high = count - 1
            while low < high {
                let s = nums[low] + nums[high]
                if s == sum {
                    res.append([nums[i], nums[low], nums[high]])
                    // double num[i] or treble num[i] will picked at first
                    while low < high && nums[low] == nums[low + 1] { low += 1 }
                    while low < high && nums[high] == nums[high - 1] { high -= 1 }
                    low += 1
                    high -= 1
                } else if s < sum {
                    low += 1
                } else {
                    high -= 1
                }
            }
        }
        return res
    }

    // MARK: - 16. 3Sum Closest

    func threeSumClosest(_ nums: [Int], _ target: Int) -> Int {
        let count = nums.count
        let nums = nums.sorted()
        var diff = Int.max
        var res = 0

        for i in 0 ..< (count - 2) {
            var low = i + 1
            var high = count - 1
            let sum = target - nums[i]

            while low < high {
                let s = nums[low] + nums[high]
                if sum == s {
                    return nums[i] + s
                } else if sum > s {
                    if sum - s < diff {
                        diff = sum - s
                        res = nums[i] + s
                    }
                    low += 1
                } else {
                    if s - sum < diff {
                        diff = s - sum
                        res = nums[i] + s
                    }
                    high -= 1
                }
            }
        }
        return res
    }

    // MARK: - 18. 4Sum -> nSum

    func _twoSum(pre: Int, last: Int, nums: [Int], target: Int) -> [[Int]] {
        var res: [[Int]] = []
        //
        var lo = pre, hi = last
        while lo < hi {
            let sub = nums[lo] + nums[hi]
            if sub == target {
                res.append([nums[lo], nums[hi]])
                while lo < hi && nums[lo] == nums[lo + 1] { lo += 1 }
                while lo < hi && nums[hi] == nums[hi - 1] { hi -= 1 }
                lo += 1
                hi -= 1
            } else if sub < target {
                lo += 1
            } else {
                hi -= 1
            }
        }
        return res
    }

    func _nSum(_ nums: [Int], pre: Int, last: Int, target: Int, n: Int) -> [[Int]] {
        if n <= 2 {
            return _twoSum(pre: pre, last: last, nums: nums, target: target)
        } else {
            // bigger than 2
            var res = [[Int]]()
            var i = pre
            let tail = last - n + 2
            while i != tail + 1 {
                let nRes = _nSum(nums, pre: i + 1, last: last, target: target - nums[i], n: n - 1)
                res.append(contentsOf: nRes.map({ $0 + [nums[i]] }))
                while i < tail && nums[i] == nums[i + 1] { i += 1 }
                i += 1
            }
            return res
        }
    }

    func fourSum(_ nums: [Int], _ target: Int) -> [[Int]] {
        // target - nums[i] = 3sum
        // 2sum - nums[j] = 2sum
        let nums = nums.sorted()
        return _nSum(nums, pre: 0, last: nums.count - 1, target: target, n: 4)
    }

    // MARK: - 454. 4Sum II

    func fourSumCount(_ nums1: [Int], _ nums2: [Int], _ nums3: [Int], _ nums4: [Int]) -> Int {
        return 1
    }
}

extension NSumQ: Testable {
    static func test() {
//        print(NSumQ().fourSum([-5, -4, -3, -2, -1, 0, 0, 1, 2, 3, 4, 5], 0))
//
//        print([[-5, -4, 4, 5], [-5, -3, 3, 5], [-5, -2, 2, 5], [-5, -2, 3, 4], [-5, -1, 1, 5], [-5, -1, 2, 4], [-5, 0, 0, 5], [-5, 0, 1, 4], [-5, 0, 2, 3], [-4, -3, 2, 5], [-4, -3, 3, 4], [-4, -2, 1, 5], [-4, -2, 2, 4], [-4, -1, 0, 5], [-4, -1, 1, 4], [-4, -1, 2, 3], [-4, 0, 0, 4], [-4, 0, 1, 3], [-3, -2, 0, 5], [-3, -2, 1, 4], [-3, -2, 2, 3], [-3, -1, 0, 4], [-3, -1, 1, 3], [-3, 0, 0, 3], [-3, 0, 1, 2], [-2, -1, 0, 3], [-2, -1, 1, 2], [-2, 0, 0, 2], [-1, 0, 0, 1]].map({ $0.sorted() }).sorted(by: { lhs, rhs in lhs[0] < rhs[0] }))
    }
}
