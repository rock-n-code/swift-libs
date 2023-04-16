//
//  MakeURLRequestUseCaseTests.swift
//  CommunicationsTests
//
//  Created by Javier Cicchelli on 10/04/2023.
//  Copyright © 2023 Röck+Cöde. All rights reserved.
//

import Communications
import Foundation
import XCTest

final class MakeURLRequestUseCaseTests: XCTestCase {

    // MARK: Properties
    
    private let makeURLRequest = MakeURLRequestUseCase()

    // MARK: Test cases
    
    func test_withEndpoint_initialisedByDefault() throws {
        // GIVEN
        let endpoint = TestEndpoint()
        
        // WHEN
        let result = try makeURLRequest(endpoint: endpoint)
        
        // THEN
        XCTAssertNotNil(result)
        XCTAssertEqual(result.url?.absoluteString, "http://www.something.com/path/to/endpoint")
        XCTAssertEqual(result.httpMethod, HTTPRequestMethod.get.rawValue)
        XCTAssertEqual(result.allHTTPHeaderFields, [:])
        XCTAssertNil(result.httpBody)
    }
    
    func test_withEndpoint_initialisedWithPort() throws {
        // GIVEN
        let endpoint = TestEndpoint(port: 8080)
        
        // WHEN
        let result = try makeURLRequest(endpoint: endpoint)
        
        // THEN
        XCTAssertNotNil(result)
        XCTAssertEqual(result.url?.absoluteString, "http://www.something.com:8080/path/to/endpoint")
        XCTAssertEqual(result.httpMethod, HTTPRequestMethod.get.rawValue)
        XCTAssertEqual(result.allHTTPHeaderFields, [:])
        XCTAssertNil(result.httpBody)
    }
    
    func test_withEndpoint_initialisedWithHeaders() throws {
        // GIVEN
        let endpoint = TestEndpoint(headers: [
            "aHeader": "aValueForHead",
            "someOtherHeader": "someValueForOtherHeader"
        ])
        
        // WHEN
        let result = try makeURLRequest(endpoint: endpoint)
        
        // THEN
        XCTAssertNotNil(result)
        XCTAssertEqual(result.url?.absoluteString, "http://www.something.com/path/to/endpoint")
        XCTAssertEqual(result.httpMethod, HTTPRequestMethod.get.rawValue)
        XCTAssertEqual(result.allHTTPHeaderFields, [
            "aHeader": "aValueForHead",
            "someOtherHeader": "someValueForOtherHeader"
        ])
        XCTAssertNil(result.httpBody)
    }
    
    func test_withEndpoint_initialisedWithBody() throws {
        // GIVEN
        let data = "This is some data for a body of a request".data(using: .utf8)
        let endpoint = TestEndpoint(body: data)
        
        // WHEN
        let result = try makeURLRequest(endpoint: endpoint)
        
        // THEN
        XCTAssertNotNil(result)
        XCTAssertEqual(result.url?.absoluteString, "http://www.something.com/path/to/endpoint")
        XCTAssertEqual(result.httpMethod, HTTPRequestMethod.get.rawValue)
        XCTAssertEqual(result.allHTTPHeaderFields, [:])
        XCTAssertEqual(result.httpBody, data)
        XCTAssertNotNil(data)
    }

}

// MARK: - TestEndpoint

private struct TestEndpoint: Endpoint {

    // MARK: Properties
    
    let scheme: String = "http"
    let host: String = "www.something.com"
    let path: String = "/path/to/endpoint"
    let method: HTTPRequestMethod = .get
    
    var port: Int?
    var headers: [String : String]
    var body: Data?

    // MARK: Initialisers
    
    init(
        port: Int? = nil,
        headers: [String : String] = [:],
        body: Data? = nil
    ) {
        self.port = port
        self.body = body
        self.headers = headers
    }

}
