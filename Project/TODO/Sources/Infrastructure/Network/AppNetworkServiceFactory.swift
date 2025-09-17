import Alamofire
import Foundation

struct AppConstants {
    static let url: URL = URL(string: "https://jsonplaceholder.typicode.com")!
}

public enum HTTPMethodType: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

final class AppNetworkServiceFactory {
    static let `default` = AppNetworkServiceFactory()

    func makeNetworkService() -> NetworkService {
        let config = SimpleNetworkConfig(baseURL: AppConstants.url)
        return AlamofireNetworkService(config: config)
    }
}
