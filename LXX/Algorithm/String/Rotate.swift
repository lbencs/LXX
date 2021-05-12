//
//  Shift.swift
//  DomeUI
//
//  Created by lben on 2019/4/7.
//  Copyright © 2019 lben. All rights reserved.
//

import Foundation

extension String {
    func bf_isRotateToContain(_ aStr: String) -> Bool {
        return (self + self).contains(aStr)
    }
}
