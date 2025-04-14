//
// observe.swift
// This file is part of SwiftSugarKit.
//
// Copyright © 2025 Philip B. (@philipbel). All rights reserved.
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

#if canImport(Observation)
import Observation


public enum ObservationTrackingResult {
    case `continue`
    case `stop`
}


@available(iOS 17.0, macOS 14.0, tvOS 17.0, *)
public func withContinuousObservationTracking(_ changes: @escaping () -> Void,
                                              onChange: @escaping () async -> ObservationTrackingResult) {
    withObservationTracking {
        _ = changes()
    } onChange: {
        Task { @MainActor in
            if await onChange() == .continue {
                // recurse
                withContinuousObservationTracking(changes, onChange: onChange)
            }
        }
    }
}


@available(iOS 17.0, macOS 14.0, tvOS 17.0, *)
public func withContinuousObservationTracking<T>(of object: T,
                                                 keyPath: PartialKeyPath<T>,
                                                 onChange: @escaping () async -> ObservationTrackingResult) {
    withContinuousObservationTracking {
        _ = object[keyPath: keyPath]
    } onChange: {
        return await onChange()
    }
}
#endif
