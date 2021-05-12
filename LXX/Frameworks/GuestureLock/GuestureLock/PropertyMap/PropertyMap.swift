//
//  XXPropertyMap.swift
//  GuestureLock
//
//  Created by lben on 2021/1/21.
//

import UIKit

struct PropertyMap<Key, Value> where Key: Hashable {
    private var _map: [Key: Value] = [Key: Value]()
    init(values: [Key: Value]) {
        _map = values
    }

    func callAsFunction(_ key: Key) -> Value? {
        return _map[key]
    }
}

extension PropertyMap: ExpressibleByDictionaryLiteral {
    init(dictionaryLiteral elements: (Key, Value)...) {
        for ele in elements {
            _map[ele.0] = ele.1
        }
    }
}

typealias Font<Key: Hashable> = PropertyMap<Key, UIFont>
typealias Color<Key: Hashable> = PropertyMap<Key, UIColor>
