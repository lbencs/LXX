//
//  Condation.swift
//  XX
//
//  Created by lben on 2021/4/12.
//

import Foundation

public protocol Condation: class {
    // run in child thread
    func exe(_ block: @escaping (Result<Void, Swift.Error>) -> Void)
}

public final
class CondationStore: ExpressibleByArrayLiteral {
    public typealias ArrayLiteralElement = Condation
    let condation: [Condation]
    public required init(arrayLiteral elements: ArrayLiteralElement...) {
        condation = elements
    }

    let lock = UnfairLock()

    public func batching() throws {
        precondition(!Thread.current.isMainThread)

        for ele in condation {
            var tmpError: Error?
            let group = DispatchGroup()
            group.enter()
            ele.exe { result in
                switch result {
                case .success: break
                case let .failure(error):
                    tmpError = error
                }
                group.leave()
            }
            group.wait()
            if let err = tmpError {
                throw err
            }
        }
    }
}
