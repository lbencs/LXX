//
//  RW.swift
//  LXX
//
//  Created by lben on 2021/2/8.
//

import Foundation
import XX

protocol _Source {
    func write(_ value: TimeInterval)
    func read() -> TimeInterval
}

class _DispatchSource: _Source {
    let lock = DispatchReadWriteLock()

    private var value: TimeInterval = 0

    func write(_ value: TimeInterval) {
        lock.write {
            print("\(Thread.current) write value to \(value)")
            self.value = value
        }
    }

    func read() -> TimeInterval {
        return lock.read({
            print("\(Thread.current) value is \(value)")
            return value
        })
    }
}

class MutexSource: _Source {
    let lock = RwLock()

    private var value: TimeInterval = 0

    func write(_ value: TimeInterval) {
        lock.writeLock(); defer { lock.unlock() }
        print("\(Thread.current) write value to \(value)")
        self.value = value
    }

    func read() -> TimeInterval {
        lock.readLock(); defer { lock.unlock() }
        print("\(Thread.current) value is \(value)")
        return value
    }
}

class Reader: Runnable {
    let source: _Source
    init(source: _Source) {
        self.source = source
    }

    func run() {
        _ = source.read()
    }
}

class Writer: Runnable {
    let source: _Source
    init(source: _Source) {
        self.source = source
    }

    func run() {
        let value = Date().timeIntervalSince1970
        source.write(value)
    }
}
