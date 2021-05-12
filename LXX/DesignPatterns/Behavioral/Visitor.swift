//
//  Visitor.swift
//  DesignPatterns
//
//  Created by lben.lu on 2018/8/7.
//  Copyright © 2018年 lben. All rights reserved.
//

import Foundation
/**
 访问者模式
 separating an algorithm from an object structure on which it operates
 - 将【具体操作、运算】等从Object中分离出来
 - 实现解耦
 
 通过将一组操作从Object中移出，使之独立与Object
 - 通过协议，将Object中的元素暴露到另一个对象中
 - 在另一个对象中，根据协议中的参数进行具体的操作
 */

protocol StartCarVisiter {
    func check(wheel: Wheel)
    func fasten(safetyBelt: SafetyBelt)
    func start(engine: Engine)
    func open(handBrake: HandBrake)
    func start(car: Car)
}
protocol CarElement {
    func set(visitor: StartCarVisiter)
}
class Car: CarElement {
    var element = [CarElement]()
    init() {
        element = [
            Wheel(name: "left front wheel"),
            Wheel(name: "left back wheel"),
            Wheel(name: "right front wheel"),
            Wheel(name: "right back wheel"),
            Engine(),
            HandBrake(),
            SafetyBelt()
        ]
    }
    func set(visitor: StartCarVisiter) {
        element.forEach { (element) in
            element.set(visitor: visitor)
        }
        visitor.start(car: self)
    }
}

struct Wheel: CarElement {
    let name: String
    func set(visitor: StartCarVisiter) {
        visitor.check(wheel: self)
    }
}
struct SafetyBelt: CarElement {
    func set(visitor: StartCarVisiter) {
        visitor.fasten(safetyBelt: self)
    }
}
struct HandBrake: CarElement {
    func set(visitor: StartCarVisiter) {
        visitor.open(handBrake: self)
    }
}
struct Engine: CarElement {
    func set(visitor: StartCarVisiter) {
        visitor.start(engine: self)
    }
}

class StartCar: StartCarVisiter {

    func check(wheel: Wheel) {
        print("Check wheel: \(wheel.name)")
    }
    func fasten(safetyBelt: SafetyBelt) {
        print("Fasten the safety belt")
    }
    func start(engine: Engine) {
        print("Start the car Engine")
    }
    func open(handBrake: HandBrake) {
        print("Open the hand brake")
    }
    func start(car: Car) {
        print("Start the car")
    }
}
func VisiterTest() {
    let car = Car()
    car.set(visitor: StartCar())
}
