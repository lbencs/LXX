//
//  DisplayTimer.swift
//  LXX
//
//  Created by lben on 2021/3/1.
//

import MobileCoreServices
import UIKit

class CADisplayTimer {
    private var displayLink: CADisplayLink?
    private var _repeatCallback: ((CADisplayTimer) -> Void)?
//    private var _total
    func test() {
    }

    @objc
    private func update() {
        print("## => \(#function)")
    }

    public init(timeInterval interval: Int, repeats: Bool, block: @escaping (CADisplayTimer) -> Void) {
        let displayLink = CADisplayLink(target: self, selector: #selector(update))
        displayLink.add(to: .current, forMode: .common)
        self.displayLink = displayLink
    }

    public init(countdown count: Int, block: @escaping (Int) -> Void) {
    }
}

var ___timer: CADisplayTimer?

func test_runloop_timer() {
    #if false
        ___timer = CADisplayTimer(timeInterval: 1, repeats: true, block: { timer in
            print(timer)
        })
    #endif
//    CADisplayLink()
//    CADispalyTimer
}
