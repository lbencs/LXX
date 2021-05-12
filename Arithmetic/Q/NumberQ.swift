//
//  NumberQ.swift
//  Arithmetic
//
//  Created by lben on 2021/4/21.
//

import Foundation

struct NumberQ {
    // MARK: - 7
    //  leetcode 7. Reverse Integer
    //  Input: x = 123
    //  Output: 321
    class Solution {
        private func _pow(_ lhs: Int, _ rhs: Int) -> Int {
            return Int(pow(Float(lhs), Float(rhs)))
        }

        func reverse(_ x: Int) -> Int {
            guard !(-9 ... 9).contains(x) else {
                return x
            }

            var x = x
            var res = 0
            while (x > 0 && x > 10) || (x < 0 && x < -10) {
                let n = x % 10
                res = (res + n) * 10
                x /= 10
            }
            res += x
            if res < _pow(2, 31) - 1 && res > -_pow(2, 31) {
                return res
            }
            return 0
        }
    }
}
