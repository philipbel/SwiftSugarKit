//
// Publisher+Extensions.swift
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

#if canImport(Combine)
import Foundation
import Combine
import os


// From https://www.swiftbysundell.com/articles/calling-async-functions-within-a-combine-pipeline/
@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension Publisher {
    public func asyncMap<T>(
        _ transform: @escaping (Output) async -> T
    ) -> Publishers.FlatMap<Future<T, Never>, Self> {
        flatMap { value in
            Future { promise in
                Task {
                    let output = await transform(value)
                    promise(.success(output))
                }
            }
        }
    }
}

// enable throwing async functions to be called within our Combine pipelines
@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension Publisher {
    public func asyncMap<T>(
        _ transform: @escaping (Output) async throws -> T
    ) -> Publishers.FlatMap<Future<T, Error>, Self> {
        flatMap { value in
            Future { promise in
                Task {
                    do {
                        let output = try await transform(value)
                        promise(.success(output))
                    } catch {
                        promise(.failure(error))
                    }
                }
            }
        }
    }
}


// enable throwing async functions to be called within our Combine pipelines
@available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
extension Publisher {
    public func asyncMap<T>(
        _ transform: @escaping (Output) async throws -> T
    ) -> Publishers.FlatMap<Future<T, Error>, Publishers.SetFailureType<Self, Error>> {
        flatMap { value in
            Future { promise in
                Task {
                    do {
                        let output = try await transform(value)
                        promise(.success(output))
                    } catch {
                        promise(.failure(error))
                    }
                }
            }
        }
    }
}


@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension Publisher {
    public func sink(receiveValue: @escaping (Output) -> Void, receiveError: @escaping (Error) -> Void) -> AnyCancellable {
        return self.sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                receiveError(error)
                return
            case .finished:
                return
            }
        }, receiveValue: { output in
            receiveValue(output)
            return
        })
    }
}


@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension Publisher where Output == Void {
    public func sink(receiveError: @escaping (Error) -> Void) -> AnyCancellable {
        return self.sink { _ in
        } receiveError: { error in
            receiveError(error)
        }
    }
}


@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension Publisher {
    public func unwrap<T>(errorIfNil error: Failure) -> AnyPublisher<T, Failure> where Output == Optional<T> {
        return self.flatMap { value -> AnyPublisher<T, Failure> in
            if let value = value {
                return Just(value).setFailureType(to: Failure.self).eraseToAnyPublisher()
            } else {
                return Fail(outputType: T.self, failure: error).eraseToAnyPublisher()
            }
        }.eraseToAnyPublisher()
    }
}


@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension Publisher {
    public func filterNil<T>() -> AnyPublisher<T, Failure> where Output == Optional<T> {
        return self
            .filter { $0 != nil }
            .map { $0! }
            .eraseToAnyPublisher()
    }
}


@available(macOS 11.0, iOS 14.0, watchOS 7.0, tvOS 14.0, *)
extension Publisher {
    public func log(using logger: Logger,
                    prefix: String,
                    file: String = #file,
                    line: Int = #line,
                    function: String = #function) -> AnyPublisher<Output, Failure> {
        return self.map { value in
            let fileName = (file as NSString).lastPathComponent
            logger.trace("[\(file):\(function):\(line)] \(prefix) value=\(String(describing: value))")
            return value
        }.eraseToAnyPublisher()
    }
}


@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension Publisher {
    public func sideEffect(_ action: @escaping (Output) -> Void) -> AnyPublisher<Output, Failure> {
        return self
            .map {
                action($0)
                return $0
            }
            .eraseToAnyPublisher()
    }
}

//#if canImport(SwiftUI)
//import SwiftUI
//
//@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publisher {
//    public func binding() -> AnyPublisher<Output, Failure> {
//        return self
//            .map {
//                action($0)
//                return $0
//            }
//            .eraseToAnyPublisher()
//    }
//}
//
//#endif // canImport(SwiftUI)


@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
/// Inspired by https://cocoacasts.com/combine-essentials-combining-publishers-with-combine-zip-operator
extension Publisher {
    public func withPrevious() -> AnyPublisher<(Output, Output), Failure> {
        Publishers.Zip(self, self.dropFirst())
            .eraseToAnyPublisher()
    }
}


#endif
