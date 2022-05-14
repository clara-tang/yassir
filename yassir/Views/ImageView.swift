
import SwiftUI

struct ImageView: View {
    @ObservedObject var imageLoader: ImageLoader
    @State var image: UIImage = UIImage()
    
    init(url: URL) {
        imageLoader = ImageLoader(url: url)
    }
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .onReceive(imageLoader.didChange) { data in
                if let image = UIImage(data: data) {
                    self.image = image
                }
            }
    }
}
