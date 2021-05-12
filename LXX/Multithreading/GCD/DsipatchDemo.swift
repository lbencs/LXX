//
//  DsipatchDemo.swift
//  BaseDemo
//
//  Created by lben on 2018/11/8.
//  Copyright © 2018 lben. All rights reserved.
//

import Foundation
/**
 - 多核系统中，同步执行任务
 - 系统来进行管理
 - 调用者无需担心
 - GCD能搞定b80%的场景
 */

extension DispatchQueue {
}

/**
 Serial and Concurrent Queues
 System-Provided Queues
 - main
 - global
 */

protocol Downloader {
    var isFinished: Bool { get }

    func resume()
    func stop()
    func cancel()
}

class MovieDownloader: Downloader {
    var isFinished: Bool = false

    func resume() {
    }

    func stop() {
    }

    func cancel() {
    }
}

class MusicDownloader: Downloader {
    var isFinished: Bool = false

    func resume() {
    }

    func stop() {
    }

    func cancel() {
    }
}

class DownloadManager {
    var maxConcurrentDownloads: Int = 3
    var downloaders: [Downloader] = []
}

func gcd_print(_ any: Any) {
    print("[GCD]: \(any)")
}

func gcdtest() {
    let globalQueue = DispatchQueue.global(qos: .default)
    let interactiveQueue = DispatchQueue.global(qos: .userInteractive)

    #if false
        globalQueue.async {
            gcd_print("This is in globalQueue with thread: \(Thread.current)")
        }
        interactiveQueue.async {
            gcd_print("This is in interactiveQueue with thread: \(Thread.current)")
        }
        DispatchQueue.main.async {
            gcd_print("This is in mainQueue with thread: \(Thread.current)")
        }
    #endif

    #if false
        // work item
        let workItem = DispatchWorkItem {
            sleep(2000)
            gcd_print("word hello")
        }
        workItem.notify(queue: globalQueue) {
            gcd_print("finished")
        }
        workItem.perform()
        gcd_print("perform")
    #endif

    #if false
        // work item in queue
        gcd_print("now \(Date())")
        let workItem = DispatchWorkItem {
            gcd_print("Work item execute \(Date())")
        }
        // work item 可以执行多次, 但是notify只会响应一次
        // work item 只要提交到队列中，即便workItem.cancel()以后，notifi任然会调用
        workItem.notify(queue: .main) {
            gcd_print("Work item did finished. \(Date())")
        }
        workItem.notify(queue: .main) {
            gcd_print("Work item did finished anther notifi. \(Date())")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: workItem)
        DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: workItem)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            workItem.cancel()
//            gcd_print("Work item did cancelled \(Date())")
        }
    #endif

    #if false
        // Group
        gcd_print("start")
        let group = DispatchGroup()
        group.enter()
        globalQueue.async {
            sleep(1)
            gcd_print("globalQueue queue executed.")
            group.leave()
        }
        group.enter()
        interactiveQueue.async(group: group) {
            gcd_print("interactiveQueue queue executed.")
            group.leave()
        }
        group.notify(queue: .main) {
            gcd_print("notify for interactiveQueue \(Thread.current)")
        }
        group.wait()
        gcd_print("end")
    #endif

    #if false
        let semaphore = DispatchSemaphore(value: 2)
        for i in 0 ... 10 {
            semaphore.wait()
            globalQueue.async {
                gcd_print("global exe index = \(i)")
                semaphore.signal()
            }
        }
        gcd_print("global exe finished")
    #endif

    #if false
        let key = DispatchSpecificKey<String>()

        DispatchQueue.main.setSpecific(key: key, value: "main")

        func log() {
            // Global Queue 上也可以运行 main thread
            gcd_print("main thread: \(Thread.isMainThread)")
            let value = DispatchQueue.getSpecific(key: key)
            gcd_print("main queue: \(value != nil)")
        }

        DispatchQueue.global().sync(execute: log)
    #endif

    #if false
        let queue1 = DispatchQueue(label: "queue1")
        let queue2 = DispatchQueue(label: "queue2")

        var list: [Int] = []

        queue1.async {
            while true {
                if list.count < 10 {
                    list.append(list.count)
                } else {
                    list.removeAll()
                }
            }
        }

        queue2.async {
            while true {
                // case 0
//                for i in list {
//                    print(i)
//                }
                // case 1
//                list.forEach { debugPrint($0) }

                // case 2
                //    let value = list
                //    value.forEach { debugPrint($0) }

                // case 3
                var value = list
                // 写时复制过程为线程安全
                value.append(100)
            }
        }
    #endif
}
