//
//  MemoryTestRun.swift
//  MemoryTestDemo
//
//  Created by lben on 2021/5/1.
//

import Foundation
struct Shared {
    static let timerLeak = TimerLeakTest()
}
func MemoryTestRun() {
//    Shared.timerLeak.run()
//    TimerLeakTest().run()
    CFFundationTest.test()
}
