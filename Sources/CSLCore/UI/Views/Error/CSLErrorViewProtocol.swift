import SwiftUI

/// A protocol that defines the requirements for an error model to be displayed in `CSLErrorView`.
///
/// This protocol is used to provide the necessary data (title, description, image, etc.) for presenting error information
/// in a UI. Conforming types should implement the properties to provide the appropriate data to be displayed.
///
/// - See Also: `CSLErrorView` for the view that displays this error information.
///
/// - Example:
/// ```
/// struct MyError: CSLErrorViewProtocol {
///     var title: String? = "Error"
///     var description: String? = "An unexpected error occurred."
///     var imageLink: String? = nil
///     var imageResource: ImageResource? = nil
///     var withRetryButton: Bool = true
///     var buttonTitle: String? = "Retry"
/// }
/// ```
public protocol CSLErrorViewProtocol: Error {
    
    /// The title of the error to be displayed.
    var title: String? { get }
    
    /// A description of the error to be displayed.
    var description: String? { get }
    
    /// A link to an image to be displayed alongside the error, if available.
    var imageLink: String? { get }
    
    /// A local image resource to be displayed alongside the error, if available.
    var imageResource: ImageResource? { get }
    
    /// A flag indicating whether a retry button should be shown.
    var withRetryButton: Bool { get }
    
    /// The title of the retry button, if present.
    var buttonTitle: String? { get }
}
