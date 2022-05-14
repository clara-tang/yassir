
import Foundation

// MARK: - Public Methods

extension URLSession {
    
    /// Starts an URLSession and handles the response
    /// - Parameters:
    ///   - request: URLRequest
    ///   - completion: completion handler
    func decodeResponse<T: Decodable>(
        _ request: URLRequest,
        completion: @escaping (Result<T, ServiceError>) -> Void
    ) {
        self.dataTask(with: request) { (data, response, err) in
            guard let response = response as? HTTPURLResponse else { completion(.failure(.requestError(.urlSessionError)))
                return
            }
            
            guard self.isValidResponse(response) else {
                completion(.failure(self.parseResponseError(response)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.nullData))
                return
            }

            completion(self.decodeData(data))
        }
        .resume()
    }
}

// MARK: - Private Methods

extension URLSession {
    
    /// Tells if a repsponse is a valid resonse
    /// - Parameter response: HTTPURLResponse
    /// - Returns: Bool
    private func isValidResponse(_ response: HTTPURLResponse) -> Bool {
        return Config.successCodeRange.contains(response.statusCode)
    }
    
    
    /// Tells the error type of response
    /// - Parameter response: HTTPURLResponse
    /// - Returns: ServiceError type
    private func parseResponseError(_ response: HTTPURLResponse) -> ServiceError {
        switch response.statusCode {
            case Config.clientErrorCodeRange: return .requestError(.clientError)
            case Config.serverErrorCodeRange: return .requestError(.serverError)
            default:                          return .requestError(.urlSessionError)
        }
    }
    
    
    /// Decodes data into given data model
    /// - Parameter data: Data
    /// - Returns: Decoding Result
    private func decodeData<T: Decodable>(_ data: Data) -> Result<T, ServiceError> {
        let decoder: JSONDecoder = JSONDecoder()
        
        do { return try .success(decoder.decode(T.self, from: data)) }
        catch { return .failure(.decodingFailed) }
    }
    
    private enum Config {
        static let successCodeRange: ClosedRange<Int> = ClosedRange(200..<300)
        static let clientErrorCodeRange: ClosedRange<Int> = ClosedRange(400..<500)
        static let serverErrorCodeRange: ClosedRange<Int> = ClosedRange(500..<600)
    }
}
