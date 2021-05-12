//
//  BinaryIndexable.swift
//  Arithmetic
//
//  Created by lben on 2021/4/30.
//

import Foundation

protocol BinaryIndexable {}

extension BinaryIndexable where Self: SignedInteger {
    var parent: Self { (self - 1) / 2 }
    var leftChild: Self { 2 * self + 1 }
    var rightChild: Self { 2 * (self + 1) }
}

extension Int: BinaryIndexable {}
