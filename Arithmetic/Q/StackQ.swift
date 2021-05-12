//
//  File.swift
//  Arithmetic
//
//  Created by lben on 2021/4/25.
//

import Foundation

// MARK: - 225. Implement Stack using Queues

// https://leetcode.com/problems/implement-stack-using-queues/description/

struct StackQ {
    // MARK: - 20. Valid Parentheses

    func isValid(_ s: String) -> Bool {
        //
        var stack = [Character]()
        let map = ["]": "[",
                   ")": "(",
                   "}": "{"]
        for e in s {
            if let top = stack.peek(), map[e] == top {
                stack.pop()
            } else {
                stack.push(e)
            }
        }
        return stack.isEmpty
    }

    // MARK: - 22. Generate Parentheses

    func generateParenthesis(_ n: Int) -> [String] {
        // 用栈 ->
        // TODO: #lben -  非递归
    }

    #if false
        func generateParenthesis(_ n: Int) -> [String] {
            /**
             1. 利用递归不断调用的特性
             */
            func _track(_ list: inout [String], str: String, open: Int, close: Int, max: Int) {
                if str.count == 2 * max {
                    list.append(str)
                    return
                }
                if open < max {
                    _track(&list, str: "(", open: open + 1, close: close, max: max)
                }
                if close < open {
                    _track(&list, str: ")", open: open, close: close + 1, max: max)
                }
            }
            var res: [String] = []
            _track(&res, str: "", open: 0, close: 0, max: n)
            return res
        }
    #endif
}
