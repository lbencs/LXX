//
//  Decorator.swift
//  DesignPatterns
//
//  Created by lben.lu on 2018/8/3.
//  Copyright © 2018年 lben. All rights reserved.
//

import Foundation

/**
 装饰器

 思考：给一个类或对象增加行为
 1. 继承
 2. 组合
 3. 扩展

 */

protocol Autobot {
    func run()
    func speak()
}
protocol Flyable {
    func fly()
}
protocol Walkable {
    func walk()
}
class OptimusPrime : Autobot {
    func speak() {
        print("speak")
    }
    func run() {
        print("can run on the way.")
    }
}

class TransfomerDecorator: Autobot, Walkable, Flyable {

    let autobot: Autobot
    init(autobot: Autobot) {
        self.autobot = autobot
    }
    func run() {
        autobot.run()
    }
    func speak() {
        autobot.speak()
    }
    func fly() {
        print("faly")
    }
    func walk() {
        print("walk")
    }
}

func DecoratorTest() {
    let optimus = OptimusPrime()
    optimus.run()
    optimus.speak()
    let transfomer = TransfomerDecorator(autobot: optimus)
    transfomer.fly()
    transfomer.walk()
}
