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

public extension Bundle {
    
    // MARK: Functions
    
    /// Retrieve a localisation bundle for a given language code or identifier, if exist inside a certain bundle.
    /// - Parameter languageCode: A string that represent a language code or identifier.
    /// - Returns: A `Bundle` instance that contains localised resources based on a given language code or identifier.
    /// - Throws: A `BundleError` error in case the localisation bundle for a given language code  or identifier is not found inside a certain bundle.
    func localisation(for languageCode: String) throws -> Bundle {
        guard
            let path = path(forResource: languageCode, ofType: .ResourceType.localisationBundle),
            let bundle = Bundle(path: path)
        else {
            throw BundleError.bundleNotFound
        }
        
        return bundle
    }

}

// MARK: - String+Constants

private extension String {
    enum ResourceType {
        static let localisationBundle = "lproj"
    }
}
