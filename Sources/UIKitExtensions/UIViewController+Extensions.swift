//
// UIViewController+Extensions.swift
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


public extension UIViewController {
    /// SwiftSugarKit: Embed a child view controller into this view controller, and set its view's
    /// `translatesAutoresizingMaskIntoConstraints` to `false`.
    ///
    /// - Parameters:
    ///   - childViewController: the child view controller to embed into this view controller.
    ///   - containerView: the container view to which to add `childViewController`'s view, or `nil` to skip adding it
    func embedViewController(_ childViewController: UIViewController, into containerView: UIView? = nil) {
        childViewController.view.translatesAutoresizingMaskIntoConstraints = false

        addChild(childViewController)
        containerView?.addSubview(childViewController.view)
        childViewController.didMove(toParent: self)
    }
}
