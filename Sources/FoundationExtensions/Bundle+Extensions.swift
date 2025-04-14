//
// Bundle+Extensions.swift
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

import Foundation


extension Bundle {
    public var icon: PlatformImage? {
        if let icons = infoDictionary?["CFBundleIcons"] as? [String: Any],
           let primaryIcon = icons["CFBundlePrimaryIcon"] as? [String: Any],
           let iconFiles = primaryIcon["CFBundleIconFiles"] as? [String],
           let lastIcon = iconFiles.last {
            return PlatformImage(named: lastIcon)
        }
        return nil
    }
}


extension Bundle {
    public func data(forResource resource: String,
              withExtension extension: String?,
              subdirectory: String? = nil) throws -> Data {
        var url: URL?

        if let subdirectory {
            url = self.url(forResource: resource, withExtension: `extension`, subdirectory: subdirectory)
        } else {
            url = self.url(forResource: resource, withExtension: `extension`)
        }
        guard let url else {
            throw NotFoundError("Cannot find resource '\(resource)' with extension in '\(`extension`)' in '\(subdirectory)'")
        }

        return try Data(contentsOf: url)
    }

    public func string(forResource resource: String,
                withExtension extension: String?,
                subdirectory: String? = nil,
                encoding: String.Encoding = .utf8) throws -> String {
        let data = try data(forResource: resource, withExtension: `extension`,
                            subdirectory: subdirectory)
        return try data.toString(encoding: encoding)
    }
}
