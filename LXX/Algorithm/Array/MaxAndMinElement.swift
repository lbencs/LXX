//
//  MaxAndMinElement.swift
//  DomeUI
//
//  Created by lben on 2019/4/7.
//  Copyright © 2019 lben. All rights reserved.
//

import Foundation

struct MMResult<T: Comparable> {
    let min: T
    let max: T
}
extension MMResult: Equatable {}

func == <T: Comparable>(lhs: MMResult<T>, rhs: MMResult<T>) -> Bool {
    return lhs.max == rhs.max && lhs.min == rhs.min
}

extension Array where Element : Comparable {
    
    func bf_maxAndMin() -> MMResult<Element>? {
        
        if count == 0 {
            return nil
        } else if (count == 1) {
            return MMResult(min: self[0], max: self[0])
        } else {
            // > 1
            var min = self[0]
            var max = self[1]
            var index = 2
            while (index + 1 < count - 1) {
                var aMin : Element!
                var aMax : Element!
                if self[index] < self[index + 1] {
                    aMin = self[index]
                    aMax = self[index + 1]
                } else {
                    aMin = self[index + 1]
                    aMax = self[index]
                }
                min = Swift.min(min, aMin)
                max = Swift.max(max, aMax)
                index += 2
            }
            if index <= count - 1 {
                min = Swift.min(min, self[index])
                max = Swift.max(max, self[index])
            }
            return MMResult(min: min, max: max)
        }
    }
}
