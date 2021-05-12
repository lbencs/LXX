//
//  MaxBottle.swift
//  Arithmetic
//
//  Created by lben on 2021/4/16.
//

import Foundation

struct MaxBottle {
    /**
     * The rand7() API is already defined in the parent class SolBase.
     * func rand7() -> Int = {}
     * @return a random integer in the range 1 to 7
     */
    class Solution {
        func maxNums(with n: Int) -> Int {
            struct Bottles {
                let num: Int
                let leave: Int
            }
            guard n >= 2 else { return 0 }
            var pre: Bottles = Bottles(num: 1, leave: 0)
            for _ in 3 ... n {
                var num = pre.num
                var leave = pre.leave + 1
                if leave == 2 {
                    num += 1
                    leave = 0
                }
                pre = Bottles(num: num, leave: leave)
            }
            return pre.num
        }
    }

    static func test() {
        print("\(3) -> \(Solution().maxNums(with: 3))")
        print("\(10) -> \(Solution().maxNums(with: 10))")
        print("\(81) -> \(Solution().maxNums(with: 81))")
        print("\(0) -> \(Solution().maxNums(with: 0))")
    }
}
