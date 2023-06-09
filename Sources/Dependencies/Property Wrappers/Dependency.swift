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

/// This property wrapper provides a direct connection to the `DependencyService` service.
@propertyWrapper
public struct Dependency<D> {
    
    // MARK: Properties
    
    private let keyPath: WritableKeyPath<DependencyService, D>
    
    /// This property allows direct read/write access to a defined dependency attached to a selected key path.
    public var wrappedValue: D {
        get { DependencyService[keyPath] }
        set { DependencyService[keyPath] = newValue }
    }
    
    // MARK: Initialisers
    
    /// Initialise the property wrapper by setting a key path to a defined dependency.
    /// - Parameter keyPath: A key path to a defined dependency in the `DependencyService` service.
    public init(_ keyPath: WritableKeyPath<DependencyService, D>) {
        self.keyPath = keyPath
    }

}
