//
//  Bubble.swift
//  Arithmetic
//
//  Created by lben on 2021/4/19.
//

import Foundation

struct Sort {
    struct Bubble: SwapAble {
        static func sort<T: Comparable>(_ arr: [T]) -> [T] {
            var res = arr
            for i in 0 ..< arr.count {
                for j in 0 ..< arr.count - i where j + 1 < arr.count {
                    if res[j] > res[j + 1] {
                        swap(&res, left: j, right: j + 1)
                    }
                }
            }
            return res
        }
    }
}
