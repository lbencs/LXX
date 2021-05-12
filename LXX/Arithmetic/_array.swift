//
//  array_deduplication.swift
//  LXX
//
//  Created by lben on 2021/2/25.
//

import Foundation

// MARK: - 数组去重

func array_deduplication(array: [Int]) -> [Int] {
    // [0,0,1,1,1,2,2,3,3,4]
    // 如何去除有序数组的重复元素（升序）
    // 【无序】 放到一个Dictionary中，然后再取出其Key值
    // 遍历一遍，后者等于前者，删除
    /**
        快慢指针：慢指针为最终目的数据，快指针往后遍历
     */
    var array = array
    let len = array.count
    guard len > 1 else { return array }
    var slow = 0, fast = 1
    while fast < len {
        if array[fast] != array[slow] {
            slow += 1
            array[slow] = array[fast]
        }
        fast += 1
    }
    return Array(array[0 ... slow])
}
