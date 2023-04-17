//
//  URL+Devices.swift
//  Persistence
//
//  Created by Javier Cicchelli on 17/04/2023.
//  Copyright © 2023 Röck+Cöde. All rights reserved.
//

import Foundation

public extension URL {
    
    // MARK: Properties
    
    /// URL to a virtual device in which any data written vanishes or disappear.
    static let bitBucket = URL(fileURLWithPath: "/dev/null")

}
