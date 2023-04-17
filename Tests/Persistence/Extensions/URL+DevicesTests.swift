//
//  URL+DevicesTests.swift
//  PersistenceTests
//
//  Created by Javier Cicchelli on 17/04/2023.
//  Copyright © 2023 Röck+Cöde. All rights reserved.
//

import Foundation
import Persistence
import XCTest

final class URL_DevicesTests: XCTestCase {
    
    // MARK: Properties
    
    private var url: URL!
    
    // MARK: - Tests
    
    func test_bitBucket() {
        // GIVEN
        // WHEN
        url = .bitBucket
        
        // THEN
        XCTAssertEqual(url.absoluteString, "file:///dev/null")
    }
    
}
