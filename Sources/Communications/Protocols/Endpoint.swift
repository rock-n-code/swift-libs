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

/// This protocol defines an endpoint to be used in a remote call.
public protocol Endpoint {
    
    // MARK: Type aliases
    
    typealias Parameters = [String : String?]
    typealias Headers = [String : String]
    
    // MARK: Properties
    
    /// The scheme subcomponent for the endpoint.
    var scheme: String { get }
    
    /// The host subcomponent for the endpoint.
    var host: String { get }
    
    /// The port subcomponent for the component.
    var port: Int? { get }
    
    /// The path subcomponent for the endpoint.
    var path: String { get }
    
    /// The query parameter subcomponents for the endpoint.
    var parameters: Parameters { get }
    
    /// The HTTP request method for the endpoint.
    var method: HTTPRequestMethod { get }
    
    /// The HTTP header fields as a dictionary for the endpoint.
    var headers: Headers { get }
    
    /// The message body as data for a request.
    var body: Data? { get }
    
}
