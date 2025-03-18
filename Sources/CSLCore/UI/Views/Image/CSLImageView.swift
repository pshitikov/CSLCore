import SwiftUI
import SFSafeSymbols
import SDWebImageSwiftUI

/// `CSLImageView` is a SwiftUI view designed to display an image from a URL with a placeholder while the image is loading.
///
/// The view supports:
/// - Fetching and displaying an image from a URL using the `WebImage` component from `SDWebImageSwiftUI`.
/// - Showing a placeholder view with a default icon and background color while the image is being loaded.
public struct CSLImageView: View {
    
    // MARK: - Enums
    
    // MARK: - Properties
    
    /// The URL of the image to be displayed.
    private let imageLink: URL?
    private let placeholder: Image?
    
    // MARK: - Initialization

    public init(imageLink: URL?, placeholder: Image? = nil) {
        self.imageLink = imageLink
        self.placeholder = placeholder
    }
    
    public init?(imageLink: String?) {
        guard let imageLink,
              let url = URL(string: imageLink) else { return nil }
        
        self.init(imageLink: url)
    }
    
    // MARK: - Body
    
    /// The body of the image view.
    ///
    /// This view uses the `WebImage` component from `SDWebImageSwiftUI` to load the image from the provided URL. It displays the image once it's loaded or shows a placeholder while loading.
    public var body: some View {
        WebImage(
            url: imageLink,
            content: { image in imageView(image) },
            placeholder: { placeholder }
        )
    }
}

// MARK: - Views

extension CSLImageView {
    
    /// The view displaying the loaded image.
    ///
    /// - Parameter image: The loaded image to be displayed.
    /// - Returns: A view that resizes and scales the image to fit within the available space.
    private func imageView(_ image: Image) -> some View {
        image
            .resizable()
            .scaledToFill()
    }
}

// MARK: - Previews

/// Preview for `CSLImageView`.
///
/// This preview renders the image view with a sample image URL for display in Xcode previews.
#Preview {
    let imageLink = URL(string: "https://plushkipodruzhki.ru/pictures/product/middle/15315_middle.jpg")
    
    return CSLImageView(imageLink: imageLink)
}
