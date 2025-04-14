//
// Color+Extensions.swift
// This file is part of SwiftSugarKit.
//
// Copyright © 2024-2025 Philip B. (@philipbel). All rights reserved.
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

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Color {
    @available(iOS 15.0, macOS 12, tvOS 15.0, watchOS 8.0, *)
    public init(platformColor: PlatformColor) {
#if os(macOS)
        self.init(nsColor: platformColor)
#else
        self.init(uiColor: platformColor)
#endif
    }

    @available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
    public var platformColor: PlatformColor {
        get {
            PlatformColor(self)
        }
    }
}


//@available(iOS 15.0, macOS 12, tvOS 15.0, watchOS 8.0, *)
//public protocol ColorConvertible {
//    var color: Color { get }
//}
//
//@available(iOS 15.0, macOS 12, tvOS 15.0, watchOS 8.0, *)
//public extension ColorConvertible where Self == PlatformColor {
//    var color: Color {
//        Color(platformColor: self)
//    }
//}


//#if os(macOS)
//import AppKit
//
//extension NSColor: ColorConvertible { }
//
//#else
//
//import UIKit
//
//extension UIColor: ColorConvertible { }
//
//#endif



#endif // canImport(SwiftUI)
