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

/// Errors generated out of the `MakeURLRequestUseCase` use case.
public enum MakeURLRequestError: Error {
    /// An expected URL was not created.
    case urlNotCreated
}
