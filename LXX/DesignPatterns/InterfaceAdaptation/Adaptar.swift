//
//  Adaptar.swift
//  DesignPatterns
//
//  Created by lben on 2018/8/2.
//  Copyright © 2018 lben. All rights reserved.
//

import Foundation

/**
 适配器模式 Adaptor or Wrapper
 
 注意：委托模式
 
 > 用于连接两种不同种类的对象，使其可以毫无问题的协同工作
 > 将一个类的接口，转换为客户说希望的接口
 
 可以理解为：
    - 网络请求的库为一个适配器
    - 对于一个UI库，通过Delegate将所有的UI自定义元素抽象出来供统一设置
 
 1. 已经有的类的接口与现有需求不匹配
 2. 想要一个可复用的类，该类同时可能带有不兼容接口的其他类协作
 3. 适配一个类的几个不同子类
 
 类适配器  vs   对象适配器
 1. 类适配器：继承，对象适配器：组合
 
 协议适配器
 1. 通过将Target接口转化为协议，让转化目标根据协议进行适配
 2. 当需要适配多个Target时，实现多个协议即可
 */

class Product {}

protocol ProductListAdapter {}
protocol ProductDetailAdapter {}

extension Product: ProductListAdapter {}
extension Product: ProductDetailAdapter {}

class PooductListCell {
    func render(_ product: ProductListAdapter) {
    }
}
class ProductDetailView {
    func render(_ product: ProductDetailAdapter) {
    }
}

class Color {
}

class ButtonManager {
    func button(title: String, color: Color) {
        // custom a button
    }
}


class Wrapper: NSObject {
    
    private let _rows: NSMutableArray = NSMutableArray()
    
    var rows: NSMutableArray { return mutableArrayValue(forKey: "_rows") }
    deinit { self.removeObserver(self, forKeyPath: "_rows") }
    
    override init() {
        super.init()
        self.addObserver(self, forKeyPath: "_rows", options: [.new, .old], context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        //监听所有
    }
}

