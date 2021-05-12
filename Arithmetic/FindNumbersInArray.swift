//
//  FindNumbersInArray.swift
//  Arithmetic
//
//  Created by lben on 2021/4/16.
//

import Foundation

// 3、求组里面有正，负，0，找两个数，他们的和等于给定的目标值
struct FindNumbersInArray {
    class Solution {
        func sort(array: [Int]) -> [Int] {
            return array.sorted()
        }

        func findNumbers2(from array: [Int], sum: Int) -> [Int] {
            // Map -> 记录数、出现次数
            let map: [Int: Int] = array.reduce([Int: Int]()) { map, key in
                var map = map
                let count = map[key] ?? 0
                map[key] = count + 1
                return map
            }

            // N
            for i in array {
                let second = sum - i
                let secondCount = map[second] ?? 0
                if secondCount <= 0 {
                    continue
                }
                if i == second, secondCount > 1 {
                    return [i, i]
                }
                if i != second, secondCount > 0 {
                    return [i, second]
                }
            }
            return []
        }

        func findNumbers(from array: [Int], sum: Int) -> [Int] {
            guard array.count >= 2 else { return [] }
            // 1. 先排序
            let array = sort(array: array)
            // 2. 前后指针法查找
            var pre: Int = 0
            var trail: Int = array.count - 1
            while pre <= trail {
                let left = array[pre]
                let right = array[trail]
                if left + right == sum {
                    return [left, right]
                } else if left + right < sum {
                    pre += 1
                } else {
                    // > sum
                    trail -= 1
                }
            }
            return []
        }
    }

    static func test() {
//        https://blog.csdn.net/suibianshen2012/article/details/51923477
        print(Solution().findNumbers2(from: [1, 2, -1, 0, 8, 3, 3, 9], sum: 9))
        print(Solution().findNumbers2(from: [1, 2, -1, 0, 8, 3, 3, 9], sum: 7))
        print(Solution().findNumbers2(from: [1, 2, -1, 0, 8, 3, 3, 9], sum: 0))
    }
}
