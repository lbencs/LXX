//
//  LinkedListQ.swift
//  Arithmetic
//
//  Created by lben on 2021/4/22.
//

import Foundation

struct LinkedListQ {
    public class ListNode {
        public var val: Int
        public var next: ListNode?
        public init() { val = 0; next = nil }
        public init(_ val: Int) { self.val = val; next = nil }
        public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next }
    }

    // MARK: - 19. Remove Nth Node From End of List

    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        guard let head = head else { return nil }
        var n = n - 1
        var slow: ListNode?
        var fast: ListNode? = head

        while n > 0 {
            fast = fast?.next
            n -= 1
        }
        if fast?.next == nil {
            // rm head
            return head.next
        } else {
            slow = head
            fast = fast?.next
        }

        while fast?.next != nil {
            slow = slow?.next
            fast = fast?.next
        }

        // rm slow->next
        fast = slow?.next
        slow?.next = slow?.next?.next
        fast?.next = nil
        return head
    }
}

// MARK: - 232. Implement Queue using Stacks

// https://leetcode.com/problems/implement-queue-using-stacks/
class MyQueue {
    let instack = Stack<Int>()
    let outstack = Stack<Int>()

    /** Initialize your data structure here. */
    init() {
    }

    /** Push element x to the back of queue. */
    func push(_ x: Int) {
        instack.push(x)
    }

    /** Removes the element from in front of queue and returns that element. */
    func pop() -> Int {
        _transfer()
        return outstack.pop() ?? 0
    }

    /** Get the front element. */
    func peek() -> Int {
        _transfer()
        return outstack.top() ?? 0
    }

    /** Returns whether the queue is empty. */
    func empty() -> Bool {
        instack.empty()
        outstack.empty()
        return true
    }

    private func _transfer() {
        if outstack.isEmpty {
            while let v = instack.pop() {
                outstack.push(v)
            }
        }
    }
}
