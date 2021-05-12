//
//  desc.swift
//  Test_Fundation
//
//  Created by lben on 2021/2/7.
//

import Foundation
func desc(_ message: String, spend seconds: TimeInterval, _ execute: () -> Void) {
    print("[start]========>>> \(message) <<<========")
    execute()

    let runloop = RunLoop.current
    runloop.run(until: Date(timeInterval: seconds, since: Date()))
    print("[end]========>>> \(message) <<<========")
}
