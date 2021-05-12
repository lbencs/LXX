//
//  PerformDemo.swift
//  LXX
//
//  Created by lben on 2021/2/25.
//

import Foundation

class _PerformTestClass: NSObject {
    func _threadTest() {
        let thread = Thread {
            gcd_print("thread block exe")
            RunLoop.current.run(until: .init(timeInterval: 1, since: .init()))
        }
        thread.start()
        perform(#selector(test), on: thread, with: nil, waitUntilDone: true)
    }

    @objc func test() {
        gcd_print("2 => test func")
    }
}

var _performObject: _PerformTestClass?
func gcd_perform_test() {
    #if false
        _performObject = _PerformTestClass()
        _performObject?._threadTest()
    #endif
}
