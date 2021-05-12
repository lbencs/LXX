//
//  Singleton.swift
//  DesignPatterns
//
//  Created by lben on 2018/8/2.
//  Copyright © 2018 lben. All rights reserved.
//

import Foundation
//https://www.tutorialspoint.com/design_pattern/factory_pattern.htm
/**
 单列
 
 1. 保证一个类只有一个实例
 2. 只能通过继承来进行扩张
 */

class Singleton {
    static let share = Singleton()
}
//class ChildSingleton: Singleton {
//    override static let share = ChildSingleton()
//}
