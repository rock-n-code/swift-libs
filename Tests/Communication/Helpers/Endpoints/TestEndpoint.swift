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
import SwiftLibsCommunication

struct TestEndpoint: Endpoint {

    // MARK: Properties
    
    let scheme: String = "http"
    let host: String = "www.something.com"
    let port: Int?
    let path: String = "/path/to/endpoint"
    let parameters: Parameters
    let method: HTTPRequestMethod = .get
    let headers: Headers
    let body: Data?

    // MARK: Initialisers
    
    init(
        port: Int? = nil,
        parameters: Parameters = [:],
        headers: Headers = [:],
        body: Data? = nil
    ) {
        self.port = port
        self.parameters = parameters
        self.headers = headers
        self.body = body
    }

}
