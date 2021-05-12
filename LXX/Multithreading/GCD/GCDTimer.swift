//
//  GCDTimer.swift
//  LXX
//
//  Created by lben on 2021/2/24.
//

import Foundation

class GCDTimer {
    let timer: DispatchSourceTimer

    public init(timeInterval interval: Int, repeats: Bool, block: @escaping (GCDTimer) -> Void) {
        timer = DispatchSource.makeTimerSource()
        timer.schedule(deadline: .now() + .seconds(interval), repeating: .seconds(interval), leeway: .nanoseconds(10))
        timer.setEventHandler { [unowned self] in
            // call back
            block(self)
        }
        timer.setCancelHandler {
            // cancel
            gcd_print("cancelled")
        }
        timer.resume()
    }

    public init(countdown count: Int, block: @escaping (Int) -> Void) {
        var count = count
        timer = DispatchSource.makeTimerSource()
        timer.schedule(deadline: .now() + 1, repeating: .seconds(1), leeway: .nanoseconds(10))
        timer.setEventHandler { [unowned timer] in
            count -= 1
            if count > 0 {
                block(count)
            } else {
                timer.cancel()
            }
        }
        timer.setCancelHandler {
            block(0)
        }
        timer.resume()
    }

    deinit {
        gcd_print("deinit ~ \(Self.self)")
    }

    func stop() {
        timer.suspend()
    }

    func resume() {
        timer.resume()
    }

    func cancel() {
        timer.cancel()
    }
}

var timer: GCDTimer?
func gcd_timer_test() {
    #if false
        gcd_print("---> \(Date())")
        timer = GCDTimer(timeInterval: 2, repeats: true) { _ in
            gcd_print("---> \(Date())")
        }
        AsyncAfter.delay(8) {
            gcd_print("---> end \(Date())")
            timer?.cancel()
            timer = nil
        }
    #endif

    #if false
        timer = GCDTimer(countdown: 10, block: { count in
            gcd_print("left \(count)")
        })
        AsyncAfter.delay(11) {
            timer = nil
        }
    #endif
}
