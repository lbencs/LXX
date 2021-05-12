//
//  ChainOfResponsibility.swift
//  DesignPatterns
//
//  Created by lben.lu on 2018/8/3.
//  Copyright © 2018年 lben. All rights reserved.
//

import UIKit

extension UIResponder {
    func send(action: String) {
        self.next?.send(action: action)
    }
}


