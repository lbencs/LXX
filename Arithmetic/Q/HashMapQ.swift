//
//  HashMapQ.swift
//  Arithmetic
//
//  Created by lben on 2021/4/27.
//

import Foundation

struct HashMapQ {
    // MARK: - 242. Valid Anagram, 异位字母

    func isAnagram(_ s: String, _ t: String) -> Bool {
        guard s.count == t.count else { return false }
        var account = [Int](repeating: 0, count: 26)
        for (left, right) in zip(s.unicodeScalars, t.unicodeScalars) {
            account[Int(left.value - 97)] += 1
            account[Int(right.value - 97)] -= 1
        }
        for i in account where i != 0 {
            return false
        }
        return true
    }
}

extension HashMapQ: Testable {
    static func test() {
    }
}
