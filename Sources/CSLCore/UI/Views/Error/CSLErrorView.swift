import SwiftUI
import SDWebImageSwiftUI

/// A view that displays an error with optional retry functionality.
///
/// This view is designed to present error messages, including an optional retry button.
/// It can display a title, description, and an image, based on the error data passed in.
/// The retry button action is optional and is triggered when the user taps the button.
///
/// - Parameters:
///   - error: An object conforming to `CSLErrorViewProtocol` that provides the error details, such as title, description, and button settings.
///   - retryAction: An optional closure that is called when the user taps the retry button. Defaults to `nil`.
///
/// - See Also: ``CSLErrorViewProtocol``
///
/// - Example:
/// ```
/// let errorView = CSLErrorView(error: someError, retryAction: {
///     // Retry logic here
/// })
/// ```
public struct CSLErrorView: View {
    
    // MARK: - Enums
    
    /// A set of constant values used within the view.
    private enum Values {
        
        /// The title of the retry button.
        static let retryButtonTitle = "Повторить"
        
        /// The vertical spacing between stacked elements.
        static let verticalStackSpacing: CGFloat = 20
    }
    
    // MARK: - Properties
    
    /// The error data to be displayed in the view.
    private let error: CSLErrorViewProtocol
    
    /// The action to be performed when the retry button is tapped.
    private let retryAction: (() -> Void)?
    
    // MARK: - Initialization
    
    /// Creates a new instance of `CSLErrorView`.
    ///
    /// - Parameters:
    ///   - error: An object conforming to `CSLErrorViewProtocol` providing error details.
    ///   - retryAction: An optional closure to be called on retry button tap. Defaults to `nil`.
    public init(error: CSLErrorViewProtocol, retryAction: (() -> Void)? = nil) {
        self.error = error
        self.retryAction = retryAction
    }
    
    // MARK: - Body
    
    /// The body of the view, which includes the label, description, and actions.
    public var body: some View {
        ContentUnavailableView(
            label: { label },
            description: { description },
            actions: { actions }
        )
    }
    
    // MARK: - Views
    
    /// The label view showing the error title and icon.
    private var label: some View {
        Label(
            title: { Text(error.title ?? "") },
            icon: { image }
        )
    }
    
    /// The description view displaying the error description, if available.
    @ViewBuilder
    private var description: some View {
        if let description = error.description {
            Text(description)
        }
    }
    
    /// The actions view displaying the retry button, if applicable.
    @ViewBuilder
    private var actions: some View {
        if error.withRetryButton {
            Button(error.buttonTitle ?? Values.retryButtonTitle) { retryAction?() }
                .buttonStyle(.borderedProminent)
        }
    }
    
    /// The image view displaying an error-related image, either from a URL or a resource.
    @ViewBuilder
    private var image: some View {
        if let imageLink = error.imageLink {
            WebImage(url: URL(string: imageLink))
        } else if let imageResource = error.imageResource {
            Image(imageResource)
        } else {
            EmptyView()
        }
    }
}

// MARK: - Previews

#Preview {
    CSLErrorView(error: MockError(), retryAction: nil)
}
