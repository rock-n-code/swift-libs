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
    
    // MARK: Constants
    
    /// A string that represents an empty string.
    static let empty = ""
    
    // MARK: Properties

    /// A Boolean value indicating whether a string is not empty.
    var isNotEmpty: Bool { !isEmpty }
    
}
