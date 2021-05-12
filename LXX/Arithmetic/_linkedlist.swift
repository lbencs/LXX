//
//  _linkedlist.swift
//  LXX
//
//  Created by lben on 2021/2/26.
//

import Foundation

// MARK: - 单链表去重

func linkList_deduplication(list: LinkedList<Int>) {
    guard let head = list.head else {
        return
    }
    var slow = head
    var fast = list.head?.next

    while let f = fast {
        if slow.value != f.value {
            slow = slow.next!
            slow.value = f.value
        }
        fast = f.next
    }
    slow.next = nil
    list.tail = slow
}
