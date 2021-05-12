//
//  DispatchQueue+Extension.swift
//  LivePhoto
//
//  Created by lben on 2019/11/19.
//  Copyright © 2019 lben. All rights reserved.
//

import Foundation

public extension DispatchQueue {
    static var userInteractive: DispatchQueue { return DispatchQueue.global(qos: .userInteractive) }
    static var userInitiated: DispatchQueue { return DispatchQueue.global(qos: .userInitiated) }
    static var utility: DispatchQueue { return DispatchQueue.global(qos: .utility) }
    static var background: DispatchQueue { return DispatchQueue.global(qos: .background) }

    /// SwifterSwift: Returns a Boolean value indicating whether the current
    /// dispatch queue is the specified queue.
    ///
    /// - Parameter queue: The queue to compare against.
    /// - Returns: `true` if the current queue is the specified queue, otherwise `false`.
    static func isCurrent(_ queue: DispatchQueue) -> Bool {
        let key = DispatchSpecificKey<Void>()

        queue.setSpecific(key: key, value: ())
        defer { queue.setSpecific(key: key, value: nil) }

        return DispatchQueue.getSpecific(key: key) != nil
    }

    /// SwifterSwift: A Boolean value indicating whether the current
    /// dispatch queue is the main queue.
    static var isMain: Bool {
        enum Static {
            static var key: DispatchSpecificKey<Void> = {
                let key = DispatchSpecificKey<Void>()
                DispatchQueue.main.setSpecific(key: key, value: ())
                return key
            }()
        }
        return DispatchQueue.getSpecific(key: Static.key) != nil
    }
}
