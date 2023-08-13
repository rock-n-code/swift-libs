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

public extension Optional {
    
    // MARK: Properties
    
    /// A Boolean value indicating whether an optional has not been set.
    var isNil: Bool { self == nil }
    
    /// A Boolean value indicating whether an optional has been set.
    var isNotNil: Bool { !isNil }
    
}
