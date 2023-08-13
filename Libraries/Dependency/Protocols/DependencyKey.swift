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

/// This protocol defines a key to use in the dependency service.
public protocol DependencyKey {
    
    // MARK: Associated types
    
    /// The associated type representing the type of the dependency key's value.
    associatedtype Value
    
    // MARK: Properties
    
    /// The default value for the dependency key.
    static var currentValue: Value { get set }
    
}
