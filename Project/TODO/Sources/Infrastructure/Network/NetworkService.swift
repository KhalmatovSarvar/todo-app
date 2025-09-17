//
//  NetworkService.swift
//  TODO: app
//
//  Created by Sarvar on 17/09/25.
//
import Alamofire
import Foundation

protocol NetworkService {
    func request(endpoint: Requestable) throws -> NetworkRequest
}

final class AlamofireNetworkService: NetworkService {
    private let session: Session
    private let config: NetworkConfigurable

    init(session: Session = .default, config: NetworkConfigurable) {
        self.session = session
        self.config = config
    }

    func request(endpoint: Requestable) throws -> NetworkRequest {
        let urlRequest = try endpoint.urlRequest(with: config)
        let request = session.request(urlRequest)
        return AlamofireNetworkRequest(dataRequest: request)
    }
}
