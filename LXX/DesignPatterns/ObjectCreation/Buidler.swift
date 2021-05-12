//
//  Buidler.swift
//  DesignPatterns
//
//  Created by lben on 2018/8/2.
//  Copyright © 2018 lben. All rights reserved.
//

import Foundation

/**
 生成器: 将一个复杂对象的构建与它的表现分离
 考虑一种情况：
    - 某一个属性的变化，会引起其他属性的变化
 
 Client <- Director <-> Builder
 
 通过在Director中注入：Builder，来构建具体的实体
 
 1. 需要创建涉及各个部件的复杂对象（构建组合对象）
 2. 构成过程需要以不同的方式构建对象
 
        抽象工厂  vs   生成器
 1. 抽象工厂以单一方式、单一步骤创建对象
 2. 生成器以多种方式，多个步骤创建对象
 3. 抽象工厂专注于一类产品的生成
 4. 生成器专注于一种特定产品的生成
 5. 抽象工厂返回的产品是抽象的（积类or协议or抽象类等）
 6. 生成器产生的具体的产品

 */

class 包子: CustomStringConvertible {
    var 成品: String = ""
    var description: String {
        return 成品
    }
}
protocol 包子Builder {
    var 包包: 包子!{get}
    func 开始()
    func 擀包子皮()
    func 做馅()
    func 弄熟()
}
class 牛肉包Buidler: 包子Builder {
    var 包包: 包子!
    func 开始() {
        包包 = 包子()
    }
    func 擀包子皮() {
        包包.成品.append("又香又白的大包子皮")
    }
    func 做馅() {
        包包.成品.append(" + 新鲜牛肉做的大包子馅")
    }
    func 弄熟() {
        包包.成品.append("+ 香喷喷，冒热气")
    }
}
class 汤包Buidler: 包子Builder {
    var 包包: 包子!
    func 开始() {
        包包 = 包子()
    }
    func 擀包子皮() {
        包包.成品.append("又香又白的大包子皮")
    }
    func 做馅() {
        包包.成品.append(" + 新鲜虾仁做的大包子馅 + 加入高汤")
    }
    func 弄熟() {
        包包.成品.append("+ 香喷喷，冒热气")
    }
}
class Director {
    let builder: 包子Builder
    init(builder: 包子Builder) {
        self.builder = builder
    }
    func 包子() -> 包子 {
        builder.开始()
        builder.擀包子皮()
        builder.做馅()
        builder.弄熟()
        return builder.包包
    }
}
func BuilderTest() {
    var director = Director(builder: 牛肉包Buidler())
    print(director.包子())
    director = Director(builder: 汤包Buidler())
    print(director.包子())
}


