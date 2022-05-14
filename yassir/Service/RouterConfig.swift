
enum BaseURL: String {
    case allMovie = "https://api.themoviedb.org"
    case image    = "https://image.tmdb.org/t/p/w500/"
}

enum Method: String {
    case get   = "GET"
}

struct RouterConfig {
    let httpMethod: Method
    let base: BaseURL
    let path: String
    let queryItems: [String: String]
}
