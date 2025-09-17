import Alamofire
import Foundation

struct AppConstants {
    static let url: URL = URL(string: "https://jsonplaceholder.typicode.com")!
}

final class AppNetworkServiceFactory {
    static let `default` = AppNetworkServiceFactory()

    func makeNetworkService() -> NetworkService {
        let config = SimpleNetworkConfig(baseURL: AppConstants.url)
        return AlamofireNetworkService(config: config)
    }
}

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

public enum HTTPMethodType: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

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

public protocol NetworkService {
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
