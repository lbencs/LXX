//
//  Protected.swift
//
//  Copyright (c) 2014-2020 Alamofire Software Foundation (http://alamofire.org/)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation
import XX

/// A thread-safe wrapper around a value.
@propertyWrapper
@dynamicMemberLookup
final class Protected<T> {
    #if os(macOS) || os(iOS) || os(watchOS) || os(tvOS)
        private let lock = UnfairLock()
    #elseif os(Linux)
        private let lock = MutexLock()
    #endif
    private var value: T

    init(_ value: T) {
        self.value = value
    }

    /// The contained value. Unsafe for anything more than direct read or write.
    var wrappedValue: T {
        get { lock.around { value } }
        set { lock.around { value = newValue } }
    }

    var projectedValue: Protected<T> { self }

    init(wrappedValue: T) {
        value = wrappedValue
    }

    /// Synchronously read or transform the contained value.
    ///
    /// - Parameter closure: The closure to execute.
    ///
    /// - Returns:           The return value of the closure passed.
    func read<U>(_ closure: (T) -> U) -> U {
        lock.around { closure(self.value) }
    }

    /// Synchronously modify the protected value.
    ///
    /// - Parameter closure: The closure to execute.
    ///
    /// - Returns:           The modified value.
    @discardableResult
    func write<U>(_ closure: (inout T) -> U) -> U {
        lock.around { closure(&self.value) }
    }

    subscript<Property>(dynamicMember keyPath: WritableKeyPath<T, Property>) -> Property {
        get { lock.around { value[keyPath: keyPath] } }
        set { lock.around { value[keyPath: keyPath] = newValue } }
    }
}

extension Protected where T: RangeReplaceableCollection {
    /// Adds a new element to the end of this protected collection.
    ///
    /// - Parameter newElement: The `Element` to append.
    func append(_ newElement: T.Element) {
        write { (ward: inout T) in
            ward.append(newElement)
        }
    }

    /// Adds the elements of a sequence to the end of this protected collection.
    ///
    /// - Parameter newElements: The `Sequence` to append.
    func append<S: Sequence>(contentsOf newElements: S) where S.Element == T.Element {
        write { (ward: inout T) in
            ward.append(contentsOf: newElements)
        }
    }

    /// Add the elements of a collection to the end of the protected collection.
    ///
    /// - Parameter newElements: The `Collection` to append.
    func append<C: Collection>(contentsOf newElements: C) where C.Element == T.Element {
        write { (ward: inout T) in
            ward.append(contentsOf: newElements)
        }
    }
}

extension Protected where T == Data? {
    /// Adds the contents of a `Data` value to the end of the protected `Data`.
    ///
    /// - Parameter data: The `Data` to be appended.
    func append(_ data: Data) {
        write { (ward: inout T) in
            ward?.append(data)
        }
    }
}
