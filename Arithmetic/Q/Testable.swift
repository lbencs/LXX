//
//  Test.swift
//  Arithmetic
//
//  Created by lben on 2021/4/30.
//

import Foundation

protocol Testable {
    static func test()
}

func QRunning() {
    ArrayQ.test()
    MergeQ.test()
    DPQ.test()
    HashMapQ.test()
    NSumQ.test()
    TreeQ.test()
    ConstructBinaryTreeQ.test()
    BinarySearchQ.test()
    RotateQ.test()
}
