
import Foundation

public extension URL {
    
    /// Returns an URL with designated queryItems
    /// - Parameter queryItems: queryItem key-value pairs
    func addQueryItems(_ queryItems: [String: String]) -> URL? {
        guard !queryItems.keys.isEmpty else { return self }
        var urlComponents = URLComponents(string: self.absoluteString)
        let urlQueryItems = queryItems.map { URLQueryItem(name: $0.key, value: $0.value)}
        urlComponents?.queryItems = urlQueryItems
        
        return urlComponents?.url
    }
}
