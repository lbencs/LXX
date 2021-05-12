//
//  Recursion.swift
//  Arithmetic
//
//  Created by lben on 2021/4/19.
//

import Foundation

struct Recursion {
    /**
     1. 用递归写一个算法，计算从1到100的和。[Swift]
       * 算法的时间复杂度是多少
       * 递归会有什么缺点
       * 不用递归能否实现，复杂度能否降到O(1)
     */
    /// o(n)
    static func sum(from: Int, to: Int) -> Int {
        if to - from == 1 { return to + from }
        return to + sum(from: from, to: to - 1)
    }

    static func sum2(from: Int, to: Int) -> Int {
        var res: Int = 0
        for i in from ... to {
            res += i
        }
        return res
    }

    /**
     2. 求x的n次方
     */
    static func power(nth n: Int, for x: Int) -> Int {
        // 2*2*2
        if n == 0 { return 1 }
        if n == 1 { return x }
        let m = n / 2
        return power(nth: m, for: x) * power(nth: n - m, for: x)
    }

    static func power2(nth n: Int, for x: Int) -> Int {
        // 2*2*2
        if n == 0 { return 1 }
        return x * power2(nth: n - 1, for: x)
    }

    static func power3(nth n: Int, for x: Int) -> Int {
        // 2*2*2
        if n == 0 { return 1 }
        let t = power3(nth: n / 2, for: x)
        if n % 2 == 1 {
            return t * t * x
        }
        return t * t
    }

    static func tailPower(nth n: Int, for x: Int, res: inout Int) {
        if n == 0 {
            res = 1 * res
            return
        }
        res = x * res
        tailPower(nth: n - 1, for: x, res: &res)
    }

    static func power4(nth n: Int, for x: Int) -> Int {
        var res: Int = 1
        for _ in 0 ..< n {
            res *= x
        }
        return res
    }
}
