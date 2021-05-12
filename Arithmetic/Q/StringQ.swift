//
//  Space.swift
//  Arithmetic
//
//  Created by lben on 2021/4/19.
//

import Foundation
struct StringQ {
    class Solution {
        // MARK: - 151. Reverse Words in a String

        /// Input: s = "the sky is blue"
        /// Output: "blue is sky the"
        func reverseWords(_ s: String) -> String {
            guard !s.isEmpty else { return s }
            var chs: [Character] = []
            var sentry = 0
            for e in Array(s) {
                if e == " " {
                    if !chs.isEmpty, chs[0] != " " {
                        // one word over
                        chs.insert(e, at: 0)
                        sentry = 0
                    } else {
                        // space removed
                    }
                } else {
                    // insert word
                    chs.insert(e, at: sentry)
                    sentry += 1
                }
            }
            if chs[0] == " " { chs.remove(at: 0) }
            return String(chs)
        }

        // MARK: - 434. Number of Segments in a String

        /// Input: s = "Hello, my name is John"
        /// Output: 5
        /// Explanation: The five segments are ["Hello,", "my", "name", "is", "John"]
        func countSegments(_ s: String) -> Int {
            guard !s.isEmpty else { return 0 }
            var count: Int = 0
            var pee = 0

            for c in Array(s) {
                if c != " " {
                    pee += 1
                    continue
                }
                if pee > 0 {
                    count += 1
                    pee = 0
                }
            }
            return count + (pee > 0 ? 1 : 0)
        }
    }
}

extension StringQ: SwapAble {
    struct RemoveSpace {
        static func run(_ stringArr: [Character]) -> [Character] {
            var arr = stringArr
            var former: Int = -1
            var next: Int = 0
            while next < arr.count {
                if arr[next] != " " {
                    former += 1
                    arr[former] = arr[next]
                    next += 1
                } else {
                    next += 1
                }
            }
            return Array(arr[0 ... former])
        }
    }

    static func reversed(_ value: String) -> String {
        guard !value.isEmpty else { return value }
        var chars = Array(value)
        var former: Int = 0
        var last: Int = chars.count - 1
        while former < last {
            swap(&chars, left: former, right: last)
            former += 1
            last -= 1
        }
        return String(chars)
    }
}

// MARK: - Reverse

extension StringQ {
    // MARK: - 344. Reverse String

    func reverseString(_ s: inout [Character]) {
        guard s.count > 1 else { return }
        var former = 0
        var last = s.count - 1
        while former < last {
            (s[former], s[last]) = (s[last], s[former])
            former += 1
            last -= 1
        }
    }

    // MARK: - 541. Reverse String II

    /**
     Input: s = "abcd efg", k = 2
     Output: "bacd feg"
     */
    func _reverseString(_ s: inout [Character], left: Int, right: Int) {
        guard left < right else { return }
        var former = left
        var last = right
        while former < last {
            (s[former], s[last]) = (s[last], s[former])
            former += 1
            last -= 1
        }
    }

    func reverseStr(_ s: String, _ k: Int) -> String {
        var chars = Array(s)
        var index = -1
        while index < s.count {
            let former = index + 1
            let last = min(index + k, s.count - 1)
            _reverseString(&chars, left: former, right: last)
            index += 2 * k
        }
        return String(chars)
    }

    // MARK: - 557. Reverse Words in a String III

    func reverseWords2(_ s: String) -> String {
        var slow = 0, fast = 0
        var chars = Array(s)
        let count = s.count
        while fast <= count {
            if fast == count || chars[fast] == " " {
                _reverseString(&chars, left: slow, right: fast - 1)
                slow = fast + 1
            }
            fast += 1
        }
        return String(chars)
    }

    // MARK: - 151. Reverse Words in a String

    func reverseWords(_ s: String) -> String {
        guard !s.isEmpty else { return s }
        var chs: [Character] = []
        // 1 去空格
        var sentry = 0

        for e in Array(s) {
            if e == " " {
                if !chs.isEmpty, chs[0] != " " {
                    // one word over
                    chs.insert(e, at: 0)
                    sentry = 0
                } else {
                    // space removed
                }
            } else {
                // insert word
                // 反插入
                chs.insert(e, at: sentry)
                sentry += 1
            }
        }
        if chs[0] == " " { chs.remove(at: 0) }
        return String(chs)
    }
}

extension StringQ {
    static func runTest() {
//        print(StringQ().reverseStr("abcdefg", 2))
//        print(StringQ().reverseStr("abcd", 2))
        print(StringQ().reverseStr("abcdefg", 8))
    }
}
