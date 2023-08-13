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

import SwiftLibsFoundation
import XCTest

final class Optional_NilTests: XCTestCase {

    // MARK: Properties
    
    private var optional: Int?

    private var result: Bool!
    
    // MARK: Tests
    
    func test_isNil_whenOptionalHasNotBeenSet() {
        // GIVEN
        // WHEN
        result = optional.isNil
        
        // THEN
        XCTAssertTrue(result)
    }
    
    func test_isNil_whenOptionalHasBeenSet() {
        // GIVEN
        optional = 0
        
        // WHEN
        result = optional.isNil
        
        // THEN
        XCTAssertFalse(result)
    }
    
    func test_isNotNil_whenOptionalHasNotBeenSet() {
        // GIVEN
        // WHEN
        result = optional.isNotNil
        
        // THEN
        XCTAssertFalse(result)
    }
    
    func test_isNotNil_whenOptionalHasBeenSet() {
        // GIVEN
        optional = 0
        
        // WHEN
        result = optional.isNotNil
        
        // THEN
        XCTAssertTrue(result)
    }

}
