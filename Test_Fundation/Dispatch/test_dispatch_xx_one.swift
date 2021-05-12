//
//  test_dispatch_xx_one.swift
//  Test_Fundation
//
//  Created by lben on 2021/2/8.
//

import Foundation

let concurrentQueue = DispatchQueue(label: "com.queue.concurrent", qos: .default, attributes: .concurrent)



func test_dispatch_xx_group() {
    let group = DispatchGroup()
    group.enter()
    concurrentQueue.async {
        group.leave()
        print("test 1")
    }
    group.enter()
    concurrentQueue.async {
        group.leave()
        print("test 2")
    }
//    concurrentQueue.resume()
    _ = group.wait(timeout: .now() + 4)
    print("end")
}

func test_dispatch_xx_workitem() {
    test_dispatch_xx_group()
    return
    /**
     DispatchGroup
     - a group of tasks that you moni
     DispatchQueue
     - An object that manages the execution of tasks serially or concurrently on your app's main thread or on a background thread.
     - FIFO
     - serially or concurrently
     -  If too many tasks block, the system may run out of threads for your app.
     1. 不要运行大量阻塞线程的程序，会消耗系统线程资源
     2. 不要创建太多的queue，同样会消耗系统线程资源
     ？？
     For serial tasks, set the target of your serial queue to one of the global concurrent queues.
     */
    let queue = DispatchQueue(label: "com.queue.concurrent", qos: .default, attributes: .concurrent)

    let defaultItem = DispatchWorkItem {
        print("work item one")
    }

    let backgroundItem = DispatchWorkItem(qos: .utility, flags: .noQoS) {
        print("work item with qos: background")
    }

    let userInteractiveItem = DispatchWorkItem(qos: .userInteractive, flags: .noQoS) {
        print("work item with qos: userInteractive")
    }

    queue.schedule {
        print("schedule")
    }
//    DispatchWorkItem(qos: <#T##DispatchQoS#>, flags: <#T##DispatchWorkItemFlags#>, block: <#T##() -> Void#>)

//    dispatch_workloop_set_os_workgroup(<#T##workloop: OS_dispatch_workloop##OS_dispatch_workloop#>, <#T##workgroup: os_workgroup_t##os_workgroup_t#>)

    // 可以创建Dispatch Main queue
//    let queue = OS_dispatch_queue_main(label: "com.my.main")
//    queue.async {
//    }
//

    queue.async(execute: userInteractiveItem)
    queue.async(execute: backgroundItem)
//    Specifies the dispatch queue on which to perform work associated with the current object.
    queue.async(execute: defaultItem)

//    queue.resume()
//    queue.suspend()
//    queue.setTarget(queue: <#T##DispatchQueue?#>)

    let group = DispatchGroup()
//    group.notify(queue: <#T##DispatchQueue#>, work: <#T##DispatchWorkItem#>)
    group.enter()
    group.leave()
    group.wait()
//    group.wait(timeout: <#T##DispatchTime#>)
//    group.wait(wallTimeout: <#T##DispatchWallTime#>)
    RunLoop.current.run(until: Date(timeInterval: 1, since: .init()))
}
