//
//  Select.swift
//  Arithmetic
//
//  Created by lben on 2021/4/19.
//

import Foundation

extension Sort {
    struct Select: SwapAble {
        static func sort<T: Comparable>(_ arr: [T]) -> [T] {
            var res = arr
            for i in 0 ..< res.count {
                var tmp = 0
                for j in 0 ..< res.count - i {
                    if res[j] > res[tmp] {
                        tmp = j
                    }
                }
                swap(&res, left: res.count - 1 - i, right: tmp)
            }
            return res
        }
    }
}
