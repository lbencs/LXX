//
//  RotateQ.swift
//  Arithmetic
//
//  Created by lben on 2021/5/8.
//

import Foundation

struct RotateQ {
    public class ListNode {
        public var val: Int
        public var next: ListNode?
        public init() { val = 0; next = nil }
        public init(_ val: Int) { self.val = val; next = nil }
        public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next }
    }

    // MARK: - 61. Rotate List

    /**
     [1,2,3,4,5]
     2
     [0,1,2]
     4
     [12]
     0
     [1,2,3]
     2000000000
     */
    func rotateRight(_ head: ListNode?, _ k: Int) -> ListNode? {
        guard let h = head, h.next != nil, k > 0 else { return head }
        // 1. 减少rotate
        var length = 1
        var p = head
        while p?.next != nil {
            length += 1
            p = p?.next
        }
        let tail = p
        p?.next = head

        // 2. rotate
        var k = k % length
        var slow: ListNode? = head
        var fast: ListNode? = head

        while k > 0 {
            if fast?.next == nil {
                fast?.next = h
                fast = h
            } else {
                fast = fast?.next
            }
            k -= 1
        }

        while fast?.next !== (tail == nil ? nil : head) {
            slow = slow?.next
            fast = fast?.next
        }

        fast = slow?.next
        slow?.next = nil
        return fast
    }

    // MARK: - 189. Rotate Array

    func rotate(_ nums: inout [Int], _ k: Int) {
        //    [1,2,3,4,5,6,7], k = 3
        // => [5,6,7,1,2,3,4]
        let count = nums.count
        let k = k % count
        if k == 0 { return }

        var index = -1
        var total = count

        while total > 0 {
            index += 1
            let start = index
            var tmp = nums[index]
            // 会 -> 循环
            while total > 0 {
                total -= 1
                index = (index + k) % count
                (tmp, nums[index]) = (nums[index], tmp)
                if index == start { break }
            }
        }
    }
}

extension RotateQ: Testable {
    static func test() {
//        var num = [1, 2, 3, 4, 5, 6, 7]
//        ArrayQ().rotate(&num, 3)
//        print(num)
//        var num2 = [-1, -100, 3, 99]
//        ArrayQ().rotate(&num2, 2)
//        print(num2)
    }
}
