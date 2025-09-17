//
//  NetworkRequest.swift
//  TODO: app
//
//  Created by Sarvar on 17/09/25.
//

import Alamofire
import Foundation

public protocol NetworkRequest {
    func serialize<T: Decodable>() async throws -> T
    func serializeData() async throws -> Data
}

final class AlamofireNetworkRequest: NetworkRequest {
    private let dataRequest: DataRequest

    init(dataRequest: DataRequest) {
        self.dataRequest = dataRequest
    }

    func serialize<T: Decodable>() async throws -> T {
        try await dataRequest.serializingDecodable(T.self).value
    }

    func serializeData() async throws -> Data {
        try await dataRequest.serializingData().value
    }
}
