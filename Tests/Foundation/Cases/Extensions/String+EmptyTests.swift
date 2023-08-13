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

final class String_EmptyTests: XCTestCase {

    // MARK: Tests

    func test_empty() {
        // GIVEN
        let string = String.empty
        
        // WHEN
        // THEN
        XCTAssertEqual(string, "")
    }
    
    func test_isNotEmpty_withEmptyString() {
        // GIVEN
        let string = String.empty
        
        // WHEN
        let result = string.isNotEmpty
        
        // THEN
        XCTAssertFalse(result)
    }
    
    func test_isNotEmpty_withFilledString() {
        // GIVEN
        let string = String.Test.string
        
        // WHEN
        let result = string.isNotEmpty
        
        // THEN
        XCTAssertTrue(result)
    }

}

// MARK: - String+Constants

private extension String {
    enum Test {
        static let string = "Some test string..."
    }
}
