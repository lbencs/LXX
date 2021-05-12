//
//  LoopItem.swift
//  LoopLabel
//
//  Created by lben on 2021/1/22.
//

import Foundation

public protocol LoopItem {
    var title: String { get }
    var attributes: LoopItemAttributes { get }
}

public extension LoopItem {
    var attributes: LoopItemAttributes {
        return LoopItemAttributes()
    }
}
