import SwiftUI

/// A mock error conforming to `CSLErrorViewProtocol` for testing purposes.
struct MockError: CSLErrorViewProtocol {
    
    /// The title of the mock error.
    var title: String? = "Sample Error"
    
    /// A description of the mock error.
    var description: String? = "This is a mock error for testing purposes."
    
    /// The image link for the mock error, if any.
    var imageLink: String? = "https://example.com/error-image.png"
    
    /// A local image resource for the mock error, if any.
    var imageResource: ImageResource?
    
    /// Whether the mock error includes a retry button.
    var withRetryButton: Bool = true
    
    /// The title of the retry button for the mock error.
    var buttonTitle: String? = "Retry"
}
