import Foundation

// MARK: - AllMovieReponse

struct AllMovieReponse: Decodable {
    let page: Int
    let results: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case page, results
    }
}

// MARK: - Movie

struct Movie: Decodable, Identifiable, Hashable {
    let id: Int
    let title: String
    let overview: String
    private let _releaseDate: String
    
    private enum CodingKeys: String, CodingKey {
        case id, title, overview
        case _releaseDate = "release_date"
    }
}

extension Movie {
    var releaseYear: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date: Date = formatter.date(from: _releaseDate) ?? Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: date)
        return "\(components.year ?? 0)"
    }
}
