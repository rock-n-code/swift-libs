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
