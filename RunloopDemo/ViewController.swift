//
//  ViewController.swift
//  RunloopDemo
//
//  Created by lben on 2021/3/13.
//

import UIKit
import XX

class ViewController: UIViewController {
    @IBOutlet var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        #if false
            DispatchQueue.global().async {
                // Global Queue 线程无法开启Runloop
                precondition(!Thread.isMainThread)
//                Thread.current.xx_deallocBlock {
//                    print("--> deinit")
//                }

                print("--> 1")
//                self.perform(#selector(ViewController.printself), with: nil, afterDelay: 0)

                // Runloop 相关
                // wait -> ture, 调用线程 == target线程， 直接msg_send
                // wait -> false, add to runloop
                self.perform(#selector(ViewController.printself), on: .current, with: nil, waitUntilDone: true)

//            RunLoop.current.run(until: .init(timeInterval: 3, since: .init()))
//            RunLoop.current.run()
//            RunLoop.current.add(.init(), forMode: .default)
//            RunLoop.current.add(Port(), forMode: .default)
                print("--> 3")
            }
        #endif

        /**
        保活的前提
         1. Runloop有事件要处理
         2. run起来
         Runloop
         -  models
         - commonModels
         - common model items
            * source
            * timer
            *
         */
        #if true
        // Dispatch的after并不依赖于Runloop，而是自己的定时器
        DispatchQueue.global().asyncAfter(deadline: .now() + 12.5) {
            print("------> ()()")
        }
        
        DispatchQueue.global().async {
            //
            self.perform(#selector(ViewController.printself), with: nil, afterDelay: 3.0)
            RunLoop.current.run(until: Date(timeIntervalSinceNow: 4))
        }
        
//        RunLoop.current.cancelPerformSelectors(withTarget: self)
//            let thread = Thread {
//                print("--> 1")
////                RunLoop.current.run(until: .init(timeInterval: 3, since: .init()))
//                RunLoop.current.add(Port(), forMode: .default)
//                RunLoop.current.run()
//            }
//            thread.xx_deallocBlock {
//                print("--> thread deinit")
//            }
//            thread.start()
//            // 会添加到thread's Runloop 中
////            perform(#selector(ViewController.printself), on: thread, with: nil, waitUntilDone: false)
//            print("--> 3")
        #endif
    }

    @objc func printself() {
        print("--> 2")
    }
}

extension CALayer {
    fileprivate func makeSnapshot() -> UIImage? {
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(frame.size, false, scale)
        defer { UIGraphicsEndImageContext() }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        render(in: context)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        return screenshot
    }
}

extension UIView {
    fileprivate func makeSnapshot() -> UIImage? {
//        if #available(iOS 10.0, *) {
//            let renderer = UIGraphicsImageRenderer(size: frame.size)
//            return renderer.image { _ in drawHierarchy(in: bounds, afterScreenUpdates: true) }
//        } else {
        return layer.makeSnapshot()
    }

//    }
}

extension UIImage {
    convenience init?(snapshotOf view: UIView) {
        guard let image = view.makeSnapshot(), let cgImage = image.cgImage else { return nil }
        self.init(cgImage: cgImage, scale: image.scale, orientation: image.imageOrientation)
    }
}
