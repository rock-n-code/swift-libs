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

final class String_LocalisationTests: XCTestCase {
    
    // MARK: Properties
    
    private var languageCode: String!
    private var stringToLocalise: String!
    private var localisedString: String!
    
    private var defaultValue: String?

    // MARK: Tests
    
    func test_localise_definedKey_inDefinedLocalisationBundle() {
        // GIVEN
        languageCode = "en"
        stringToLocalise = .Seed.Localisation.someLocalisableString
        
        // WHEN
        localisedString = stringToLocalise.localise(for: languageCode, in: .module)
        
        // THEN
        XCTAssertEqual(localisedString, .Result.Localisation.someLocalisableString)
    }
    
    func test_localise_definedKey_inDefinedLocalisationBundle_withDefaultValue() {
        // GIVEN
        languageCode = "en"
        stringToLocalise = .Seed.Localisation.otherLocalisableString
        defaultValue = "Some default value goes here..."
        
        // WHEN
        localisedString = stringToLocalise.localise(
            for: languageCode,
            in: .module,
            value: defaultValue
        )
        
        // THEN
        XCTAssertEqual(localisedString, .Result.Localisation.otherLocalisableString)
    }
    
    func test_localise_definedKey_inDefinedLocalisationBundle_withDefinedTable() {
        // GIVEN
        languageCode = "en"
        stringToLocalise = .Seed.Localisation.someLocalisableString
        
        // WHEN
        localisedString = stringToLocalise.localise(
            for: languageCode,
            in: .module,
            table: "Some table name goes in here..."
        )
        
        // THEN
        XCTAssertEqual(localisedString, stringToLocalise)
    }
    
    func test_localise_definedKey_inDefinedLocalisationBundle_withDefauledValue_andDefinedTable() {
        // GIVEN
        languageCode = "en"
        stringToLocalise = .Seed.Localisation.otherLocalisableString
        defaultValue = "Some default value goes in here..."
        
        // WHEN
        localisedString = stringToLocalise.localise(
            for: languageCode,
            in: .module,
            value: defaultValue,
            table: "Some table name goes in here..."
        )
        
        // THEN
        XCTAssertEqual(localisedString, defaultValue)
    }
    
    func test_localise_definedKey_inNotDefinedLocalisationBundle() {
        // GIVEN
        languageCode = "nl"
        stringToLocalise = .Seed.Localisation.someLocalisableString
        
        // WHEN
        localisedString = stringToLocalise.localise(for: languageCode, in: .module)
        
        // THEN
        XCTAssertEqual(localisedString, stringToLocalise)
    }
    
    func test_localise_definedKey_inNotDefinedLocalisationBundle_withDefaultValue() {
        // GIVEN
        languageCode = "nl"
        stringToLocalise = .Seed.Localisation.otherLocalisableString
        defaultValue = "Some default value goes in here..."
        
        // WHEN
        localisedString = stringToLocalise.localise(
            for: languageCode,
            in: .module,
            value: defaultValue
        )
        
        // THEN
        XCTAssertEqual(localisedString, defaultValue)
    }
    
    func test_localise_notDefinedKey_inDefinedLocalisationBundle() {
        // GIVEN
        languageCode = "en"
        stringToLocalise = .Seed.Localisation.notLocalisableString
        
        // WHEN
        localisedString = stringToLocalise.localise(for: languageCode, in: .module)
        
        // THEN
        XCTAssertEqual(localisedString, stringToLocalise)
    }
    
    func test_localise_notDefinedKey_inDefinedLocalisationBundle_withDefaultValue() {
        languageCode = "en"
        stringToLocalise = .Seed.Localisation.notLocalisableString
        defaultValue = "Some default value goes here..."
        
        // WHEN
        localisedString = stringToLocalise.localise(
            for: languageCode,
            in: .module,
            value: defaultValue
        )
        
        // THEN
        XCTAssertEqual(localisedString, defaultValue)
    }
    
    func test_localise_inDifferentBundle() {
        // GIVEN
        languageCode = "en"
        stringToLocalise = .Seed.Localisation.someLocalisableString
        
        // WHEN
        localisedString = stringToLocalise.localise(for: languageCode, in: .main)
        
        // THEN
        XCTAssertEqual(localisedString, stringToLocalise)
    }
    
    func test_localise_inDifferentBundle_withDefaultValue() {
        // GIVEN
        languageCode = "en"
        stringToLocalise = .Seed.Localisation.otherLocalisableString
        defaultValue = "Some default value goes here..."
        
        // WHEN
        localisedString = stringToLocalise.localise(
            for: languageCode,
            in: .main,
            value: defaultValue
        )
        
        // THEN
        XCTAssertEqual(localisedString, defaultValue)
    }

}
  // MARK: - String+Seed

private extension String.Seed {
    enum Localisation {
        static let someLocalisableString = "test.core.bundle.some-localisable-string"
        static let otherLocalisableString = "test.core.bundle.other-localisable-string"
        static let notLocalisableString = "test.core.bundle.non-localisable-string"
    }
}

// MARK: - String+Result

private extension String.Result {
    enum Localisation {
        static let someLocalisableString = "Some localisable string to use for testing purposes."
        static let otherLocalisableString = "Other localisable string to use for testing purposes."
    }
}
