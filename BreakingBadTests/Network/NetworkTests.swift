//
//  NetworkTests.swift
//  BreakingBadTests
//
//  Created by Rowan Townshend on 25/08/2020.
//  Copyright © 2020 Keytree. All rights reserved.
//

import XCTest
@testable import BreakingBad

class NetworkTests: XCTestCase {
    
    var sut: NetworkClient!
    var mockURLSession: MockURLSession!
    var mockObjectDecoder: MockObjectDecoder!
    let mockUrl = URL(string: "http://breakingbad.com")!
    
    override func setUp() {
        super.setUp()
        mockObjectDecoder = MockObjectDecoder()
        mockURLSession = MockURLSession()
        sut = NetworkClient(session: mockURLSession, decoder: mockObjectDecoder)
    }
    
    override func tearDown() {
        mockObjectDecoder = nil
        mockURLSession = nil
        sut = nil
        super.tearDown()
    }
    
    func testShouldReturnFailureWithError() {
        let error = NetworkClientError.noData
        mockURLSession.error = error
        sut.fetch(url: mockUrl) { (result: Result<MockDecodable, Error>) in
            switch result {
            case .success:
                XCTFail()
            case let .failure(networkError):
                XCTAssertEqual(error, networkError as! NetworkClientError)
            }
        }
    }
    
    func testShouldReturnNoDataErrorIfNoData() {
        mockURLSession.body = nil
        sut.fetch(url: mockUrl) { (result: Result<MockDecodable, Error>) in
            switch result {
            case .success:
                XCTFail()
            case let .failure(networkError):
                XCTAssertEqual(networkError as! NetworkClientError, .noData)
            }
        }
    }
    
    func testShouldReturnNoResponseErrorIfNoResponse() {
        mockURLSession.body = ["test": "mock"]
        mockURLSession.responseCode = nil
        sut.fetch(url: mockUrl) { (result: Result<MockDecodable, Error>) in
            switch result {
            case .success:
                XCTFail()
            case let .failure(networkError):
                XCTAssertEqual(networkError as! NetworkClientError, .noResponse)
            }
        }
    }
    
    func testShouldReturnBadStatusCode() {
        mockURLSession.body = ["test": "mock"]
        mockURLSession.responseCode = 300
        sut.fetch(url: mockUrl) { (result: Result<MockDecodable, Error>) in
            switch result {
            case .success:
                XCTFail()
            case let .failure(networkError):
                XCTAssertEqual(networkError as! NetworkClientError, .badStatusCode(statusCode: 300))
            }
        }
    }
    
    func testShouldDecodeIwthSuccessfullRequest() {
        let mockResult = [MockDecodable(), MockDecodable()]
        mockURLSession.body = ["test": "mock"]
        mockObjectDecoder.decodedResult = mockResult
        
        sut.fetch(url: mockUrl) { (result: Result<[MockDecodable], Error>) in
            switch result {
            case let .success(b):
                XCTAssert(self.mockObjectDecoder.decoded)
                XCTAssertEqual(b.count, mockResult.count)
            case .failure:
                XCTFail()
            }
        }
    }
    
    func testShouldReturnParseError() {
        let mockResult = [MockDecodable(), MockDecodable()]
        mockURLSession.body = ["test": "mock"]
        mockObjectDecoder.decodedResult = mockResult
        mockObjectDecoder.shouldThrow = true
        
        sut.fetch(url: mockUrl) { (result: Result<[MockDecodable], Error>) in
            switch result {
            case .success:
                XCTFail()
                
            case let .failure(networkError):
                XCTAssertEqual(networkError as! NetworkClientError, .parse)
                
            }
        }
    }
}

struct MockDecodable: Decodable {}

class MockObjectDecoder: ObjectDecoder {
    
    var decoded = false
    var decodedResult: [MockDecodable]?
    var shouldThrow = false
    
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable {
        if shouldThrow {
            throw MockDecodableError.error
        }
        decoded = true
        return decodedResult as! T
    }
}

private enum MockDecodableError: Error {
    case error
}
