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

struct TestCodable: Codable, Equatable {
    let key: String
    let value: Int
}

// MARK: - Initialisers

extension TestCodable {
    init?(
        key: String? = nil,
        value: Int? = nil
    ) {
        guard let key, let value else { return nil }
        
        self.key = key
        self.value = value
    }
}
