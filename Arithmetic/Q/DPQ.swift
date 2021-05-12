//
//  DP.swift
//  Arithmetic
//
//  Created by lben on 2021/4/22.
//

import Foundation

struct DPQ {
    class Solution {
        // MARK: - 718. Maximum Length of Repeated Subarray

        /**
         https://leetcode.com/problems/maximum-length-of-repeated-subarray/
         Input: nums1 = [1,2,3,2,1], nums2 = [3,2,1,4,7]
         Output: 3
         Explanation: The repeated subarray with maximum length is [3,2,1].
         */

        func findLength(_ nums1: [Int], _ nums2: [Int]) -> Int {
            guard !nums1.isEmpty, !nums2.isEmpty else { return 0 }
            /**
              1 2 3 2 1
              3 2 1 4 7
              连续、子数组 -> 当a[i] = n[j] 时，最长子数组的模式为：a[i-1]=a[j-1], a[i-2] = a[j-2] + ...
              =>  f(i, j) = f(i-1, j-1)
             */
            var f: [[Int]] = Array(repeating: Array(repeating: 0, count: nums2.count + 1), count: nums1.count + 1)
            var maxvalue: Int = 0

            for i in 1 ... nums1.count {
                // start with 1
                for j in 1 ... nums2.count where nums1[i - 1] == nums2[j - 1] {
                    f[i][j] = 1 + f[i - 1][j - 1]
                    maxvalue = max(maxvalue, f[i][j])
                }
            }
            return maxvalue
        }

        // MARK: - 1143. Longest Common Subsequence

        /// https://leetcode.com/problems/longest-common-subsequence/
        /**
         Input: text1 = "abcde", text2 = "ace"
         Output: 3
         Explanation: The longest common subsequence is "ace" and its length is 3.
         */
        private struct _Subsequence {
            let char: Character
            let i: Int
            let j: Int
            let length: Int
        }

        func longestCommonSubsequence(_ text1: String, _ text2: String) -> Int {
            guard !text1.isEmpty, !text2.isEmpty else { return 0 }
            let nums1 = Array(text1), nums2 = Array(text2)
            var f: [[Int]] = Array(repeating: Array(repeating: 0, count: nums2.count + 1), count: nums1.count + 1)
            /**
             dp: f(i,j) = a[i] == b[j] ? f(i-1,j-1) + 1 : max(f(i-1,j), f(i, j-1))
             */
            var maxvalue: Int = 0
            for i in 1 ... nums1.count {
                // start with 1
                for j in 1 ... nums2.count {
                    if nums1[i - 1] == nums2[j - 1] {
                        f[i][j] = f[i - 1][j - 1] + 1
                        maxvalue = max(maxvalue, f[i][j])
                    } else {
                        f[i][j] = max(f[i - 1][j], f[j - 1][i])
                    }
                }
            }
            return maxvalue
        }

        // MARK: - 300. Longest Increasing Subsequence

        /// https://leetcode.com/problems/longest-increasing-subsequence/
        /// Input: nums = [10,9,2,5,3,7,101,18]
        /// Output: 4
        /// Explanation: The longest increasing subsequence is [2,3,7,101], therefore the length is 4.
        private struct _LISRef {
            var length: Int
            var endIndex: Int
        }

        func lengthOfLIS(_ nums: [Int]) -> Int {
            guard nums.count > 1 else { return nums.count }
            // f[0] = 1
            // f[1] = f[0].length + 1 && nums[f[0].endIndex] < nums[1]
            var list: [_LISRef] = []
            var max: _LISRef = _LISRef(length: -1, endIndex: 0)
            for index in 0 ..< nums.count {
                if index == 0 {
                    list.append(_LISRef(length: 1, endIndex: 0))
                    max = list[0]
                } else {
                    var lis_index = _LISRef(length: 1, endIndex: index)
                    for i in 0 ..< index {
                        let ref = list[i]
                        if lis_index.length <= ref.length {
                            if nums[ref.endIndex] < nums[index] {
                                lis_index.length = ref.length + 1
                                lis_index.endIndex = index
                            }
                        }
                    }
                    list.append(lis_index)
                    if max.length < lis_index.length {
                        max = lis_index
                    }
                }
            }
            return max.length
        }

//        [1,3,6,7,9,4,10,5,6]

        // MARK: - 97. Interleaving String

        func isInterleave(_ s1: String, _ s2: String, _ s3: String) -> Bool {
            guard s1.count + s2.count == s3.count else { return false }
            // the first one is from a or from b
            let a1 = Array(s1), a2 = Array(s2), a3 = Array(s3)
            var f: [[Bool]] = []
            for _ in 0 ... a1.count {
                var cloums: [Bool] = []
                for _ in 0 ... a2.count {
                    cloums.append(false)
                }
                f.append(cloums)
            }
            // f(i,j) = f(i−1,j) && s1(i−1)=s3(p)
            // f(i,j) = f(i,j−1) && s2(j−1)=s3(p)
            // p = i + j - 1
            f[0][0] = true
            for i in 0 ... a1.count {
                for j in 0 ... a2.count {
                    let p = i + j - 1
                    if i > 0 {
                        f[i][j] = (f[i - 1][j] && a1[i - 1] == a3[p]) || f[i][j]
                    }
                    if j > 0 {
                        f[i][j] = (f[i][j - 1] && a2[j - 1] == a3[p]) || f[i][j]
                    }
                }
            }
            return f[a1.count][a2.count]
        }

        // MARK: - 70. Climbing Stairs

        // 1 or 2
        func climbStairs(_ n: Int) -> Int {
            // f(4) = f(3) + 1 + f(2) + 2
            // f(1) = 1
            // f(2) = 2
            // f(3) = f(2) + f(1)
            // f(n) = f(n-1) + f(n-2)
            guard n > 2 else { return n }
            var f = [1, 2] // 1, 2
            for _ in 3 ... n {
                (f[0], f[1]) = (f[1], f[1] + f[0])
            }
            return f[1]
        }

        // MARK: - 63. Unique Paths II

        func uniquePathsWithObstacles(_ obstacleGrid: [[Int]]) -> Int {
            guard !obstacleGrid.isEmpty else { return 0 }
            // f(0,0) = 0
            // f(0,1) = 1
            // f(1,0) = 1
            // f(1,1) = f(0, 1) + f(1, 0) = 2
            // f(i,j) = f(i-1,j) + f(i, j-1)
            var f = obstacleGrid.map({ $0.map({ $0 == 1 ? 0 : 1 }) })
            let m = obstacleGrid.count
            let n = obstacleGrid[0].count // 0 or 1
            // 1 -> 石头
            // 0 -> 通路
            for i in 0 ..< m {
                for j in 0 ..< n {
                    if f[i][j] == 0 { continue }
                    if i == 0, j == 0 {
                        f[i][j] = 1
                    } else if i == 0 {
                        f[i][j] = f[i][j - 1]
                    } else if j == 0 {
                        f[i][j] = f[i - 1][j]
                    } else {
                        f[i][j] = f[i - 1][j] + f[i][j - 1]
                    }
                }
            }
            return f[m - 1][n - 1]
        }

        // MARK: - 62. Unique Paths

        // https://leetcode.com/problems/unique-paths/
        func uniquePaths(_ m: Int, _ n: Int) -> Int {
            guard m > 0, n > 0 else { return 0 }
            // f(0,0) = 0
            // f(0,1) = 1
            // f(1,0) = 1
            // f(1,1) = f(0, 1) + f(1, 0) = 2
            // f(i,j) = f(i-1,j) + f(i, j-1)
            var f = Array(repeating: Array(repeating: 0, count: n), count: m)
            for i in 0 ..< m {
                for j in 0 ..< n {
                    if i == 0, j == 0 {
                        f[i][j] = 1
                    } else if i == 0 {
                        f[i][j] = f[i][j - 1]
                    } else if j == 0 {
                        f[i][j] = f[i - 1][j]
                    } else {
                        // i> 0, j > 0
                        f[i][j] = f[i - 1][j] + f[i][j - 1]
                    }
                }
            }
            return f[m - 1][n - 1]
        }
    }
}

extension DPQ: Testable {
    static func test() {
    }
}
