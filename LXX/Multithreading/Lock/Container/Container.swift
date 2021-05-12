//
//  Container.swift
//  LXX
//
//  Created by lben on 2021/2/8.
//

import Foundation

protocol Container {
    associatedtype T
    func put(_ value: T)
    func take() -> T
    var total: Int { get }
}
