import UIKit

extension UIImage {
    
    static func asyncFrom(
        url: URL,
        service: ImageService = ImageService(),
        completion: @escaping (Result<UIImage, Error>) -> Void
    ) {
        service.get(url: url) { result in
            switch result {
            case .success(let data):
                asyncFrom(data: data, completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }


    private static func asyncFrom(data: Data, _ completion: @escaping (Result<UIImage, Error>) -> Void) {
        DispatchQueue.global(qos: .default).async {
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(.success(image))
                }
            } else {
                DispatchQueue.main.async {
                    completion(.failure(NSError()))
                }
            }
        }
    }
}
