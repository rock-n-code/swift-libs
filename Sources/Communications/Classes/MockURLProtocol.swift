//
//  MockURLProtocol.swift
//  APICore
//
//  Created by Javier Cicchelli on 10/04/2023.
//  Copyright © 2023 Röck+Cöde. All rights reserved.
//

import Foundation

/// This class overrides the `URLProtocol` protocol used by the `URLSession` to handle the loading of protocol-specific URL data so it is possible to mock URL response for testing purposes.
public class MockURLProtocol: URLProtocol {
    
    // MARK: Properties
    
    public static var mockData: [MockURLRequest: MockURLResponse] = [:]
    
    // MARK: Functions
    
    public override class func canInit(with task: URLSessionTask) -> Bool {
        true
    }
    
    public override class func canInit(with request: URLRequest) -> Bool {
        true
    }
    
    public override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }
    
    public override func startLoading() {
        guard
            let httpMethod = request.httpMethod,
            let method = HTTPRequestMethod(rawValue: httpMethod),
            let url = request.url,
            let response = Self.mockData[.init(
                method: method,
                url: url
            )]
        else {
            client?.urlProtocolDidFinishLoading(self)
            return
        }
        
        if let data = response.data {
            client?.urlProtocol(self, didLoad: data)
        }
        
        if let httpResponse = HTTPURLResponse(
            url: url,
            statusCode: response.status.rawValue,
            httpVersion: nil,
            headerFields: response.headers
        ) {
            client?.urlProtocol(
                self,
                didReceive: httpResponse, 
                cacheStoragePolicy: .allowedInMemoryOnly
            )
        }

        client?.urlProtocolDidFinishLoading(self)
    }
    
    public override func stopLoading() {}

}

// MARK: - Structs

///  This model includes the data to be injected into an specific URL at the time of mocking its request.
public struct MockURLRequest: Hashable {
    public let method: HTTPRequestMethod
    public let url: URL
}

///  This model includes the data to be injected into an specific URL at the time of mocking its response.
public struct MockURLResponse {
    
    // MARK: Properties
    
    public let status: HTTPResponseCode
    public let headers: [String: String]
    public let data: Data?
    
    // MARK: Initialisers
    
    public init(
        status: HTTPResponseCode,
        headers: [String : String] = [:],
        data: Data? = nil
    ) {
        self.status = status
        self.headers = headers
        self.data = data
    }

}