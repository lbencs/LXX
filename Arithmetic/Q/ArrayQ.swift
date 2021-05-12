//
//  ArrayQ.swift
//  Arithmetic
//
//  Created by lben on 2021/4/21.
//

import Foundation

struct ArrayQ {
    // MARK: - 801. Minimum Swaps To Make Sequences Increasing

    func minSwap(_ A: [Int], _ B: [Int]) -> Int {
        var A = A, B = B
        var f: [Int] = Array(repeating: 0, count: A.count)
        for i in 0 ..< A.count {
            if i == 0 {
                f[0] = 0
            } else {
                if A[i] > A[i - 1] {
                    (A[i], B[i]) = (B[i], A[i])
                    f[i] = f[i - 1] + 1
                } else {
                    f[i] = f[i - 1]
                }
            }
        }
        return f[A.count - 1]
    }

    // MARK: - 845. Longest Mountain in Array

    /// https://leetcode.com/problems/longest-mountain-in-array/
    static func longestMountain(with array: [Int]) -> Int {
        return 1
    }

    // MARK: - ?

    // 给定一个Int型数组，用里面的元素组成一个最大数
    // 输入: [3, 9, 308, 30,34,5,91] [2,25,1]
    // 输出: 9534330
    static func maxNumber(with arr: [Int]) -> String {
        // -> 9 -> 5 -> 3
        #if true
            guard !arr.isEmpty else { return "" }
            let sorted = Sort.Bubble.Quick.sort(arr) { (lhs, rhs) -> Bool in
                "\(lhs)\(rhs)" > "\(rhs)\(lhs)"
            }
            guard sorted.first ?? 0 > 0 else {
                return ""
            }
            return sorted.map({ "\($0)" }).joined()
        #else
            let sorted = arr.map({ "\($0)" }).sorted { (lhs, rhs) -> Bool in
                lhs + rhs > rhs + lhs
            }
            return sorted.joined()
        #endif
    }

    // MARK: - 238. Product of Array Except Self

    func productExceptSelf(_ nums: [Int]) -> [Int] {
        let noZeroNums = nums.filter({ $0 != 0 })
        let zeroCount = nums.count - nums.count
        guard zeroCount <= 1 else {
            return Array(repeating: 0, count: nums.count)
        }
        let productsWithoutZero = noZeroNums.reduce(1, { $0 * $1 })
        if zeroCount == 1 {
            return nums.map({ $0 == 0 ? productsWithoutZero : 0 })
        } else {
            return nums.map({ productsWithoutZero / $0 })
        }
    }
}

extension ArrayQ: Testable {
    static func test() {


//        arrayTest()
//        Water.test()
    }
}

extension ArrayQ {
    static func arrayTest() {
//        print("123")
    }
}
