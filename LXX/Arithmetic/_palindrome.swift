//
//  _palindrome.swift
//  LXX
//
//  Created by lben on 2021/3/1.
//

import Foundation

// MARK: - Leetcode 9 回文数

func palindrome_num_isPalindrome(_ x: Int) -> Bool {
//    121 = 121
//    123321
    guard x > 0 else { return false }
    guard x > 10 else { return true }
    guard !(x % 10 == 0 && x != 0) else { return false }

    #if /* 将整个数取反后看和原来的数是否相同  */ true
        /**
            12321 % 10
         */
        var sum: Int = 0
        var num = x
        while num > 0 {
            sum = sum * 10 + num % 10
            num /= 10
        }
        return sum == x
    #endif

    #if /* 只反转一半 */ false
        /**
         121
         1221
         */
        var tailReverse = 0
        var num = x
        while num > tailReverse {
            let tail = num % 10
            num /= 10
            if num != tailReverse {
                tailReverse = tailReverse * 10 + tail
            }
        }
        return tailReverse == num
    #endif
}

// MARK: - Leetcode 125 回文字符串

func palindrome_isPalindrome(_ s: String) -> Bool {
    guard !s.isEmpty else { return false }
    var left = 0
    var right = s.count - 1
    let charts = Array(s.lowercased())

    func isPrintable(_ c: Character) -> Bool {
        return c.isLetter || c.isNumber
    }

    while left <= right {
        defer {
            left += 1
            right -= 1
        }
        while left < right, !isPrintable(charts[left]) { left += 1 }
        while right > left, !isPrintable(charts[right]) { right -= 1 }

        guard charts[left] == charts[right] else {
            return false
        }

        guard left != right - 1 && left != right else { return true }
    }

    return false
}
