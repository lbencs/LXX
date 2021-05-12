//
//  Address.swift
//  XX
//
//  Created by lben on 2021/4/12.
//

import Foundation
import UIKit

// public func addressOf<T>(_ any: T) -> UnsafePointer<T> {
//    withUnsafePointer(to: any) { $0 }
// }
//
// public func address<T>(of any: inout T) -> UnsafePointer<T> {
//    withUnsafePointer(to: any, { $0 })
// }

public func pointer<T>(of any: T) -> UnsafeMutableRawPointer {
    UnsafeMutableRawPointer(mutating: withUnsafePointer(to: any) { $0 })
}

public func address<Instance: AnyObject>(of instance: Instance) -> UnsafeMutableRawPointer {
    Unmanaged.passUnretained(instance).toOpaque()
}

// Reference Types
public func _address<Instance: AnyObject>(of any: Instance) -> UnsafeMutableRawPointer {
    Unmanaged.passUnretained(any).toOpaque()
}

public func printAddr<T>(address p: UnsafeMutableRawPointer, as type: T.Type) {
    let value = p.load(as: type)
    print(value)
}

func test() {
    var t_value: Int = 10
    _ = withUnsafeMutablePointer(to: &t_value) { (pointer) -> Int in
        pointer.pointee += 1
        return pointer.pointee
    }
    print(t_value)
}

/**
 /// 打印地址
 frame variable -L obj1
 */

extension UnsafeMutableRawPointer {
//    public var _cVarArgEncoding: [Int] {
//        return self.
//    }

    public var stringValue: String {
//        return String(format: "%p", self)
        "\(self)"
    }
}

public extension UnsafePointer {
    var stringValue: String {
        let length = 2 + 2 * MemoryLayout<UnsafeRawPointer>.size
        return String(format: "%\(length)p", self)
    }
}
