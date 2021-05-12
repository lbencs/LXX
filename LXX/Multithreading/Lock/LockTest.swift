//
//  Lock.swift
//  LockDemo
//
//  Created by lbencs on 05/12/2017.
//  Copyright © 2017 lbencs. All rights reserved.
//

import Foundation
import libkern
import os.lock // os_unfair_lock



class ThreadTest {
    var tickets = 1120
    let lock: NSLocking

    init(lock: NSLocking) {
        self.lock = lock
        start()
    }

    func start() {
//        lock.lock()
//        print("====> lock")
//        lock.lock()
//        print("====> lock")
//        lock.unlock()
//        print("====> unlock")
//        lock.unlock()
//        print("====> unlock")

        Thread.main.name = "车站 =>"
        DispatchQueue.main.async {
            self.syncSaleTickets()
        }

        let thread1 = Thread { [unowned self] in
            self.syncSaleTickets()
        }
        thread1.name = "售票点A => "
        thread1.start()
        let thread2 = Thread { [unowned self] in
            self.syncSaleTickets()
        }
        thread2.name = "售票点B => "
        thread2.start()

        let thread3 = Thread { [unowned self] in
            self.syncSaleTickets()
        }
        thread3.name = "售票点C => "
        thread3.start()
    }

    func syncSaleTickets() {
        while true {
            #if false
                synchronized(self, { () -> Bool in
                    if tickets > 0 {
                        print("\(Thread.current.name ?? ""): \(tickets)")
                        tickets -= 1
                    } else {
                        print("票已卖完: \(tickets)")
                    }
                    return true
                })
            #else
                lock.lock()
                defer {
                    lock.unlock()
                }
                if tickets > 0 {
                    print("\(Thread.current.name ?? ""): \(tickets)")
                    tickets -= 1
                } else {
                    print("票已卖完: \(tickets)")
                }

            #endif
            if tickets <= 0 {
                break
            }
        }
    }
}

func lock_test() {
//    NSRecursiveLock
//    NSLock
//    OSSpinLock => os_unfair_lock

    OCLock.test()
    DispatchQueue.global().async {
        print("start lock")
        sleep(4)
    }
}
