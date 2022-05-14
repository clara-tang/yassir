
import Foundation

extension Service {
    
    /// Request data for Http get method
    /// - Parameters:
    ///   - router: router data
    ///   - completion: completion handler after fetching
    func request<T: Decodable>(
        _ router: RouterConfig,
        completion: @escaping (Result<T, ServiceError>) -> Void
    ) {
        guard let url = URL(string: router.base.rawValue + router.path) else {
            fatalError("URL(string: \(router.base.rawValue + router.path) is not a valid URL")
        }

        guard let completeURL: URL = url.addQueryItems(router.queryItems) else {
            fatalError("\(String(describing: url.addQueryItems(router.queryItems))) fails to compose a valid URL")
        }

        let request: URLRequest = URLRequest(
            url: completeURL,
            cachePolicy: .reloadIgnoringLocalCacheData,
            timeoutInterval: 30
        )
        
        session.decodeResponse(request) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}
