//
// Array+Extensions.swift
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


extension Array {
    public subscript(index: Int, default defaultValue: @autoclosure () -> Element) -> Element {
        guard index >= 0, index < endIndex else {
            return defaultValue()
        }

        return self[index]
    }

    public func element(index: Int) throws -> Element {
        guard index >= 0, index < endIndex else {
            throw NotFoundError("Index \(index) is out of bounds [0, \(endIndex)]")
        }
        return self[index]
    }

    public func elementOrNil(index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }
        return self[index]
    }

    public func elementOrNil<Wrapped>(index: Int) -> Wrapped? where Element == Optional<Wrapped> {
        guard index >= 0, index < endIndex else {
            return nil
        }
        return self[index]
    }
}


extension Array {
    public func appending(_ element: Element) -> Self {
        var newArray = self
        newArray.append(element)
        return newArray
    }
}

extension Array where Element: Hashable {
    public var `set`: Set<Element> {
        get {
            Set(self)
        }
    }
}
