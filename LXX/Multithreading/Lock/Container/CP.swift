//
//  CP.swift
//  LXX
//
//  Created by lben on 2021/2/8.
//

import Foundation

class ContainerOwner<C> where C: Container {
    let container: C
    init(container: C) {
        self.container = container
    }
}

class Customer<ContainerType>: Runnable where ContainerType: Container, ContainerType.T == Int {
    deinit {
        print(" \(Self.self)")
    }

    let container: ContainerType
    init(container: ContainerType) {
        self.container = container
    }

    func run() {
        while true {
            _ = container.take()
        }
    }
}

class Producer<ContainerType>: Runnable where ContainerType: Container, ContainerType.T == Int {
    let container: ContainerType
    init(container: ContainerType) {
        self.container = container
    }

    func run() {
        while true {
            container.put(Int.random(in: 0 ... 1000))
        }
    }
}
