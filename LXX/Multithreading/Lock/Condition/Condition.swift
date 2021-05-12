//
//  Condition.swift
//  LXX
//
//  Created by lben on 2021/2/8.
//

import Foundation

protocol Condition: NSLocking {
    func signal()
    func broadcast()
    func wait()
}

extension NSCondition: Condition {}
