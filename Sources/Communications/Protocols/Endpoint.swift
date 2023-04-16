//
//  Endpoint.swift
//  Communications
//
//  Created by Javier Cicchelli on 10/04/2023.
//  Copyright © 2023 Röck+Cöde. All rights reserved.
//

import Foundation

/// This protocol defines an endpoint to be used in a remote call.
public protocol Endpoint {
    
    // MARK: Properties

    /// The scheme subcomponent for the endpoint.
    var scheme: String { get }
    
    /// The host subcomponent for the endpoint.
    var host: String { get }

    /// The port subcomponent for the component.
    var port: Int? { get }

    /// The path subcomponent for the endpoint.
    var path: String { get }
    
    /// The HTTP request method for the endpoint.
    var method: HTTPRequestMethod { get }
    
    /// The HTTP header fields as a dictionary for the endpoint.
    var headers: [String: String] { get }
    
    /// The message body as data for a request.
    var body: Data? { get }

}
