
import Combine

final class MovieDetailsStateProvider: ObservableObject {
    enum ViewState {
        case loading
        case loaded(MovieDetails)
        case error(ServiceError)
    }
    
    @Published private(set) var viewState: ViewState = .loading
    
    func fetchMovieDetails(_ movieID: String) {
        Service().fetchMovieDetails(id: movieID) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movieDetails):
                self.viewState = .loaded(movieDetails)
            case .failure(let error):
                self.viewState = .error(error)
            }
        }
    }
}
