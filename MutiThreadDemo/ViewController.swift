//
//  ViewController.swift
//  MutiThreadDemo
//
//  Created by lben on 2021/3/16.
//

import UIKit
import XX
import Metal
import CoreImage
import CoreGraphics
import QuartzCore.CoreAnimation
import QuartzCore.CALayer
import AVFoundation
import AudioToolbox
import VideoToolbox



extension String: Swift.Error {}

/**
 AnyObject
 AnyClass

 1. NSArray
 */

class DemoClass: ReuseAble, CustomStringConvertible {
    required init() {
    }

    deinit {
    }

    func prepareForReuse() {
    }

    func say(_ index: Int) {
    }

    var description: String { "\(Self.self) => \(address(of: self).stringValue)" }
}

struct ConfigStruct {
    let name: String
    let age: Int
}

struct TestStruct {
    static var viewController: ConfigStruct? {
        didSet {
            NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "testNoti")))
        }
    }
}

class ViewController: UIViewController {
    let store: CondationStore = [Condation_0(), Condation_1()]
    static var aValue: String?
//    var observable: NSObjectProtocol?
    
    @objc
    func notififfff(noti: NSNotification) -> Void {
        print("\(TestStruct.viewController)")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        InputStream()
//        Timer().forwardingTarget(for: <#T##Selector!#>)
    
//        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.notififfff(noti:)), name: Notification.Name(rawValue: "testNoti"), object: nil)
        
//        for i in 0 ... 10000000 {
//            DispatchQueue.main.async {
//                TestStruct.viewController = ConfigStruct(name: "lben", age: i)
//            }
//            DispatchQueue.global().async {
//                TestStruct.viewController = ConfigStruct(name: "lben", age: i)
//            }
//        }
//
      

//        for i in 0 ... 3 {
//            let item = DispatchWorkItem {
//                print("--> \(i)")
//            }
//            DispatchQueue.global().asyncAndWait(execute: item)
//        }
//        print("--> 4")

        #if false
            // 0,1,2,3,4
            let group = DispatchGroup()
            for i in 0 ... 3 {
                group.enter()
                DispatchQueue.global().async {
                    print("--> \(i)")
                    group.leave()
                }
            }
            group.wait()
            print("--> 4")
        #endif
        #if false
            // 0,1,2,3,4
            let semaphore = DispatchSemaphore(value: 1)
            for i in 0 ... 3 {
                semaphore.wait()
                DispatchQueue.global().async {
                    print("--> \(i)")
                    semaphore.signal()
                }
            }
            print("--> 4")
        #endif

        #if false
            let date = Date()
            var isObjectPool = false

            let group = DispatchGroup()
            for i in 0 ... 100000 {
                group.enter()
                DispatchQueue.global().async {
                    #if isObjectPool
                        let obj = ObjectPool.shared.object(withTypeOf: DemoClass.self)
                        obj.say(i)
                        ObjectPool.shared.reclaim(obj)
                    #else
                        let obj = DemoClass()
                        obj.say(i)
                    #endif
                    group.leave()
                }
            }
            group.notify(queue: .main) {
                print("spend \(Date().timeIntervalSince(date))")
                #if isObjectPool
                    ObjectPool.shared.empty()
                #endif
            }
        #endif

        #if flase
            // Condation
            Thread {
                do {
                    try self.store.batching()
                    print("Store batching success")
                } catch let err {
                    print("Store batching error \(err)")
                }
            }
            .start()
        #endif

        #if false
            // Thread Pool
            for i in 0 ... 100 {
                ThreadPool.share.async {
                    sleep(1)
                    print("\(Thread.current) -> \(i)")
                }
            }
        #endif
    }
}
