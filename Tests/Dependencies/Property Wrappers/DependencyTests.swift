//
//  DependencyTests.swift
//  DependenciesTests
//
//  Created by Javier Cicchelli on 11/04/2023.
//  Copyright © 2023 Röck+Cöde. All rights reserved.
//

import Dependencies
import XCTest

final class DependencyTests: XCTestCase {
    
    // MARK: Properties
    
    private var subject: TestSubject!
    
    // MARK: Setup
    
    override func setUp() {
        DependencyService[\.testService] = SomeService()
    }
    
    // MARK: Tests

    func test_readTestService() {
        // GIVEN
        subject = .init()
        
        // WHEN
        let service = subject.testService
        
        // THEN
        XCTAssertNotNil(service)
        XCTAssert(service is SomeService)
    }
    
    func test_writeDependencyKey() async throws {
        // GIVEN
        subject = .init()
        
        subject.testService = SomeOtherService()
        
        // WHEN
        let service = DependencyService[\.testService]
        
        // THEN
        XCTAssertNotNil(service)
        XCTAssert(service is SomeOtherService)
    }
    
    func test_writeDependencyKeyTwice() async throws {
        // GIVEN
        subject = .init()
        
        subject.testService = SomeOtherService()
        subject.testService = SomeService()
        
        // WHEN
        let service = DependencyService[\.testService]
        
        // THEN
        XCTAssertNotNil(service)
        XCTAssert(service is SomeService)
    }

}

// MARK: - TestSubject

private struct TestSubject {
    @Dependency(\.testService) var testService
}
