
enum ServiceError: Error {
    enum ResponseError: Error {
        case clientError
        case serverError
        case urlSessionError
    }
    
    case requestError(ResponseError)
    case nullData
    case decodingFailed
}
