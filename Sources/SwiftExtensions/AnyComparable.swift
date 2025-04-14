//
// AnyComparable.swift
// This file is part of SwiftSugarKit.
//
// Copyright © 2023-2025 Philip B. (@philipbel). All rights reserved.
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


public struct AnyComparable: Comparable {
    var wrappedValue: Any

    public static func < (lhs: AnyComparable, rhs: AnyComparable) -> Bool {
        lessThan(lhs, rhs)
    }

    public static func == (lhs: AnyComparable, rhs: AnyComparable) -> Bool {
        equals(lhs, rhs)
    }

    public init<V>(_ wrappedValue: V) where V: Comparable {
        self.wrappedValue = wrappedValue
    }

    public static func lessThanOrEqualTo(_ lhs: Any, _ rhs: Any) -> Bool {
        guard let lhs = lhs as? any Comparable,
              let rhs = rhs as? any Comparable else {
            return false
        }
        return lessThan(lhs, rhs) || equals(lhs, rhs)
    }

    public static func lessThan<A, B>(_ lhs: A, _ rhs: B) -> Bool where A: Comparable, B: Comparable {
        if let rhs = rhs as? A, lhs <= rhs {
            return true
        }
        return false
    }

    public static func equals<A, B>(_ lhs: A, _ rhs: B) -> Bool where A: Comparable, B: Comparable {
        if let rhs = rhs as? A, lhs == rhs {
            return true
        }
        return false
    }
}
