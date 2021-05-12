//
//  GenericFunction.swift
//  LXX
//
//  Created by lben on 2021/1/19.
//

import GuestureLock
import UIKit

@frozen enum FrozenCase: Int {
    case case_0 = 0
    case case_1 = 1
    case case_2 = 2
}

func xx_max<T: Comparable>(_ lhs: T, _ rhs: T) -> T {
    return lhs > rhs ? lhs : rhs
}

// @frozen

func testEnum(test: TestEnum) {
    switch test {
    case .A: break
    case .B: break
    @unknown default: fatalError()
    }
}

func testEnum(aClass: UIUserInterfaceSizeClass) {
    switch aClass {
    case .compact: break
    case .regular: break
    case .unspecified: break
    @unknown default: fatalError()
    }
}

//func testGender(gender: OCGender) {
//    // OC的Enum => Swift的Enum
//    // @unknown => @unknown default
//    switch gender {
//    case .female: break
//    case .male: break
//    case .unknow: break
//    }
//}


func test(ca: FrozenCase) {
    let _: Int = xx_max(1, 2)
    switch ca {
    case .case_0: break
    case .case_1: break
    case .case_2: break
    }
}
