
import Foundation
import UIKit

public struct Service {
    
    let session: URLSession
    
    public init() {
        self.session = URLSession(configuration: .default)
    }
    
    func fetchAllMovies(
        completion: @escaping (Result<AllMovieReponse, ServiceError>) -> Void
    ) {
        let configs = RouterConfig(
            httpMethod: .get,
            base: .allMovie,
            path: "/3/discover/movie",
            queryItems: ["api_key": "c9856d0cb57c3f14bf75bdc6c063b8f3"]
        )
        request(configs) { result in
            completion(result)
        }
    }
    
    func fetchMovieDetails(
        id: String,
        completion: @escaping (Result<MovieDetails, ServiceError>) -> Void
    ) {
        let configs = RouterConfig(
            httpMethod: .get,
            base: .allMovie,
            path: "/3/movie/\(id)",
            queryItems: ["api_key": "c9856d0cb57c3f14bf75bdc6c063b8f3"]
        )
        
        request(configs) { result in
            completion(result)
        }
    }
}


class ImageService {
    func get(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(ServiceError.nullData))
                return
            }
            completion(.success(data))
        }.resume()
    }
}
