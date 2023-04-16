//
//  String+EmptyTests.swift
//  Core
//
//  Created by Javier Cicchelli on 15/04/2023.
//  Copyright © 2022 Röck+Cöde. All rights reserved.
//

import Core
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
        let result = string.isNotEmpty()
        
        // THEN
        XCTAssertFalse(result)
    }
    
    func test_isNotEmpty_withFilledString() {
        // GIVEN
        let string = String.Test.string
        
        // WHEN
        let result = string.isNotEmpty()
        
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
