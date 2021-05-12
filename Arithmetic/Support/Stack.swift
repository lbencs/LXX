//
//  Stack.swift
//  Arithmetic
//
//  Created by lben on 2021/4/16.
//

import Foundation

class Stack<T> {
    let linkedList = LinkedList<T>()
    func push(_ value: T) {
        linkedList.insertTo(head: value)
    }

    var isEmpty: Bool {
        return linkedList.isEmpty
    }

    func top() -> T? {
        return linkedList.headValue()
    }

    @discardableResult
    func pop() -> T? {
        return linkedList.removeHead()
    }
    
    func empty() {
        linkedList.empty()
    }
}
