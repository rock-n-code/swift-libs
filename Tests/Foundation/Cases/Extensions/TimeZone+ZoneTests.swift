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

final class TimeZone_ZoneTests: XCTestCase {

    // MARK: Properties
    
    private var timeZone: TimeZone!

    // MARK: Tests
    
    func test_gmt() {
        // GIVEN
        // WHEN
        timeZone = .gmt
        
        // THEN
        XCTAssertEqual(timeZone.identifier, "GMT")
        XCTAssertEqual(timeZone.secondsFromGMT(), 0)
    }

}
