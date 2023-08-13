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

final class Collection_EmptyTests: XCTestCase {

    // MARK: Properties
    
    private var collection: (any Collection)!
    private var result: Bool!

    // MARK: Tests
    
    func test_isNotEmpty_whenAnArrayIsEmpty() {
        // GIVEN
        collection = [Int]()
        
        // WHEN
        result = collection.isNotEmpty
        
        // THEN
        XCTAssertFalse(result)
    }
    
    func test_isNotEmpty_whenAnArrayIsNotEmpty() {
        // GIVEN
        collection = [0, 1, 2, 3, 4, 5]
        
        // WHEN
        result = collection.isNotEmpty
        
        // THEN
        XCTAssertTrue(result)
    }
    
    func test_isNotEmpty_whenADictionaryIsEmpty() {
        // GIVEN
        collection = [String: Int]()
        
        // WHEN
        result = collection.isNotEmpty
        
        // THEN
        XCTAssertFalse(result)
    }
    
    func test_isNotEmpty_whenADictionaryIsNotEmpty() {
        // GIVEN
        collection = [
            "something": 0,
            "else": 1,
            "goes": 2,
            "in": 3,
            "here": 4
        ]
        
        // WHEN
        result = collection.isNotEmpty
        
        // THEN
        XCTAssertTrue(result)
    }

}
