//
//  Injection.swift
//  DesignPatterns
//
//  Created by lben.lu on 2018/8/3.
//  Copyright © 2018年 lben. All rights reserved.
//

import Foundation
/**
 1. 注入模式
 */
protocol Functions {
    func stepOne()
    func stepTow()
}
class FunctionService: Functions {
    func stepOne() {}
    func stepTow() {}
}
class TestFunctionService: Functions {
    func stepOne() {}
    func stepTow() {}
}
class FunctionViewController {
    let service: Functions
    init(service: Functions) {
        //TODO:....
        self.service = service
    }
}
func InjectionTest() {
    _ = FunctionViewController(service: FunctionService())
    _ = FunctionViewController(service: TestFunctionService())
}

