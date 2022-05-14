import Combine

final class HomeViewStateProvider: ObservableObject {
    
    enum ViewState {
        case loading
        case loaded([Movie])
        case error(ServiceError)
    }
    
    @Published private(set) var viewState: ViewState = .loading
    
    func fetchMovies() {
        Service().fetchAllMovies { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.viewState = .loaded(response.results)
            case .failure(let error):
                self.viewState = .error(error)
            }
        }
    }
}
