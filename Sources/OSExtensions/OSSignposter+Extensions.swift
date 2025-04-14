//
// OSSignposter+Extensions.swift
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

import os
import Foundation


@available(macOS 12.0, iOS 15.0, watchOS 8.0, tvOS 15.0, *)
public struct MeasuredSignpostInterval {
    let name: StaticString
    let message: String?
    let state: OSSignpostIntervalState
    let logger: Logger
    let start: Date = Date.now
}


@available(macOS 13.0, iOS 16.0, watchOS 9.0, tvOS 16.0, *)
extension OSSignposter {
    public func beginMeasuredInterval(_ name: StaticString,
                                      logger: Logger,
                                      _ message: String? = nil) -> MeasuredSignpostInterval {
        let signpostID = makeSignpostID()
        let state = if let message {
            beginInterval(name, id: signpostID, "\(message)")
        } else {
            beginInterval(name, id: signpostID)
        }

        var logMessage = "[BEGIN] \(name)"
        if let message {
            logMessage += ": \(message)"
        }
        logger.trace("\(logMessage)")

        return MeasuredSignpostInterval(name: name, message: message, state: state, logger: logger)
    }

    public func endMeasuredInterval(_ interval: MeasuredSignpostInterval, _ message: String? = nil) {
        let timeInterval = interval.start.distance(to: .now)
        let seconds = Int64(timeInterval)
        let duration = Duration(secondsComponent: seconds,
                                attosecondsComponent: Int64((timeInterval - seconds.double) * 1_000_000_000_000_000_000))

        let durationString = duration.formatted(.units(allowed: [.seconds, .milliseconds, .microseconds, .nanoseconds],
                                                       width: .abbreviated,
                                                       maximumUnitCount: 1))
        var s = "[END] " + interval.name.string + ": "
        if let message = message ?? interval.message {
            s += message + ", "
        }
        s += "duration: " + durationString
        interval.logger.trace("\(s)")
        endInterval(interval.name, interval.state, "\(s)")
    }

    public func endMeasuredInterval(_ interval: MeasuredSignpostInterval, error: Error) {
        endMeasuredInterval(interval, "'\(interval.name)' failed with error: '\(error)'")
    }

    public func withIntervalSignpost<T: Sendable>(
        _ name: StaticString,
        id: OSSignpostID = .exclusive,
        _ message: String,
        around task: @Sendable () async throws -> T) async rethrows -> T {
            let interval = beginInterval(name, id: id, "\(message)")
            defer {
                endInterval(name, interval)
            }
            let result = try await task()
            return result

        }
}
