//
//  NetworkConfigurable.swift
//  TODO: app
//
//  Created by Sarvar on 17/09/25.
//
import Alamofire
import Foundation

public protocol NetworkConfigurable {
    var baseURL: URL { get }
    var headers: [String: String] { get }
}

public struct SimpleNetworkConfig: NetworkConfigurable {
    public let baseURL: URL
    public let headers: [String: String]

    public init(baseURL: URL, headers: [String: String] = [:]) {
        self.baseURL = baseURL
        self.headers = headers
    }
}
