//
//  AbstructFactory.swift
//  DesignPatterns
//
//  Created by lben on 2018/8/2.
//  Copyright © 2018 lben. All rights reserved.
//

import Foundation

/**
 工厂 vs 抽象工厂
 都是：创建一个对象，而不让客户端知晓返回了什么确切的对象。
 1. 调用工厂方法者通过工厂方法获得一个抽象类（接口 or 协议等）
 2. 对调用者进行细节隐藏，达到解耦的目的

 抽象工厂： 在工厂模式的基础上，将工厂抽象化
 At the beas of Factory pattern, abstruct the Factory class.
 类簇
 
 不同UI系列
 不同文案系列
 
 */

//不可变
protocol ProductA {
}
protocol ProductB {
}

//可变
class ProductAYoudao: ProductA {
}
class ProductBYoudao: ProductB {
}
class ProductAFuture: ProductA {
}
class ProductBFuture: ProductB {
}

// 不可变1
protocol AbstructFactory {
    func createProductA() -> ProductA
    func createProductB() -> ProductB
}

//多个Factory之间进行切换
class ConcreteFactoryYoudao: AbstructFactory {
    func createProductA() -> ProductA {
        return ProductAYoudao()
    }
    func createProductB() -> ProductB {
        return ProductBYoudao()
    }
}

class ConcreteFactoryFuture: AbstructFactory {
    func createProductA() -> ProductA {
        return ProductAFuture()
    }
    func createProductB() -> ProductB {
        return ProductBFuture()
    }
}
