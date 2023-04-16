//
//  DependencyKey.swift
//  Dependencies
//
//  Created by Javier Cicchelli on 11/04/2023.
//  Copyright © 2023 Röck+Cöde. All rights reserved.
//

/// This protocol defines a key to use in the dependency service.
public protocol DependencyKey {
    
    // MARK: Associated types
    
    /// The associated type representing the type of the dependency key's value.
    associatedtype Value
    
    // MARK: Properties
    
    /// The default value for the dependency key.
    static var currentValue: Value { get set }
    
}
