//
//  MakeURLRequestUseCase.swift
//  APICore
//
//  Created by Javier Cicchelli on 10/04/2023.
//  Copyright © 2023 Röck+Cöde. All rights reserved.
//

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

// MARK: - Errors

enum MakeURLRequestError: Error {
    case urlNotCreated
}

