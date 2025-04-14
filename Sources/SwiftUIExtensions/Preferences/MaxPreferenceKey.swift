//
// MaxPreferenceKey.swift
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

#if canImport(SwiftUI)
import SwiftUI


/// A helper `PreferenceKey` that keeps the maximum value.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public protocol MaxPreferenceKey: PreferenceKey {
}


@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public extension MaxPreferenceKey where Value: Comparable {
    static func reduce(value: inout Value, nextValue: () -> Value) {
        let next = nextValue()
        value = max(value, next)
    }
}


@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public extension MaxPreferenceKey where Value == CGSize {
    static func reduce(value: inout Value, nextValue: () -> Value) {
        let next = nextValue()
        value = CGSize(width: max(value.width, next.width),
                       height: max(value.height, next.height))
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public protocol MaxSquarePreferenceKey: PreferenceKey {
}

extension MaxSquarePreferenceKey {
    public static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        let next = nextValue()
        let width = max(value.width, next.width)
        let height = max(value.height, next.height)
        let side = max(width, height)
        value = CGSize(width: side, height: side)
    }
}


#endif
