//
// CGSize+Extensions.swift
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

import CoreGraphics


public extension CGSize {
    public static let infinity = CGSize(width: CGFloat.infinity, height: CGFloat.infinity)

    public static func - (lhs: CGSize, value: CGFloat) -> CGSize {
        return CGSize(width: lhs.width - value, height: lhs.height - value)
    }

    public init(square side: CGFloat) {
        self.init(width: side, height: side)
    }

}


extension CGSize: CustomStringConvertible {
    public var description: String {
        "CGSize(\(width), \(height))"
    }
}


extension CGPoint: CustomStringConvertible {
    public var description: String {
        "CGPoint(\(x), \(y))"
    }
}


extension CGRect: CustomStringConvertible {
    public var description: String {
        "CGRect(origin=\(origin), size=\(size))"
    }
}
