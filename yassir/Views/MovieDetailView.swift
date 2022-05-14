
import SwiftUI
import Combine

struct MovieDetailView: View {
    
    private let movieID: String
    
    // MARK: - Constants
    private let padding: CGFloat = 12.0
    private let imageHeight: CGFloat = 240.0
    private let titleFontSize: CGFloat = 20.0
    private let contentFontSize: CGFloat = 16.0

    public init(movieID: String) {
        self.movieID = movieID
    }
    
    @ObservedObject var stateProvider = MovieDetailsStateProvider()
    
    // MARK: - Views

    var body: some View {
        mainView
        .onAppear { stateProvider.fetchMovieDetails(movieID) }
    }
    
    @ViewBuilder private var mainView: some View {
        switch stateProvider.viewState {
            case .loading: Text("Loading")
            case .loaded(let movieDetails): makeMovieDetailView(movieDetails)
            case .error(let error): Text("Fetch error: \(error.localizedDescription)")
        }
    }
    
    private func makeMovieDetailView(_ movieDetails: MovieDetails) -> some View {
        VStack(spacing: padding) {
            if let url = URL(string: movieDetails.fullImagePath) {
                ImageView(url: url)
                    .frame(
                        width: UIScreen.main.bounds.width-padding*2,
                        height: imageHeight
                    )
            }
            
            Text(movieDetails.title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: titleFontSize, weight: .semibold))
            
            Text(movieDetails.releaseYear)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: contentFontSize, weight: .regular))
            
            Text(movieDetails.overview)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: contentFontSize, weight: .regular))
                .lineLimit(nil)
            
            Spacer()
        }
        .padding(.all, padding)
    }
}
