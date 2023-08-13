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

import Foundation
import SwiftLibsFoundation
import XCTest

final class LossyCodableList_DecodableTests: XCTestCase {
    
    // MARK: Properties
    
    private let decoder = JSONDecoder()
    
    private var dataToDecode: Data!
    private var decodedList: TestCodableList!

    // MARK: Tests
    
    func test_decode_whenAllDataIsComplete() throws {
        // GIVEN
        dataToDecode = .Seed.itemsWithAllKeysHavingIntValues
        
        // WHEN
        decodedList = try decoder.decode(TestCodableList.self, from: dataToDecode)

        // THEN
        XCTAssertNotNil(decodedList)
        XCTAssertTrue(decodedList.items.isNotEmpty)
        XCTAssertEqual(decodedList.items, [
            .init(key: "One", value: 1),
            .init(key: "Two", value: 2),
            .init(key: "Three", value: 3),
            .init(key: "Four", value: 4)
        ])
    }
    
    func test_decode_whenSomeDataHasNil() throws {
        // GIVEN
        dataToDecode = .Seed.itemsWithSomeKeysAndValuesAreNil
        
        // WHEN
        decodedList = try decoder.decode(TestCodableList.self, from: dataToDecode)
        
        // THEN
        XCTAssertNotNil(decodedList)
        XCTAssertTrue(decodedList.items.isNotEmpty)
        XCTAssertEqual(decodedList.items, [
            .init(key: "One", value: 1),
            .init(key: "Three", value: 3)
        ])
    }
    
    func test_decode_whenAllDataHasNil() throws {
        // GIVEN
        dataToDecode = .Seed.itemsWithAllKeysAndValuesAreNil
        
        // WHEN
        decodedList = try decoder.decode(TestCodableList.self, from: dataToDecode)
        
        // THEN
        XCTAssertNotNil(decodedList)
        XCTAssertTrue(decodedList.items.isEmpty)
        XCTAssertEqual(decodedList.items, [])
    }

}
