//
//  Filter.swift
//  DesignPatterns
//
//  Created by lben.lu on 2018/8/3.
//  Copyright © 2018年 lben. All rights reserved.
//

import Foundation

///Filter
///也可以看成组合模式
///
protocol Validateable {
    associatedtype Value
    func isValid(_ value: Value) -> Bool
}
class Validater<Value>: Validateable {
    func isValid(_ value: Value) -> Bool {
        return true
    }
}

protocol Countable {
    var count: Int {get}
}

extension String: Countable{}
extension Array: Countable{}

class CountsValidater<Value: Countable>: Validater<Value> {
    private let _count: Int
    init(count: Int) {
        _count = count
    }
    override func isValid(_ value: Value) -> Bool {
        return value.count >= 6
    }
}

class EmailValidater: Validater<String> {
    override func isValid(_ value: Value) -> Bool {
        return true
    }
}
class OrValidater<Value>: Validater<Value> {

    let left: Validater<Value>
    let right: Validater<Value>
    init(left: Validater<Value>, right: Validater<Value>) {
        self.left = left
        self.right = right
    }
    override func isValid(_ value: Value) -> Bool {
        return left.isValid(value) || right.isValid(value)
    }
}
class AndValidater<Value>: Validater<Value> {

    let left: Validater<Value>
    let right: Validater<Value>
    init(left: Validater<Value>, right: Validater<Value>) {
        self.left = left
        self.right = right
    }
    override func isValid(_ value: Value) -> Bool {
        return left.isValid(value) && right.isValid(value)
    }
}

func FilterTest() {
    let countValidater = CountsValidater<String>(count: 6)
    let emailValidater = EmailValidater()
    print(countValidater.isValid("123456"))
    print(emailValidater.isValid("lbencs@hotmail.com"))
    let and = AndValidater(left: countValidater, right: emailValidater)
    print(and.isValid("lben"))
    let or = OrValidater(left: countValidater, right: emailValidater)
    print(or.isValid("lben"))
}

