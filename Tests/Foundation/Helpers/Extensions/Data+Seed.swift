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

import Foundation

extension Data {
    enum Seed {
        static let itemsWithAllKeysHavingIntValues = String.Seed.itemsWithAllKeysHavingIntValues.data(using: .utf8)
        static let itemsWithSomeKeysAndValuesAreNil = String.Seed.itemsWithSomeKeysAndValuesAreNil.data(using: .utf8)
        static let itemsWithAllKeysAndValuesAreNil = String.Seed.itemsWithAllKeysAndValuesAreNil.data(using: .utf8)
    }
}
