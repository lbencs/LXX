//
//  Bridge.swift
//  DesignPatterns
//
//  Created by lben on 2018/8/2.
//  Copyright © 2018 lben. All rights reserved.
//

import Foundation

/**
 桥接模式
 > 把抽象层次结构从其实现中分离出来，使其能够独立变更。
 > 在运行时可以选择Abstruct的具体implement
 > Abstruct 于 implement都可以独立修改
 */

//抽象层
protocol DrawerAble {
    func draw()
}
struct Rectangle: DrawerAble {
    func draw() {
        print("draw a rectangle")
    }
}
struct Square: DrawerAble {
    func draw() {
        print("draw a square")
    }
}

class Bridger {
    //
    func draw(_ drawerAble: DrawerAble) {
        drawerAble.draw()
    }
}
func BridgeTest() {

    //针对的是。Bridger vs DrawerAble
    Bridger().draw(Rectangle())
    Bridger().draw(Square())
}




