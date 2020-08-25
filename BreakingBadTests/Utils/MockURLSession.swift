//
//  MockURLSession.swift
//  BreakingBadTests
//
//  Created by Rowan Townshend on 25/08/2020.
//  Copyright © 2020 Keytree. All rights reserved.
//

import BreakingBad
import Foundation

class MockURLSession: URLSessionProtocol {
    
    var body: Any?
    var error: Error?
    var responseCode: Int? = 200
    
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return MockURLSessionDataTask( closure: {
            if let body = self.body {
                
                let response: HTTPURLResponse?
                if let responseCode = self.responseCode {
                    response = HTTPURLResponse(url: url, statusCode: responseCode, httpVersion: nil, headerFields: nil)
                } else{
                    response = nil
                }
                let data = try! JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
                completionHandler(data, response, nil)
            } else if let error = self.error {
                completionHandler(nil, nil, error)
            } else {
                completionHandler(nil, nil, self.error)
            }
        })
    }
}

private class MockURLSessionDataTask: URLSessionDataTask {
    private let closure: () -> Void
    
    init(closure: @escaping () -> Void) {
        self.closure = closure
    }
    
    override func resume() {
        closure()
    }
}

