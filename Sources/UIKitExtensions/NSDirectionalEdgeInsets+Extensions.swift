//
// NSDirectionalEdgeInsets+Extensions.swift
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


import UIKit


extension NSDirectionalEdgeInsets {
    public init(_ inset: CGFloat) {
        self.init(top: inset, leading: inset, bottom: inset, trailing: inset)
    }

    public init(horizontal horizontalInset: CGFloat) {
        self.init(top: 0, leading: horizontalInset, bottom: 0, trailing: horizontalInset)
    }

    public init(vertical verticalInset: CGFloat) {
        self.init(top: verticalInset, leading: 0, bottom: verticalInset, trailing: 0)
    }

    public init(leading leadingInset: CGFloat) {
        self.init(top: 0, leading: leadingInset, bottom: 0, trailing: 0)
    }

    public init(trailing trailingInset: CGFloat) {
        self.init(top: 0, leading: 0, bottom: 0, trailing: trailingInset)
    }

    public init(top topInset: CGFloat) {
        self.init(top: topInset, leading: 0, bottom: 0, trailing: 0)
    }

    public init(bottom bottomInset: CGFloat) {
        self.init(top: 0, leading: 0, bottom: bottomInset, trailing: 0)
    }

    public static func inset(_ inset: CGFloat) -> Self {
        .init(inset)
    }

    public static func horizontal(_ horizontalInset: CGFloat) -> Self {
        .init(horizontal: horizontalInset)
    }

    public static func vertical(_ verticalInset: CGFloat) -> Self {
        .init(vertical: verticalInset)
    }

    public static func leading(_ leadingInset: CGFloat) -> Self {
        .init(leading: leadingInset)
    }

    public static func trailing(_ trailingInset: CGFloat) -> Self {
        .init(trailing: trailingInset)
    }

    public static func top(_ topInset: CGFloat) -> Self {
        .init(top: topInset)
    }

    public static func bottom(_ bottomInset: CGFloat) -> Self {
        .init(bottom: bottomInset)
    }
}
