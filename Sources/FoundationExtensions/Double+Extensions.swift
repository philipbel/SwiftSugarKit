//
// Double+Extensions.swift
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


extension Double {
    public var uInt: UInt {
        return UInt(self)
    }

    public var number: NSNumber {
        get {
            return NSNumber(value: self)
        }
    }
}


// MARK: Measurement Conversions
extension Double {
    public var kilograms: Measurement<UnitMass> {
        .init(value: self, unit: .kilograms)
    }

    public var pounds: Measurement<UnitMass> {
        .init(value: self, unit: .pounds)
    }
}
