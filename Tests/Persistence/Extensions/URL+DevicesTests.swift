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
