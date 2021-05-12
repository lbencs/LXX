//
//  TestRun.swift
//  MutiThreadDemo
//
//  Created by lben on 2021/5/1.
//

import Foundation
struct Shared {
    static let atomicTest = AtomicTest()
    static let threadPool = ThreadPoolTest()
}
func TestRun() {
//    Shared.atomicTest.runAtomicPropertyTest()
    Shared.threadPool.test()
}
