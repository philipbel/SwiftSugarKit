//
// String+Extensions.swift
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


extension String {
    public var trimmed: String {
        trimmingCharacters(in: .whitespacesAndNewlines)
    }

    // From https://gist.github.com/DaveWoodCom/4f751193cdb7d3767e5a
    public var isValidEmailAddress: Bool {
        get {
            guard !self.lowercased().hasPrefix("mailto:") else {
                return false
            }
            guard let emailDetector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue) else {
                return false
            }
            let matches = emailDetector.matches(in: self,
                                                options: NSRegularExpression.MatchingOptions.anchored,
                                                range: NSRange(location: 0, length: self.count))
            guard matches.count == 1 else {
                return false
            }
            return matches[0].url?.scheme == "mailto"
        }
    }
}


extension String {
    public func contains(_ substring: String, caseSensitive: Bool = false) -> Bool {
        if substring.isEmpty {
            return true
        } else if isEmpty {
            return false
        } else if caseSensitive {
            return self.contains(substring)
        } else {
            return self.lowercased().contains(substring.lowercased())
        }
    }

    public func containsLocalized(_ substring: String, caseSensitive: Bool = false) -> Bool {
        if substring.isEmpty {
            return true
        } else if isEmpty {
            return false
        } else if caseSensitive {
            return localizedStandardContains(substring)
        } else {
            return localizedCaseInsensitiveContains(substring)
        }
    }
}
