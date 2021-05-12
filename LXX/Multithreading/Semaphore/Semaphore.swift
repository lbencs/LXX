//
//  Semaphore.swift
//  LXX
//
//  Created by lben on 2021/1/29.
//

import Dispatch
import Foundation
import UIKit

class Semaphore {
    func test() {
        let semaphore = DispatchSemaphore(value: 1)
        semaphore.resume()
        semaphore.suspend()
        semaphore.signal()
        semaphore.wait()
        semaphore.wait(timeout: .now() + 1)
    }

//    func test() {
//        let queue = DispatchQueue(label: "test.queue", qos: .default, attributes: .concurrent)
//        print(1)
//        queue.sync {
//            print(2)
//        }
//        print(3)
//    }
}
