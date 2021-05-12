//
//  Interpreter.swift
//  DesignPatterns
//
//  Created by lben.lu on 2018/8/7.
//  Copyright © 2018年 lben. All rights reserved.
//

import Foundation

/**
 解释器模式
 - specifies how to evaluate sentences in a language.
 - 将某一种语言解析成计算机语言

 Example
 - + - * /
 - or and non
 - sql
 */

// + - x / ()
protocol Expression {
    ///variables: 所有一一对应的映射
    func interpret(variables: [String: Expression]) -> Double
}
struct Num: Expression {
    let value: Double
    func interpret(variables: [String : Expression]) -> Double {
        return value
    }
}
struct Variable: Expression {
    let name: String

    func interpret(variables: [String : Expression]) -> Double {
        guard let value = variables[name] else {
            return 0
        }
        return value.interpret(variables: variables)
    }
}
struct Plus: Expression {
    let left: Expression
    let right: Expression
    func interpret(variables: [String : Expression]) -> Double {
        return left.interpret(variables: variables) + right.interpret(variables: variables)
    }
}
struct Minus: Expression {
    let left: Expression
    let right: Expression
    func interpret(variables: [String : Expression]) -> Double {
        return left.interpret(variables: variables) - right.interpret(variables: variables)
    }
}
struct Multi: Expression {
    let left: Expression
    let right: Expression
    func interpret(variables: [String : Expression]) -> Double {
        return left.interpret(variables: variables) * right.interpret(variables: variables)
    }
}
struct Division: Expression {
    let left: Expression
    let right: Expression
    func interpret(variables: [String : Expression]) -> Double {
        return left.interpret(variables: variables) / right.interpret(variables: variables)
    }
}
struct Stock<Element> {
    var items = [Element]()
    mutating func pop() -> Element? {
        let e = items.first
        items.removeFirst()
        return e
    }
    mutating func push(_ element: Element) {
        items.insert(element, at: 0)
    }
}

class Evaluator: Expression {
    let evaluator: Expression!
    init(sentence: String) {
        var stack = Stock<Expression>()
        sentence.split(separator: " ").forEach { (e) in
            switch (e) {
            case "+":
                if let right = stack.pop(),
                    let left = stack.pop() {
                    stack.push(Plus(left: left, right: right))
                }
            case "-":
                if let right = stack.pop(),
                    let left = stack.pop() {
                    stack.push(Minus(left: left, right: right))
                }
            case "*":
                if let right = stack.pop(),
                    let left = stack.pop() {
                    stack.push(Multi(left: left, right: right))
                }
            case "/":
                if let right = stack.pop(),
                    let left = stack.pop() {
                    stack.push(Division(left: left, right: right))
                }
            default:
                stack.push(Variable(name: String(e)))
            }
        }
        evaluator = stack.pop()
    }
    func interpret(variables: [String : Expression]) -> Double {
        return evaluator.interpret(variables: variables)
    }
}

func InterpreterTest() {
    /**
     1. 构建解析器
     2. 传入参数
     */
    let expression = "a b c d + - / e * f g h + + -"
    let sentence =  Evaluator(sentence: expression)
    var variables = [String: Expression]()
    variables["a"] = Num(value: 15)
    variables["b"] = Num(value: 7)
    variables["c"] = Num(value: 1)
    variables["d"] = Num(value: 1)
    variables["e"] = Num(value: 3)
    variables["f"] = Num(value: 2)
    variables["g"] = Num(value: 1)
    variables["h"] = Num(value: 1)
    let result = sentence.interpret(variables: variables)
    print(result)
}

