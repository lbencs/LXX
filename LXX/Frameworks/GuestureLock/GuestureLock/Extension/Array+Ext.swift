//
//  Array+Ext.swift
//  GuestureLock
//
//  Created by lben on 2021/1/21.
//

import Foundation

extension Array {
    mutating func popFirst() -> Element? {
        let tmp = first
        self = Array(dropFirst())
        return tmp
    }
}
