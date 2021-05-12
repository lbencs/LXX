//
//  Thread+Ext.swift
//  LXX
//
//  Created by lben on 2021/2/7.
//

import Foundation

public protocol Runnable {
    func run()
}

extension Thread {
    public convenience init(runner: Runnable) {
        self.init(block: {
            runner.run()
        })
    }
}
