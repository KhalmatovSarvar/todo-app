//
//  Requestable.swift
//  TODO app
//
//  Created by Sarvar on 17/09/25.
//

import Alamofire
import Foundation

public protocol Requestable {
    var path: String { get }
    var method: HTTPMethodType { get }
    var headers: [String: String] { get }

    func urlRequest(with config: NetworkConfigurable) throws -> URLRequest
}

public extension Requestable {
    var method: HTTPMethodType { .get }
    var headers: [String: String] { [:] }

    func urlRequest(with config: NetworkConfigurable) throws -> URLRequest {
        let url = config.baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = config.headers.merging(headers) { _, new in new }
        return request
    }
}
