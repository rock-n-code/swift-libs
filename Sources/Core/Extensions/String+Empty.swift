//
//  String+Empty.swift
//  Core
//
//  Created by Javier Cicchelli on 15/04/2023.
//  Copyright © 2023 Röck+Cöde. All rights reserved.
//

public extension String {
    
    // MARK: Properties
    
    /// Represents an empty string.
    static let empty = ""
    
    // MARK: Functions
    
    /// Checks whether a string is not empty.
    /// - Returns: A boolean value that represents whether the string is not empty.
    func isNotEmpty() -> Bool {
        isEmpty == false
    }
    
}
