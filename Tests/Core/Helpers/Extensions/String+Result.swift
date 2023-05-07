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

extension String {
    enum Result {
        static let allItemsNotFilteredOut = "{\"items\":[{\"key\":\"One\",\"value\":1},{\"key\":\"Two\",\"value\":2},{\"key\":\"Three\",\"value\":3},{\"key\":\"Four\",\"value\":4}]}"
        static let someItemsFilteredOut = "{\"items\":[{\"key\":\"One\",\"value\":1},{\"key\":\"Three\",\"value\":3}]}"
        static let allItemsFilteredOut = "{\"items\":[]}"
    }
}
