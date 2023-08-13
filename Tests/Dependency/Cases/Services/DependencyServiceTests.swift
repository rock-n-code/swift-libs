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

import SwiftLibsDependency
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
