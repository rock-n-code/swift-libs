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

import Core
import XCTest

final class Bool_InitTests: XCTestCase {
    
    // MARK: Properties
    
    private var strings: [String] = []
    private var booleans: [Bool] = []

    // MARK: Tests
    
    func test_init_withPositiveStrings() {
        // GIVEN
        strings = ["YES", "Yes", "yes", "TRUE", "TrUe", "true", "One", "OnE", "one", "1"]
        
        // WHEN
        booleans = strings.map(Bool.init)
        
        // THEN
        booleans.forEach { boolean in
            XCTAssertTrue(boolean)
        }
    }
    
    func test_init_withNegativeStrings() {
        // GIVEN
        strings = ["NO", "No", "no", "FALSE", "FaLsE", "false", "ZERO", "ZeRo", "zero", "0"]
        
        // WHEN
        booleans = strings.map(Bool.init)
        
        // THEN
        booleans.forEach { boolean in
            XCTAssertFalse(boolean)
        }
    }
    
    func test_init_withOtherStrings() {
        // GIVEN
        strings = [.empty, "...", "something", "yes-", "false+", "X", "9"]
        
        // WHEN
        booleans = strings.map(Bool.init)
        
        // THEN
        booleans.forEach { boolean in
            XCTAssertFalse(boolean)
        }
    }

}
