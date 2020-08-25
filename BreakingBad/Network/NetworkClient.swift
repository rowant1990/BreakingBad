//
//  NetworkClient.swift
//  BreakingBad
//
//  Created by Rowan Townshend on 24/08/2020.
//  Copyright © 2020 Keytree. All rights reserved.
//

import UIKit

struct NetworkClient {
    
    let session: URLSessionProtocol
    let decoder: ObjectDecoder
    
    init(session: URLSessionProtocol = URLSession.shared, decoder: ObjectDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }
    
    func fetch<T: Decodable>(url: URL, handler: @escaping (Result<T, Error>) -> Void) {
        session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                handler(.failure(error))
                return
            }
            
            guard let data = data else {
                handler(.failure(NetworkClientError.noData))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                handler(.failure(NetworkClientError.noResponse))
                return
            }
            
            guard response.statusCode >= 200 && response.statusCode <= 299 else {
                handler(.failure(NetworkClientError.badStatusCode(statusCode: response.statusCode)))
                return
            }
            
            do {
                let responseObject = try self.decoder.decode(T.self, from: data)
                handler(.success(responseObject))
            } catch {
                handler(.failure(NetworkClientError.parse))
            }
        }.resume()
    }
}

enum NetworkClientError: Error, Equatable {
    case noData
    case noResponse
    case badStatusCode(statusCode: Int)
    case parse
}

public protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {}


protocol ObjectDecoder {
    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T
}

extension JSONDecoder: ObjectDecoder {}
