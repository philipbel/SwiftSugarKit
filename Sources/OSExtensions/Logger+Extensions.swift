//
// Logger+Extensions.swift
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

@_exported import os
import Foundation
import IssueReporting


extension Logger {
    public static func makeLogger(category: String, bundle: Bundle? = nil) -> Logger {
        Logger(subsystem: makeSubsystem(for: bundle), category: category)
    }

    public static func makeLogger<T>(for type: T.Type) -> Logger where T: AnyObject {
        return Logger(subsystem: makeSubsystem(for: Bundle(for: type)), category: typeName(of: T.self))
    }

    public func reportIssue(_ message: @autoclosure () -> String? = nil,
                            fileID: StaticString = #fileID,
                            filePath: StaticString = #filePath,
                            line: UInt = #line,
                            column: UInt = #column) {
        let message = message() ?? ""
        IssueReporting.reportIssue(message, fileID: fileID, filePath: filePath, line: line, column: column)
        self.error("Issue at \(filePath):\(line): \(message)")
    }

    public func notImplemented(_ message: @autoclosure () -> String? = nil,
                               fileID: StaticString = #fileID,
                               filePath: StaticString = #filePath,
                               line: UInt = #line,
                               column: UInt = #column) {
        let message = message() ?? ""
        unimplemented(message, fileID: fileID, filePath: filePath, line: line, column: column)
    }

    public func notImplementedFatal(_ message: @autoclosure () -> String? = nil,
                                    fileID: StaticString = #fileID,
                                    filePath: StaticString = #filePath,
                                    line: UInt = #line,
                                    column: UInt = #column) -> Never {
        let message = message() ?? ""
        unimplemented(message, fileID: fileID, filePath: filePath, line: line, column: column)
        fatalError("Not implemented: \(message)")
    }

    public func fatalError(_ message: @autoclosure () -> String? = nil,
                           fileID: StaticString = #fileID,
                           filePath: StaticString = #filePath,
                           line: UInt = #line,
                           column: UInt = #column) -> Never {
        let message = message() ?? ""
        error("\(message)")
        Swift.fatalError("Fatal error: \(message)", file: fileID, line: line)
    }

    private static func makeSubsystem(for bundle: Bundle?) -> String {
        let bundle = bundle ?? Bundle.main
        return bundle.bundleIdentifier ?? "Main"
    }
}
