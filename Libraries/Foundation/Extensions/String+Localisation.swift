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

public extension String {
    
    // MARK: Functions
    
    /// Localise a string based on a given language code or identifier in an specific bundle.
    /// - Parameters:
    ///   - languageCode: A string that represent a language code or identifier.
    ///   - bundle: A bundle in which to retrieve a localisation bundle.
    ///   - value: A default value to return if key is nil or if a localized string for key can't be found in the table.
    ///   - table: The receiver's string table to search. In case of nil or an empty string, the method attempts to use the table in `Localizable.strings`.
    /// - Returns: A localized version of the string in case it is found. Otherwise, it returns the original string or a default string, if provided.
    func localise(
        for languageCode: String,
        in bundle: Bundle,
        value: String? = nil,
        table: String? = nil
    ) -> String {
        do {
            return try bundle
                .localisation(for: languageCode)
                .localizedString(
                    forKey: self,
                    value: value,
                    table: table
                )
        } catch {
            return value ?? self
        }
    }
    
}
