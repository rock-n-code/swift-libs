//
//  TestServices.swift
//  DependenciesTests
//
//  Created by Javier Cicchelli on 11/04/2023.
//  Copyright © 2023 Röck+Cöde. All rights reserved.
//

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

