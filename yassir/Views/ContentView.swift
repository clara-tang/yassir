
import SwiftUI

struct ContentView: View {
    @ObservedObject var stateProvider = HomeViewStateProvider()
    
    // MARK: - Constants
    private let padding: CGFloat = 16.0
    private let cellHeight: CGFloat = 90.0
    
    // MARK: - Views

    var body: some View {
        mainView
            .onAppear { stateProvider.fetchMovies() }
    }
    
    @ViewBuilder private var mainView: some View {
        switch stateProvider.viewState {
            case .loading: Text("Loading")
            case .loaded(let movies): makeMovieListNavigationView(movies)
            case .error(let error): Text("Fetch error: \(error.localizedDescription)")
        }
    }
    
    private func makeMovieListNavigationView(_ movies: [Movie]) -> some View {
        NavigationView {
            List(movies, id: \.self) { movie in
                NavigationLink(destination: MovieDetailView(movieID: "\(movie.id)")) {
                    MovieCell(movie: movie)
                        .frame(width: UIScreen.main.bounds.width-padding*2, height: cellHeight)
                }
            }
        }
    }
}

// MARK: - PreviewProvider

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
