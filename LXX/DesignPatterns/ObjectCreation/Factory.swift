//
//  Factory.swift
//  DesignPatterns
//
//  Created by lben on 2018/8/2.
//  Copyright © 2018 lben. All rights reserved.
//

import UIKit

/**
 UIButton
 NSNumber
 
 工厂模式
 1. 在运行时创建对象
 2. 选择性的构建某一个子类的实例
 3. 选择性的组装一个类的不同表现形式
 
 
 */

//func factory() {
//    let button = UIButton(type: .contactAdd)
//    print(button)
//}

protocol LoggerAble {
    func log(_ message: String)
}
class Logger: LoggerAble {
    func log(_ message: String) {
        print(message)
    }
}
class InfoLogger: Logger {
    override func log(_ message: String) {
        print("Info: \(message)")
    }
}
class DebugLogger: Logger {
    override func log(_ message: String) {
        print("Debug: \(message)")
    }
}

//生成器
protocol LoggerGenerator {
    func logger() -> Logger
}
class InfoLoggerGenerator: LoggerGenerator {
    func logger() -> Logger {
        return InfoLogger()
    }
}
class DebugLoggerGenerator: LoggerGenerator {
    func logger() -> Logger {
        return DebugLogger()
    }
}

struct App {

    private let logGenerator: LoggerGenerator

    init(logGenerator: LoggerGenerator) {
        self.logGenerator = logGenerator
    }

    func log(_ message: String) {
        logGenerator.logger().log(message)
    }
}

func FactoryTest() {
    //工程模式
    //???  生成器模式
    let app = App(logGenerator: DebugLoggerGenerator())
    app.log("haha")
}


