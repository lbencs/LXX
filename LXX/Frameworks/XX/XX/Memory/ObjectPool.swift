//
//  ObjectPool.swift
//  XX
//
//  Created by lben on 2021/4/12.
//

import Foundation

// 内存缓存 -> 避免重复创建
public protocol ReuseAble: class {
    init()
    func prepareForReuse()
}

extension ReuseAble {
    static var reuseIdentifier: String { NSStringFromClass(Self.self) }
}

public class ObjectPool {
    public static let shared = ObjectPool()

    // TODO: #lben -  存储对象数记录
    // TODO: #lben -  内存警告时，清空缓存
    /// 每一种对象，最多存储10个对象
    public var maxCountOfOneClass: Int = 10
    /// 总共最多存储对象数
    public var maxCount: Int = 100

    public typealias Key = String
    private var _map: [Key: NSMutableSet] = [:]
    private var _lock = NSLock()

    public func object<T: ReuseAble>(withTypeOf classType: T.Type) -> T {
        _lock.lock(); defer { _lock.unlock() }
        let set = _map[T.reuseIdentifier] ?? NSMutableSet()
        if let ele = set.anyObject() as? T {
            set.remove(ele)
            ele.prepareForReuse()
            return ele
        } else {
            return T()
        }
    }

    public func reclaim(_ obj: ReuseAble) {
        _lock.lock(); defer { _lock.unlock() }
        let set = _map[type(of: obj).reuseIdentifier] ?? NSMutableSet()
        if !set.contains(obj) {
            set.add(obj)
            _map[type(of: obj).reuseIdentifier] = set
        }
    }

    public func empty() {
        _lock.lock(); defer { _lock.unlock() }
        _map = [:]
    }
}
