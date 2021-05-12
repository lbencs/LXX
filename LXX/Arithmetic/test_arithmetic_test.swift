//
//  test_arithmetic_test.swift
//  LXX
//
//  Created by lben on 2021/2/25.
//

import Foundation

let ___cache = LRUCache<String, Int>()

func arith_print(_ any: @autoclosure () -> Any) {
    debugPrint("[arith] \(any())")
}

func test_arithmetic_test() {
    #if /* LRU.swift */ false
        // LRU 缓存算法
        for i in 0 ... 10 {
            let value = i % 10
            ___cache.set(value: value, for: "\(value)")
        }
        for i in 0 ... 10 {
            let value = i % 10
            arith_print("get value: \(String(describing: ___cache.value(for: "\(value)")))")
        }
    #endif

    #if /* _array.swift */ false
        arith_print(array_deduplication(array: [0, 0, 1, 1, 1, 2, 2, 3, 3, 4]))
    #endif

    #if /* _linkedlist.swift */ false
        let linkedList = LinkedList<Int>(values: [0, 0, 1, 1, 1, 2, 2, 3, 3, 4])
        linkList_deduplication(list: linkedList)
        arith_print(linkedList.values())
    #endif

    #if /* sliding_window.swift  */ false
        arith_print(sliding_window_minSubArrayLen(7, [2, 3, 1, 2, 4, 3]))
        arith_print(sliding_window_minSubArrayLen(4, [1, 4, 4]))
        arith_print(sliding_window_minSubArrayLen(15, [5, 1, 3, 5, 10, 7, 4, 9, 2, 8]))
        arith_print(sliding_window_minSubArrayLen(11, [1, 1, 1, 1, 1, 1, 1, 1]))
    #endif

    #if /* sliding_window.swift  */ false
        arith_print(sliding_window_lengthOfLongestSubstring("abcabcbb"))
        arith_print(sliding_window_lengthOfLongestSubstring("bbbbb"))
        arith_print(sliding_window_lengthOfLongestSubstring("pwwkew"))
    #endif

    #if /* _ prime_number.swift */ false
        arith_print(Date())
        arith_print(prime_number_countPrimes(0))
        arith_print(prime_number_countPrimes(1))
        arith_print(prime_number_countPrimes(2))
        arith_print(prime_number_countPrimes(3))
        arith_print(prime_number_countPrimes(1500000))
        arith_print(Date())
    #endif

    arith_print(prime_number_primePalindrome(6))
//    arith_print(prime_number_primePalindrome(8))
//    arith_print(prime_number_primePalindrome(13))

    #if /* _palindrome.swift */ false
        arith_print(palindrome_num_isPalindrome(121))
        arith_print(palindrome_num_isPalindrome(-121))
        arith_print(palindrome_num_isPalindrome(1))
        arith_print(palindrome_num_isPalindrome(0))
        arith_print(palindrome_num_isPalindrome(10))
        arith_print(palindrome_num_isPalindrome(1001))
    #endif

    #if /* _palindrome.swift */ false
        arith_print(palindrome_isPalindrome("A man, a plan, a canal: Panama"))
        arith_print(palindrome_isPalindrome("race a car"))
        arith_print(palindrome_isPalindrome("r"))
        arith_print(palindrome_isPalindrome(" "))
        arith_print(palindrome_isPalindrome("aa"))
        arith_print(palindrome_isPalindrome("0p"))
    #endif
}
