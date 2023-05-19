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
import Foundation
import XCTest

final class Bundle_LocalisationBundleTests: XCTestCase {
    
    // MARK: Properties
    
    private let bundle = Bundle.module
    
    private var languageCode: String!

    // MARK: Tests
    
    func test_localisation_withExistingLocalisationBundle() throws {
        // GIVEN
        languageCode = "en"
        
        // WHEN
        let localisationBundle = try bundle.localisation(for: languageCode)
        
        // THEN
        XCTAssertNotNil(localisationBundle)
        XCTAssertEqual(localisationBundle.bundleURL.lastPathComponent, "en.lproj")
    }
    
    func test_localisation_withNonExistingLocalisationBundle() throws {
        // GIVEN
        languageCode = "nl"
        
        // WHEN & THEN
        XCTAssertThrowsError(try bundle.localisation(for: languageCode)) { error in
            XCTAssertEqual(error as? BundleError, .bundleNotFound)
        }
    }

}
