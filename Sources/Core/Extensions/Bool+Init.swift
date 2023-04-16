//
//  Bool+Init.swift
//  Core
//
//  Created by Javier Cicchelli on 15/04/2023.
//  Copyright © 2023 Röck+Cöde. All rights reserved.
//

public extension Bool {
    
    // MARK: Initialisers

    /// Initialise a boolean primitive out of a given string.
    /// - Parameter string: A string to initialise the boolean with.
    init(_ string: String) {
        let strings: [String] = [
            .Constants.oneNumber,
            .Constants.oneWord,
            .Constants.true,
            .Constants.yes
        ]
        
        self = strings.contains(string.lowercased())
    }
    
}

// MARK: - String+Constants

private extension String {
    enum Constants {
        static let yes = "yes"
        static let `true` = "true"
        static let oneWord = "one"
        static let oneNumber = "1"
    }
}
