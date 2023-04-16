//
//  DependencyService.swift
//  Dependencies
//
//  Created by Javier Cicchelli on 11/04/2023.
//  Copyright © 2023 Röck+Cöde. All rights reserved.
//

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
