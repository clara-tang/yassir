import Foundation

struct MovieDetails: Decodable {
    let id: Int
    let overview: String
    let title: String
    
    private let imagePath: String
    private let _releaseDate: String
    
    var fullImagePath: String {
        BaseURL.image.rawValue + "\(imagePath)"
    }
    
    private enum CodingKeys: String, CodingKey {
        case id, overview, title
        case imagePath = "backdrop_path"
        case _releaseDate = "release_date"
    }
}

extension MovieDetails {
    var releaseYear: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date: Date = formatter.date(from: _releaseDate) ?? Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: date)
        return "\(components.year ?? 0)"
    }
}
