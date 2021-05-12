//
//  sliding_window.swift
//  LXX
//
//  Created by lben on 2021/2/26.
//

import Foundation

// MARK: - Leetcode 209. 长度最小的子数组

/**
 给定一个含有 n 个正整数的数组和一个正整数 s ，找出该数组中满足其和 ≥ s 的长度最小的连续子数组。如果不存在符合条件的连续子数组，返回 0。

 示例:

 输入: s = 7, nums = [2,3,1,2,4,3]
 输出: 2
 解释: 子数组 [4,3] 是该条件下的长度最小的连续子数组。
 */
func sliding_window_minSubArrayLen(_ target: Int, _ nums: [Int]) -> Int {
    ///
    guard !nums.isEmpty else { return 0 }

    #if /* 暴力拆解法  */ false
        /// o(n^3) 性能严重超时
        var resultArr: [Int] = []
        let n = nums.count
        for i in 0 ..< n {
            for j in i ..< n {
                if !resultArr.isEmpty && resultArr.count < (j - i) + 1 {
                    break
                }
                var tmpArr: [Int] = []
                for index in i ... j {
                    tmpArr.append(nums[index])
                }
                if tmpArr.reduce(0, { res, e in res + e }) >= target {
                    if resultArr.isEmpty || resultArr.count > tmpArr.count {
                        resultArr = tmpArr
                    }
                }
            }
        }
        arith_print(resultArr)
        return resultArr.count
    #endif

    #if /* 滑动窗口法  */ false
        let n = nums.count
        // 窗口
        var left = 0
        var right = -1 /* 小技巧  */

        var result: Int = n + 1
        var sum: Int = 0

        while right < n - 1 {
            while sum < target && right < n - 1 /* 滑动窗口右侧移动  */ {
                right += 1
                sum += nums[right]
                if sum >= target {
                    result = min(right - left + 1, result)
                }
            }

            while sum >= target && left < right /* 滑动窗口左侧移动  */ {
                sum -= nums[left]
                left += 1

                if sum >= target {
                    result = min(right - left + 1, result)
                }
            }

            if left == right {
                right += 1
                if right < n - 1 {
                    sum += nums[right]
                }
            }
        }
        return result == n + 1 ? 0 : result
    #endif

    #if /* 滑动窗口法 - 优化 */ false
        var resNum = Int.max
        var left = 0
        var right = 0
        var sum: Int = 0
        while right < nums.count {
            sum += nums[right]
            while sum >= target {
                resNum = min(resNum, right - left + 1)
                sum -= nums[left]
                left += 1
            }
            right += 1
        }
        return resNum == Int.max ? 0 : resNum
    #endif

    #if /* 滑动窗口法 - 优化 */ true
        var resNum = Int.max
        var left = 0
        var sum: Int = 0

        for right in 0 ..< nums.count {
            sum += nums[right]
            while sum >= target {
                resNum = min(resNum, right - left + 1)
                sum -= nums[left]
                left += 1
                if resNum == 1 { return resNum }
            }
        }
        return resNum == Int.max ? 0 : resNum
    #endif
}

// MARK: - Leetcode 3. 无重复字符的最长子串

func sliding_window_lengthOfLongestSubstring(_ s: String) -> Int {
    /**
     [a]abcdd => abc
     */
    guard s.count > 1 else { return s.count }
    let sArr = Array(s)

    var maxLen = 0
    var window: [Character] = []

    for right in 0 ..< s.count {
        let c = sArr[right]
        if !window.contains(c) {
            window.append(c)
            maxLen = max(maxLen, window.count)
        } else {
            while window.contains(c) { window.removeFirst() }
            window.append(c)
        }
    }

    return maxLen
}
