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

public extension String {
    
    // MARK: Properties
    
    /// Represents an empty string.
    static let empty = ""
    
    // MARK: Functions
    
    /// Checks whether a string is not empty.
    /// - Returns: A boolean value that represents whether the string is not empty.
    func isNotEmpty() -> Bool {
        isEmpty == false
    }
    
}
