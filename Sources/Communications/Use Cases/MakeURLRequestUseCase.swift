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

#if os(iOS) || os(macOS) || os(tvOS) || os(watchOS)
import Foundation

/// This use case generate a url request out of a given endpoint.
public struct MakeURLRequestUseCase {
    
    // MARK: Initialisers
    
    public init() {}
    
    // MARK: Functions
    
    /// Generate a `URLRequest` instance out of a given endpoint that conforms to the `Endpoint` protocol.
    /// - Parameter endpoint: An endpoint which is used to generate a `URLRequest` instance from.
    /// - Returns: A `URLRequest` instance filled with data provided by the given endpoint.
    public func callAsFunction(endpoint: some Endpoint) throws -> URLRequest {
        var urlComponents = URLComponents()
        
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        
        if let port = endpoint.port {
            urlComponents.port = port
        }
        
        if !endpoint.parameters.isEmpty {
            urlComponents.queryItems = endpoint.parameters
                .map(URLQueryItem.init)
                .sorted(by: { $0.name < $1.name })
        }

        guard let url = urlComponents.url else {
            throw MakeURLRequestError.urlNotCreated
        }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = endpoint.method.rawValue
        urlRequest.httpBody = endpoint.body
        urlRequest.allHTTPHeaderFields = endpoint.headers
        
        return urlRequest
    }

}
#endif
