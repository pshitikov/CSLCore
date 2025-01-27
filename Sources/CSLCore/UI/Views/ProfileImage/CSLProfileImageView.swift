import SwiftUI
import SFSafeSymbols
import SDWebImageSwiftUI

/// A custom SwiftUI view that displays a profile image with a fallback to a default symbol.
///
/// The `CSLProfileImageView` displays a profile image, either from provided image data or a default system symbol. If the image data is unavailable, the view will fall back to a default `person.crop.circle.fill` system symbol, which can be customized with different styles. The image is clipped to a circular shape.
///
/// - Parameters:
///   - imageData: Optional data for the profile image. If provided, the image will be rendered from this data. If not, a default system symbol will be displayed.
///
/// - See Also: `Image`, `SFSymbol`, `SFSafeSymbols`
public struct CSLProfileImageView: View {
    
    // MARK: - Properties
    
    /// The optional link for the profile image.
    private var imageLink: String?
    
    /// The optional data for the profile image.
    private var imageData: Data?
    
    // MARK: - Initialization
    
    /// Initializes a new instance of `CSLProfileImageView`.
    ///
    /// - Parameters:
    ///   - imageData: Optional data for the profile image. If not provided, a default system symbol will be displayed. Defaults to `nil`.
    public init(imageData: Data? = nil) {
        self.imageData = imageData
    }
    
    /// Initializes a new instance of `CSLProfileImageView`.
    ///
    /// - Parameters:
    ///   - imageLink: Optional link for the profile image. If not provided, a default system symbol will be displayed. Defaults to `nil`.
    public init(imageLink: String? = nil) {
        self.imageLink = imageLink
    }
    
    // MARK: - Body
    
    /// The body of the view that displays the profile image or fallback symbol.
    public var body: some View {
        Group {
            if let imageData,
               let userImage = Image(data: imageData) {
                userImage
                    .resizable()
                    .scaledToFill()
            } else if let imageLink,
                      let url = URL(string: imageLink) {
                WebImage(
                    url: url,
                    content: { image in
                        image
                            .resizable()
                            .scaledToFill()
                    },
                    placeholder: { placeholderView }
                )
            } else {
                placeholderView
            }
        }
        .clipShape(.circle)
    }
    
    private var placeholderView: some View {
        Image(systemName: SFSymbol.personCropCircleFill.rawValue)
            .resizable()
            .symbolRenderingMode(.palette)
            .foregroundStyle(Color.secondaryLabel, Color.secondarySystemBackground)
    }
}

// MARK: - Previews

#Preview {
    CSLProfileImageView(imageData: nil)
}
