//
//  Strategy.swift
//  DesignPatterns
//
//  Created by lben.lu on 2018/8/7.
//  Copyright © 2018年 lben. All rights reserved.
//

import Foundation

/**
 策略模式
 Define a family of algorithms, encapsulate each one, and make them interchangeable. Strategy lets the algorithm vary independently from clients that use it.
 在运行时选择：策略

 ？？Injection
 */

protocol Strategy {
    func operation(left: Int, right: Int) -> Int
}
struct A: Strategy {
    func operation(left: Int, right: Int) -> Int {
        return left + right
    }
}
struct B: Strategy {
    func operation(left: Int, right: Int) -> Int {
        return left * right
    }
}
struct Calculator: Strategy {
    let strategy: Strategy
    func operation(left: Int, right: Int) -> Int {
        return strategy.operation(left: left, right: right)
    }
}
func StrategyTest() {
    let a = Calculator(strategy: A())
    let b = Calculator(strategy: B())
    print(a.operation(left: 1, right: 2))
    print(b.operation(left: 1, right: 2))
}
