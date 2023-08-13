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

/// This service provide write/read access to the injected dependencies.
public struct DependencyService {
    
    // MARK: Properties
    
    private static var current = DependencyService()
    
    // MARK: Subscripts

    public static subscript<DK: DependencyKey>(key: DK.Type) -> DK.Value {
        get { key.currentValue }
        set { key.currentValue = newValue }
    }
    
    public static subscript<D>(_ keyPath: WritableKeyPath<DependencyService, D>) -> D {
        get { current[keyPath: keyPath] }
        set { current[keyPath: keyPath] = newValue }
    }

}
