//
//  Command.swift
//  DesignPatterns
//
//  Created by lben.lu on 2018/8/3.
//  Copyright © 2018年 lben. All rights reserved.
//

import Foundation

/**
 命令模式
 data-driven
 场景：
 - 组合操作一些列连贯的命名
 - 原子命令
 */

protocol Order {
    func execute()
}
struct Info {}

struct Register: Order {
    let info: Info
    init(info: Info) {
        self.info = info
    }
    func execute() {
        print("注册成功")
    }
}
struct Login: Order {
    let info: Info
    init(info: Info) {
        self.info = info
    }
    func execute() {
        print("登陆成功")
    }
}
struct BindCard: Order {
    let info: Info
    init(info: Info) {
        self.info = info
    }
    func execute() {
        print("绑卡成功")
    }
}
struct Buy: Order {
    let info: Info
    init(info: Info) {
        self.info = info
    }
    func execute() {
        print("购买成功")
    }
}
class BuyCener: Order {
    var orders = [Order]()
    func take(order: Order)  {
        orders.append(order)
    }
    func execute() {
        orders.forEach { $0.execute() }
    }
}

func CommandTest() {
    let info = Info()
    let center = BuyCener()
    center.take(order: Register(info: info))
    center.take(order: Login(info: info))
    center.take(order: BindCard(info: info))
    center.take(order: Buy(info: info))
    center.execute()
}
