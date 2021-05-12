//
//  test_async_xx_num.swift
//  Test_Fundation
//
//  Created by lben on 2021/2/9.
//

import Foundation
import XX

func test_async_xx_one() {
    Command
        .main { () -> String in
            print("On Main: This is \(Thread.current)")
            return "你好"
        }
        .run()

    Command.global { () -> String in
        return "你好"
    }
    .run()
//        .global {
//            print("On global: This is \(Thread.current)")
//        }
//        .after(interval: .seconds(1), {
//            print("On after: This is \(Thread.current)")
//        })
//        .run()

    RunLoop.current.run(until: Date(timeInterval: 3, since: .init()))
}
