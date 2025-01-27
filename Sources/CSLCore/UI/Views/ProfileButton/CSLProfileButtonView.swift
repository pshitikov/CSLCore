import SwiftUI

/// A custom SwiftUI view that displays a button with an optional profile image.
///
/// The `CSLProfileButtonView` is a customizable button component that can display a profile image, and triggers a closure when selected. The image is rendered from the provided image data, and the action is executed when the button is tapped.
///
/// - Parameters:
///   - imageData: Optional data to display as the profile image inside the button. If not provided, the button will not display an image.
///   - didSelect: A closure to be executed when the button is tapped. It is optional and can be nil if no action is required.
///
/// - See Also: `Button`, `Image`
public struct CSLProfileButtonView: View {
    
    // MARK: - Enums
    
    /// A private enum used to define static values.
    private enum Values {
        
        /// The size of the image displayed inside the button.
        static let defaultImageSize = CGSize(width: 32, height: 32)
    }
    
    // MARK: - Properties
    
    /// The optional image link to display as the profile image.
    private var imageLink: String?
    
    /// The optional image data to display as the profile image.
    private var imageData: Data?
    
    /// The optional image size to display as the profile image.
    private var imageSize: CGSize
    
    /// A closure to be executed when the button is tapped.
    private var didSelect: (() -> Void)?
    
    // MARK: - Initialization
    
    /// Initializes a new instance of `CSLProfileButtonView`.
    ///
    /// - Parameters:
    ///   - imageData: Optional data to be displayed as the profile image inside the button. Defaults to `nil`.
    ///   - imageSize: Optional size to be displayed as the profile image inside the button. Defaults to `defaultImageSize`.
    ///   - didSelect: A closure to be executed when the button is tapped. Defaults to `nil`.
    public init(
        imageData: Data? = nil,
        imageSize: CGSize? = nil,
        didSelect: (() -> Void)? = nil
    ) {
        self.imageData = imageData
        self.imageSize = imageSize ?? Values.defaultImageSize
        self.didSelect = didSelect
    }
    
    /// Initializes a new instance of `CSLProfileButtonView`.
    ///
    /// - Parameters:
    ///   - imageLink: Optional link to be displayed as the profile image inside the button. Defaults to `nil`.
    ///   - imageSize: Optional size to be displayed as the profile image inside the button. Defaults to `defaultImageSize`.
    ///   - didSelect: A closure to be executed when the button is tapped. Defaults to `nil`.
    public init(
        imageLink: String? = nil,
        imageSize: CGSize? = nil,
        didSelect: (() -> Void)? = nil
    ) {
        self.imageLink = imageLink
        self.imageSize = imageSize ?? Values.defaultImageSize
        self.didSelect = didSelect
    }
    
    // MARK: - Body
    
    /// The body of the `CSLProfileButtonView` containing the button with the optional image and action.
    public var body: some View {
        Button(
            action: { didSelect?() },
            label: { buttonLabelView }
        )
    }
    
    // MARK: - Views
    
    /// A view that represents the button's label, which includes the profile image (if available).
    @ViewBuilder
    private var buttonLabelView: some View {
        imageData != nil
        ? CSLProfileImageView(imageData: imageData)
            .frame(width: imageSize.width, height: imageSize.height)
        : CSLProfileImageView(imageLink: imageLink)
            .frame(width: imageSize.width, height: imageSize.height)
    }
}

// MARK: - Previews

#Preview {
    CSLProfileButtonView(imageData: nil)
}
