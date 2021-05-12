//
//  ArrayQ+Water.swift
//  Arithmetic
//
//  Created by lben on 2021/4/30.
//

import Foundation

// MARK: - 容器装水问题

extension ArrayQ {
    struct Water: DoublePoint {
        // MARK: - 11. Container With Most Water

        /**
            思考一个问题，如何才能装最多的水 -> min(max(left), max(right)) * (right - left)
            => 要么左边大，要么右边大
         */
        func maxArea(_ height: [Int]) -> Int {
            guard height.count > 1 else { return 0 }
            var maxArea = 0
            var left = height[0]
            var right = height[height.count - 1]
            while left < right {
                let width = right - left
                let h: Int
                if height[left] < height[right] {
                    h = left
                    left += 1
                } else {
                    h = right
                    right -= 1
                }
                maxArea = max(maxArea, width * h)
            }
            return maxArea
        }

        // MARK: - 42. Trapping Rain Water

        /**
         1. 暴力法 -> max(left) me max(right) -> 分别求出每一个数所能装的水量
         2. 预处理数组 -> 先求出每一个数max(lef)max(right)，存入数组，再求解
         3. 左右指针法 -> 左右是对称的，都可以确定自己一侧的max值
         [1 5 3 8 9 6 3]
         max(left)       max(right)
          */
        func trap(_ height: [Int]) -> Int {
            guard height.count > 2 else { return 0 }
            var left = 1, right = height.count - 2
            var leftMax = height[0], rightMax = height[height.count - 1]
            var sum: Int = 0

            while left <= right {
                if left == right {
                    sum += max(0, min(leftMax, rightMax) - height[left])
                    break
                } else {
                    if rightMax > leftMax {
                        sum += max(0, leftMax - height[left])
                        leftMax = max(height[left], leftMax)
                        left += 1
                    } else {
                        sum += max(0, rightMax - height[right])
                        rightMax = max(height[right], rightMax)
                        right -= 1
                    }
                }
            }
            return sum
        }

        // MARK: - 407. Trapping Rain Water II

        func trapRainWater(_ heightMap: [[Int]]) -> Int {
            return 2
        }
    }
}

extension ArrayQ.Water: Testable {
    static func trapTest() {
        precondition(ArrayQ.Water().trap([0, 1, 0, 2, 1, 0, 1, 3, 2, 1, 2, 1]) == 6)
        precondition(ArrayQ.Water().trap([4, 2, 0, 3, 2, 5]) == 9)
    }

    static func trapRainWaterTest() {
    }

    static func test() {
        // trapTest()
        // trapRainWaterTest()
    }
}
