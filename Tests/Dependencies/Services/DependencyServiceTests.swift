//
//  DependencyServiceTests.swift
//  DependenciesTests
//
//  Created by Javier Cicchelli on 11/04/2023.
//  Copyright © 2023 Röck+Cöde. All rights reserved.
//

import Dependencies
import XCTest

final class DependencyServiceTests: XCTestCase {

    // MARK: Setup
    
    override func setUp() {
        DependencyService[\.testService] = SomeService()
    }
    
    // MARK: Tests

    func test_readDependencyKey() async throws {
        // GIVEN
        // WHEN
        let service = DependencyService[\.testService]
        
        // THEN
        XCTAssertNotNil(service)
        XCTAssert(service is SomeService)
    }
    
    func test_writeDependencyKey() async throws {
        // GIVEN
        DependencyService[\.testService] = SomeOtherService()
        
        // WHEN
        let service = DependencyService[\.testService]
        
        // THEN
        XCTAssertNotNil(service)
        XCTAssert(service is SomeOtherService)
    }
    
    func test_writeDependencyKeyTwice() async throws {
        // GIVEN
        DependencyService[\.testService] = SomeOtherService()
        DependencyService[\.testService] = SomeService()
        
        // WHEN
        let service = DependencyService[\.testService]
        
        // THEN
        XCTAssertNotNil(service)
        XCTAssert(service is SomeService)
    }

}
