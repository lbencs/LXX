//
//  Composite.swift
//  DesignPatterns
//
//  Created by lben.lu on 2018/8/3.
//  Copyright © 2018年 lben. All rights reserved.
//

import Foundation

/**
 组合模式
 > describes a group of objects that is treated the same way as a single instance of the same type of object
 > 整体 于 部分同时支持一项操作
 > 部分 组成 整体
 > 通过将部分 添加 到整体，再统一处理整体
 */

protocol Cookable {
    func cook()
}
class Tomato: Cookable {
    func cook() {
        print("cook tomato")
    }
}
class Spinach: Cookable {
    func cook() {
        print("cook spinach")
    }
}

class Salad: Cookable {

    var foods = [Cookable]()

    func cook() {
        foods.forEach{ $0.cook() }
        print("finish cook")
    }
    func add(food: Cookable) {
        foods.append(food)
    }
    func remove(food: Cookable) {
        foods.remove(at: 0)
    }
}

func CompositeTest() {
    let to = Tomato()
    let spi = Spinach()
    let salad = Salad()
    salad.add(food: to)
    salad.add(food: spi)
    salad.cook()

}


