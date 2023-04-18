//===----------------------------------------------------------------------===//
//
// This source file is part of the SwiftLibs open source project
//
// Copyright (c) 2023 Röck+Cöde VoF. and the SwiftLibs project authors
// Licensed under the EUPL 1.2 or later.
//
// See LICENSE.txt for license information
// See CONTRIBUTORS.txt for the list of SwiftLibs project authors
//
//===----------------------------------------------------------------------===//

import Dependencies

// MARK: - Protocols

protocol TestService {}

// MARK: - Services

struct SomeService: TestService, Equatable {}
struct SomeOtherService: TestService, Equatable {}

// MARK: - DependencyKey

struct TestServiceKey: DependencyKey {
    static var currentValue: TestService = SomeService()
}

// MARK: - DependencyService+Keys

extension DependencyService {
    var testService: TestService {
        get { Self[TestServiceKey.self] }
        set { Self[TestServiceKey.self] = newValue }
    }
}

