//
//  CopyTest.swift
//  LXX
//
//  Created by lben on 2021/3/10.
//

import Foundation
func memory_print(_ any: @autoclosure () -> Any) {
    debugPrint("[memory] \(any())")
}

@objc
class _CopyObject: NSObject, NSCopying {
    override required init() {
        super.init()
    }

    func copy(with zone: NSZone? = nil) -> Any {
        let obj = type(of: self).init()
        return obj
    }
}

@objc
class _MutableCopyObject: NSObject, NSCopying, NSMutableCopying {
    override required init() {
        super.init()
    }

    func mutableCopy(with zone: NSZone? = nil) -> Any {
        let obj = type(of: self).init()
        return obj
    }

    func copy(with zone: NSZone? = nil) -> Any {
        let obj = type(of: self).init()
        return obj
    }
}

/**
 理顺一下指针
 */
func addressOf<T>(_ any: T) -> UnsafePointer<T> {
//    let point = Unmanaged.passUnretained(object).toOpaque()
    withUnsafePointer(to: any) { $0 }
}

func addressOf<T>(_ any: inout T) -> UnsafePointer<T> {
    withUnsafePointer(to: any, { $0 })
}

struct TestCopyContainer {
    static var str = "A String"
}

class TestCopyObject {
    static let shared = TestCopyObject()
    var str = "A String"
}

func test_copy() {
    CopyTest().test()

    var mutiArr = NSMutableArray()
    var object = _CopyObject()
    mutiArr.add(object)

    var copyMutiArr: NSArray = mutiArr.mutableCopy() as! NSArray
    var mutableCopyMutiArr: NSMutableArray = mutiArr.mutableCopy() as! NSMutableArray

//    mutableCopyMutiArr.add(_CopyObject())
    mutableCopyMutiArr.remove(object)
    mutableCopyMutiArr.add(_CopyObject())

    memory_print(" str value has address: \(addressOf(mutiArr))")
    memory_print("copyMutiArr => \(copyMutiArr) point address is \(addressOf(&copyMutiArr))")
    memory_print("copyMutiArr => \(mutableCopyMutiArr) address is \(addressOf(copyMutiArr))")
    memory_print("mutableCopyMutiArr => \(mutableCopyMutiArr) point address is \(addressOf(&mutableCopyMutiArr))")
    memory_print("mutableCopyMutiArr => \(mutableCopyMutiArr) address is \(addressOf(mutableCopyMutiArr))")

    var constantString = "constant string"
    memory_print("constantString point add \(addressOf(&constantString))")
    memory_print("constantString string \(addressOf(constantString))")

//    memory_print("\(copyMutiArr) => \(addressOf(copyMutiArr))")
//    memory_print(mutableCopyMutiArr)
}
