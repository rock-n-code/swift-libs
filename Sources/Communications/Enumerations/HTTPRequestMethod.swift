//
//  HTTPRequestMethod.swift
//  Communications
//
//  Created by Javier Cicchelli on 10/04/2023.
//  Copyright © 2023 Röck+Cöde. All rights reserved.
//

/// Enumeration that represents the available HTTP request methods to use in this library.
public enum HTTPRequestMethod: String {
    /// Establishes a tunnel to the service identified by the target resource.
    case connect = "CONNECT"
    /// Deletes the specified resource.
    case delete = "DELETE"
    /// Asks for a response identical to a GET request, but without the response body.
    case head = "HEAD"
    /// Requests a representation of the specified resource, which should only retrieve data.
    case get = "GET"
    /// Describes the communication options for the target resource.
    case options = "OPTIONS"
    /// Applies partial modifications to a resource.
    case patch = "PATCH"
    /// Submits an entity to the specified resource, often causing a change of state or side effect on the server.
    case post = "POST"
    /// Replaces all current representations of the target resource with the request payload.
    case put = "PUT"
    /// Performs a message loop-back test along the path to the target resource.
    case trace = "TRACE"
}
