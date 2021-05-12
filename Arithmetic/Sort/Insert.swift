//
//  Insert.swift
//  Arithmetic
//
//  Created by lben on 2021/4/19.
//

import Foundation

extension Sort {
    struct Insert: SwapAble {
        static func sort<T: Comparable>(_ arr: [T]) -> [T] {
            var arr = arr
            for i in 0 ..< arr.count {
                for j in (0 ... i).reversed() where j - 1 >= 0 {
                    if arr[j] < arr[j - 1] {
                        swap(&arr, left: j, right: j - 1)
                    } else {
                        continue
                    }
                }
            }
            return arr
        }
    }
}
