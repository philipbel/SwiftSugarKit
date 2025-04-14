//
// GeometryMeasurementModifier.swift
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
import os


// Inspired by https://swiftwithmajid.com/2020/01/15/the-magic-of-view-preferences-in-swiftui/

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct GeometryMeasurementModifier<P>: ViewModifier where P: PreferenceKey, P.Value: Equatable {
    private let preferenceKeyType: P.Type
    private let keyPath: KeyPath<GeometryProxy, P.Value>

    public init(preferenceKeyType: P.Type, keyPath: KeyPath<GeometryProxy, P.Value>) {
        self.preferenceKeyType = preferenceKeyType
        self.keyPath = keyPath
    }

    private var sizeView: some View {
        GeometryReader { geometry in
            Color.clear
                .preference(key: P.self, value: geometry[keyPath: keyPath])
        }
    }

    public func body(content: Content) -> some View {
        content
            .background(sizeView)
    }
}


@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public extension View {
    /// Save this `View`'s size into a preference key
    /// - Parameters:
    ///   - preferenceKey: A `PreferenceKey` to use for measuring this `View`'s size.
    ///   - value: A `Binding` to a `CGSize` in which to store this `View`'s size.
    /// - Returns: This `View` modified with `GeometryMeasurementModifier`
    ///
    /// Example:
    /// ```
    /// @State private var mySize = CGSize.zero
    ///
    /// Grid(horizontalSpacing: 12, verticalSpacing: 12) {
    ///     GridRow {
    ///         Button("Button 1") { }
    ///             .saveSizePreference(MyMaxPreferenceKey.self, into: $mySize)
    ///             .frame(size: mySize)
    ///         Button("Foo") { }
    ///             .saveSizePreference(MyMaxPreferenceKey.self, into: $mySize)
    ///             .frame(size: mySize)
    ///     }
    /// }
    /// .onPreferenceChange(MyMaxPreferenceKey.self) { [$mySize] size in
    ///     $mySize.wrappedValue = size
    /// }
    /// ```
    func saveSizePreference<P>(_ preferenceKey: P.Type) -> some View where P: PreferenceKey, P.Value == CGSize {
        self
            .modifier(GeometryMeasurementModifier(preferenceKeyType: preferenceKey, keyPath: \GeometryProxy.size))
    }
}

#endif
