//
//  SwapAble.swift
//  Arithmetic
//
//  Created by lben on 2021/4/18.
//

import Foundation

protocol SwapAble {
}

extension SwapAble {
    static func swap<T: Comparable>(_ arr: inout [T], left: Int, right: Int) {
        let tmp = arr[left]
        arr[left] = arr[right]
        arr[right] = tmp
    }
}
