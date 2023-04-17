//
//  Service.swift
//  Persistence
//
//  Created by Javier Cicchelli on 13/04/2023.
//  Copyright © 2023 Röck+Cöde. All rights reserved.
//

import CoreData

public protocol Service {
    
    // MARK: Properties
    
    /// The main managed object context.
    var viewContext: NSManagedObjectContext { get }
    
    // MARK: Functions
    
    /// Create a private queue context.
    /// - Returns: A concurrent `NSManagedObjectContext` context instance ready to use.
    func makeTaskContext() -> NSManagedObjectContext
    
    /// Create a child context of the view context.
    /// - Returns: A generated child `NSManagedObjectContext` context instance ready to use.
    func makeChildContext() -> NSManagedObjectContext
    
    /// Save a given context.
    /// - Parameter context: A `NSManagedObjectContext` context instance to save.
    func save(context: NSManagedObjectContext) throws
    
    /// Save a given child context as well as its respective parent context.
    /// - Parameter context: A child `NSManagedObjectContext` context instance to save.
    func save(childContext context: NSManagedObjectContext) throws 
    
}
