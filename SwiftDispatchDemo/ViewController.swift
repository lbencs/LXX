//
//  ViewController.swift
//  SwiftDispatchDemo
//
//  Created by lben on 2021/4/12.
//

import UIKit

class Person {
    var name: String = "Davy"
}

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let aClass = objc_getClass("SwiftDispatchDemo.Person") as? Person.Type else {
            fatalError()
        }

        // 并没有调用初始化方法
        guard let instance = class_createInstance(aClass, 0) as? Person else {
            fatalError()
        }
        instance.name = "TingQing"
        print(instance)
        print(instance.name)
    }
}
