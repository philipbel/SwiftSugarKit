//
// Sequence+Extensions.swift
// This file is part of SwiftSugarKit.
//
// Copyright © 2023 Philip B. (@philipbel). All rights reserved.
//
// https://github.com/philipbel/SwiftSugarKit
//
// Permission is hereby granted, free of charge, to any person obtaining a
// copy of this software and associated documentation files (the "Software"),
// to deal in the Software without restriction, including without limitation
// the rights to use, copy, modify, merge, publish, distribute, sublicense,
// and/or sell copies of the Software, and to permit persons to whom the
// Software is furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
// THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
// DEALINGS IN THE SOFTWARE.
//

import Foundation


@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
extension SortOrder: CustomStringConvertible {
    public var description: String {
        switch self {
        case .forward: return "Ascending"
        case .reverse: return "Descending"
        }
    }
}


@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
extension Sequence {
    private func compare<T: Comparable>(_ x: T, _ y: T, order: SortOrder) -> Bool {
        switch order {
        case .forward:
            return x < y
        case .reverse:
            return x > y
        }
    }

    public func sorted<T: Comparable>(by property: KeyPath<Element, T>, order: SortOrder = .forward) -> [Element] {
        return sorted { a, b in
            let x = a[keyPath: property]
            let y = b[keyPath: property]

            return compare(x, y, order: order)
        }
    }

    public func sorted<T: Comparable>(by property: KeyPath<Element, Optional<T>>, order: SortOrder = .forward) -> [Element] {
        return sorted { a, b in
            guard let x = a[keyPath: property],
                  let y = b[keyPath: property] else {
                return false
            }
            return compare(x, y, order: order)
        }
    }
}


extension Sequence {
    public func filter(by property: KeyPath<Element, String>, 
                       contains substring: String,
                       caseSensitive: Bool = false) -> [Element] {
        return filter{ x in
            x[keyPath: property].contains(substring, caseSensitive: caseSensitive)
        }
    }

    public func filter<T: Equatable>(by property: KeyPath<Element, T>, equalTo value: T) -> [Element] {
        return filter { x in
            return x[keyPath: property] == value
        }
    }
}


extension Sequence where Element == String {
    public func filter(stringContains substring: String, caseSensitive: Bool = false) -> [Element] {
        return filter { x in
            return x.contains(substring, caseSensitive: caseSensitive)
        }
    }
}


extension Sequence {
    public var array: Array<Element> {
        get {
            return Array(self)
        }
    }
}


extension Sequence {
    public func filterNonNil<T>() -> [T] where Element == Optional<T> {
        return self
            .filter { $0 != nil }
            .map { $0! }
    }
}
