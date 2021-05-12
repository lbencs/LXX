//
//  test_lock_xx_one.swift
//  Test_Fundation
//
//  Created by lben on 2021/2/7.
//

import Foundation
import XX

private let condationLock = NSConditionLock(condition: 1)
func test_lock_condation_one() {
    DispatchQueue.global().async {
        condationLock.lock(whenCondition: 3)
        print("===> exe task 1")
        condationLock.unlock(withCondition: 0)
    }

    DispatchQueue.global().async {
        condationLock.lock(whenCondition: 2)
        print("===> exe task 2")
        condationLock.unlock(withCondition: 3)
    }

    DispatchQueue.global().async {
        condationLock.lock(whenCondition: 1)
        print("===> exe task 3")
        condationLock.unlock(withCondition: 2)
    }
}

func test_lock_producer_consumer_model_condation() {
    let container = ContainerWithCondition<Int>(condation: NSCondition())
//    let container = ContainerWithConditionLock<Int>()
    for _ in 0 ... 100 {
        let customer = Thread(runner: Customer(container: container))
        customer.start()
    }
    let producter = Thread(runner: Producer(container: container))
    producter.start()
    let producter2 = Thread(runner: Producer(container: container))
    producter2.start()
    let producter3 = Thread(runner: Producer(container: container))
    producter3.start()

    let runloop = RunLoop.current
    runloop.run(until: Date(timeInterval: 10, since: .init()))
    print("===end total => \(container.total)")
}

func test_lock_read_write_model_rwlock() {
//    let source = MutexSource()
    let source = DispatchSource()
    for index in 0 ... 10 {
        if index % 2 == 0 {
            let writer = Thread(runner: Writer(source: source))
            writer.start()
        } else {
            let reader = Thread(runner: Reader(source: source))
            reader.start()
        }
    }

    let runloop = RunLoop.current
    runloop.run(until: Date(timeInterval: 10, since: .init()))
}

private var products: [Int] = []
private let producterCondation = NSCondition()
func test_lock_condation_two(condation: NSCondition) {
    var threads: [String] = []

    for i in 0 ..< 1000 {
        let customer = Thread {
            condation.lock()
            print("consumer \(i) locked")
            while products.isEmpty {
                condation.wait()
            }
            products.removeFirst()
            if products.isEmpty {
                condation.broadcast()
            }
            print("consumer \(i) consume a product left: \(products.count)")
            condation.unlock()
        }
        customer.start()
        threads.append(customer.name ?? "")
    }

    print("total threads \(threads.count)")

    let producter = Thread {
        var productCount = 0

        while true {
            condation.lock()

            while !products.isEmpty {
                condation.wait()
            }
            products.append(Int.random(in: 0 ... 10))
            productCount += 1
            print("producer produce a product left: \(products.count), total: \(productCount)")
            /**
             You use this method to wake up one thread that is waiting on the condition.
             You may call this method multiple times to wake up multiple threads.
             If no threads are waiting on the condition, this method does nothing.
             To avoid race conditions, you should invoke this method only while the receiver is locked.
             */
            condation.broadcast()
            condation.unlock()
            print("finished - \(productCount)")
        }
    }
    producter.start()
}
