//
//  Client.swift
//  Communications
//
//  Created by Javier Cicchelli on 10/04/2023.
//  Copyright © 2023 Röck+Cöde. All rights reserved.
//

import Foundation

/// This protocol defines a client that will be making the remote calls.
public protocol Client {
    
    // MARK: Functions

    /// Makes a request to a remote location based on a given endpoint and expects to return a response casted as a given model type.
    /// - Parameters:
    ///   - endpoint: The endpoint for which to make a remote call.
    ///   - model: The model to cast an expected response from the remote location.
    /// - Returns: A casted model instance created out of a response retrieved from a call to a remote endpoint.
    func request<Model: Decodable>(
        endpoint: some Endpoint,
        as model: Model.Type
    ) async throws -> Model
    
    /// Makes a request to a remote location based on a given endpoint and expects to return an original, uncasted response.
    /// - Parameter endpoint: The endpoint for which to make a remote call.
    /// - Returns: An original data response from a call to a remote endpoint.
    @discardableResult func request(endpoint: some Endpoint) async throws -> Data

}