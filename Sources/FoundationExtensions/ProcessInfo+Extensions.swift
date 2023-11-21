//
// ProcessInfo+Extensions.swift
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


extension ProcessInfo {
    public var isSwiftUIPreview: Bool {
        get {
            environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
        }
    }

    public var isRunningUnderXcodeTest: Bool {
        get {
            environment["XCTestConfigurationFilePath"] != nil
        }
    }

    public func isEnabled(environment: String) -> Bool {
        guard let value = ProcessInfo.processInfo.environment[environment] else { return false }

        if let integerValue = Int(value) {
            return (integerValue != 0)
        } else if value.lowercased() == "true" || value.lowercased() == "yes" {
            return true
        }
        return false
    }
}
