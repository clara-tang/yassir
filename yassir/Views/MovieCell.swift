
import SwiftUI

struct MovieCell: View {
    let movie: Movie
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8.0) {
                Text(movie.title)
                    .font(.system(size: 22.0, weight: .semibold))
                    .lineLimit(nil)
                Text(movie.releaseYear)
            }
            Spacer()
        }
    }
}

