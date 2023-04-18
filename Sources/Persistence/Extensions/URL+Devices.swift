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

public extension URL {
    
    // MARK: Properties
    
    /// URL to a virtual device in which any data written vanishes or disappear.
    static let bitBucket = URL(fileURLWithPath: "/dev/null")

}
