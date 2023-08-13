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
import XCTest

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

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
    
    func test_withEndpoint_initialisedWithParameters() throws {
        // GIVEN
        let endpoint = TestEndpoint(parameters: [
            "someParameter": "someValue",
            "anotherParameter": nil,
            "otherParameter": "yetAnotherValue"
        ])
        
        // WHEN
        let result = try makeURLRequest(endpoint: endpoint)
        
        // THEN
        XCTAssertNotNil(result)
        XCTAssertEqual(result.url?.absoluteString, "http://www.something.com/path/to/endpoint?anotherParameter&otherParameter=yetAnotherValue&someParameter=someValue")
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
