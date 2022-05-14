
import Combine
import Foundation

final class ImageLoader: ObservableObject {
    var didChange = PassthroughSubject<Data, Never>()
    private var data = Data() {
        didSet { didChange.send(data) }
    }
    
    public init(url: URL) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }
        task.resume()
    }
}
