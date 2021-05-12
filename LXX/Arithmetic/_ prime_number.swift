//
//  _ prime_number.swift
//  LXX
//
//  Created by lben on 2021/3/1.
//

import Foundation

func isPrimeNumber(_ n: Int) -> Bool {
    #if /* 简单暴力  */ false
        // 只能被1或其自身整除
        for i in 2 ..< n {
            if n % i == 0 {
                return false
            }
        }
        return true
    #endif

    /* 优化1：无需排查到n  */

    var i = 2
    while i * i < n {
        defer { i += 1 }
        if n % i == 0 {
            return false
        }
    }
    return true
}

// MARK: - Leetcode 204 [0, n) 之间素数的个数

func prime_number_countPrimes(_ n: Int) -> Int {
    #if /* 算一种优化，但是不够 sqrt 优化 */ false
        /*
         2, 3, 5, 7, 11, 13, 17
         x % 2 == 0 的都不是
         */
        guard n > 2 else { return 0 }
        var primes: [Bool] = Array(0 ..< n).map({ _ in true })
        var i = 2
        while i * i < n {
            defer { i += 1 }
            if primes[i] == true {
                if isPrimeNumber(i) {
                    for j in (i * 2) ..< n {
                        if j % i == 0 {
                            primes[j] = false
                        }
                    }
                } else {
                    primes[i] = false
                }
            } else {
                continue
            }
        }

        return primes[2 ..< n].reduce(0) { res, isPrime in
            isPrime ? res + 1 : res
        }
    #endif

    /**
     核心思想：
     1. 素数的倍数，都不是素数
     2. 未被倍数覆盖掉的，都是素数
     */
    guard n > 2 else { return 0 }
    var count: Int = 0
    var notPromie: [Bool] = Array(repeating: false, count: n)

    for i in 2 ..< n {
        if notPromie[i] == false {
            count += 1
            var j = i
            while j * i < n {
                defer { j += 1 }
                notPromie[i * j] = true
            }
        }
    }

    return count
}

// MARK: - Leetcode 866 回文素数

func prime_number_primePalindrome(_ N: Int) -> Int {
    /**
      1. 查找回文
      2. 寻找素数
     */
    // n -> n + 1

    func isPrime(_ n: Int) -> Bool {
        var i = 2
        while i * i < n {
            defer { i += 1 }
            if n % i == 0 {
                return false
            }
        }
        return true
    }

    arith_print(isPrime(303))

    /**
     1 <= N <= 10^8
     => 100000000
     回文根
     n =>
     1    => 11
     12  => 121 or 1221
     13  => 131 or 1331
     14
     1x
     */
    
//    let length = "\(n)"
//    if length.count % 2 == 0, n != 11 {
//        // 知识点： 偶数长度的回文数”中只有11是素数，其他的都可以被11整除 1221
//        return false
//    }

    for i in (N + 1) ... 100000000 where i % 2 != 0 && i % 3 != 0 {
        if i % 2 == 0 {
        }
    }

    func isPalindrome(_ num: Int) -> Bool {
        return true
    }

    return 1
}
