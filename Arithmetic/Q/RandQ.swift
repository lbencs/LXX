//
//  Rand.swift
//  Arithmetic
//
//  Created by lben on 2021/4/16.
//

import Foundation
struct Rand {
    class SolBase {
        func rand7() -> Int {
            return Int.random(in: 1 ... 7)
        }

        func rand5() -> Int {
            return Int.random(in: 0 ... 5)
        }
    }

    /**
     * The rand7() API is already defined in the parent class SolBase.
     * func rand7() -> Int = {}
     * @return a random integer in the range 1 to 7
     */
    class Solution: SolBase {
        func rand10() -> Int {
            // [1...7] => [1...10]
            // 如何凑齐 1 - 5
            // 1-5 + 5
            var tmp1: Int = 0
            var tmp2: Int = 0
            repeat {
                tmp1 = rand7()
            } while tmp1 > 5
            repeat {
                tmp2 = rand7()
            } while tmp2 > 2
            return tmp1 + (tmp2 - 1) * 5
        }

        func rand13() -> Int {
            // 0...5 [1 - 6] -> 0...13 [1 - 14]
            // 0...5 * 5 = 0 5 10 15 20 25 + [0 - 5] - [0 - 30]
            // [0 - 27] % 14
            var tmp: Int = 0
            repeat {
                // 0 6 12 18 24 30 + 0...5
                tmp = rand5() * 6 + rand5()
            } while tmp > 27
            return tmp % 14
        }

        func rand27() -> Int {
            // 0...5 -> 0...13
            // 0 3 6 9 12 15 + (0 1 2)
            var rand3: Int = 0
            repeat {
                rand3 = rand5()
            } while rand3 > 2

            var tmp: Int = 0
            repeat {
                // 0 5 10 15 20 25 + 0...5
                tmp = rand5() * 3 + rand3
            } while tmp > 27
            return tmp
        }
    }

    static func testrand27() {
        var arr: [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        for _ in 0 ... 1000000 {
            let index: Int = Solution().rand27()
            arr[index] += 1
        }
        print(arr)
    }

    static func testrand13() {
        var arr: [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        for _ in 0 ... 100000 {
            let index: Int = Solution().rand13()
            arr[index] += 1
        }
        print(arr)
    }

    static func testrand10() {
        var arr: [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        for _ in 0 ... 100000 {
            let index: Int = Solution().rand10() - 1
            arr[index] += 1
        }
        print(arr)
    }
}
