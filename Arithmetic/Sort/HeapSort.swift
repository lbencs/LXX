//
//  Heap.swift
//  Arithmetic
//
//  Created by lben on 2021/4/18.
//

import Foundation

extension Sort {
    struct Heap: SwapAble {
        static func build<T: Comparable>(_ arr: [T]) -> [T] {
            guard !arr.isEmpty else { return arr }
            var result = arr
            for tail in 0 ..< arr.count {
                _adjust(&result, tail: tail)
            }
            return result
        }

        // 叶节点往上调整
        private static func _adjust<T: Comparable>(_ arr: inout [T], tail: Int) {
            //       0
            //     1   2
            //   3  4 5  6
            var tail = tail
            while tail > 0 {
                let parent = tail % 2 == 0 ? ((tail / 2) - 1) : (tail / 2)
                if arr[parent] < arr[tail] {
                    swap(&arr, left: parent, right: tail)
                }
                tail = parent
            }
        }

        // 根部，往下调整
        private static func _adjustValue<T: Comparable>(_ arr: inout [T], tail: Int) {
            swap(&arr, left: tail, right: 0)
            var root = 0
            while root < tail {
                let left = 2 * root + 1
                let right = 2 * (root + 1)

                let maxChildIndex: Int
                if left < tail, right < tail {
                    maxChildIndex = arr[left] > arr[right] ? left : right
                } else if left < tail {
                    maxChildIndex = left
                } else if right < tail {
                    maxChildIndex = right
                } else {
                    return
                }
                if arr[root] < arr[maxChildIndex] {
                    swap(&arr, left: maxChildIndex, right: root)
                }
                root = maxChildIndex
            }
        }

        static func sort<T: Comparable>(_ arr: [T]) -> [T] {
            var heap: [T] = build(arr)
            for tail in (0 ..< arr.count).reversed() {
                _adjustValue(&heap, tail: tail)
            }
            return heap
        }
    }
}
