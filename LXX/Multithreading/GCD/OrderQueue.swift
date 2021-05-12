//
//  OrderQueue.swift
//  DomeUI
//
//  Created by lben on 2019/4/19.
//  Copyright © 2019 lben. All rights reserved.
//

import Foundation

typealias Action = () -> (Void)

class OrderQueue {
    
    private let _group = DispatchGroup()
    private let _queue = DispatchQueue(label: "com.lbencs.order.queue", attributes: .concurrent)
    
    func perform(_ action: @escaping Action) {
        //
        print(Thread.current)
        _group.enter()
        _queue.async { [unowned self] in
            action()
            self._group.leave()
        }
    }
    
    func notify(queue: DispatchQueue = DispatchQueue.main, _ action: @escaping Action) {
        _group.notify(queue: queue, execute: action)
    }
}

extension DispatchGroup {
    
    @discardableResult
    func perform(_ back: (DispatchGroup) -> Void) -> DispatchGroup {
        back(self)
        
        
        
        
        return self
    }
    
}
