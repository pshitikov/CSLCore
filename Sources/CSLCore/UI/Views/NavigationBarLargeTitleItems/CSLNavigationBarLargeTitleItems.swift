import SwiftUI

/// `CSLNavigationBarLargeTitleItems` is a SwiftUI view that integrates with UIKit's `UINavigationController` to customize the navigation bar with large titles and trailing items.
///
/// This view allows for the customization of the trailing items (such as buttons or other views) in a navigation bar when using large titles.
public struct CSLNavigationBarLargeTitleItems<Content>: UIViewControllerRepresentable where Content: View {
    
    // MARK: - Typealiases
    
    /// The type of the `UIViewController` that will be created.
    public typealias UIViewControllerType = Wrapper
    
    // MARK: - Properties
    
    /// A closure that provides the content for the trailing items in the navigation bar.
    /// This content is displayed as part of the navigation bar.
    @ViewBuilder
    let trailingItems: () -> Content
    
    // MARK: - Initialization
    
    /// Initializes a new instance of `CSLNavigationBarLargeTitleItems`.
    ///
    /// - Parameters:
    ///     - trailing: A closure that defines the content to be displayed as the trailing items in the navigation bar.
    public init(@ViewBuilder trailing: @escaping () -> Content) { trailingItems = trailing }
    
    // MARK: - UIViewControllerRepresentable
    
    /// Creates the `Wrapper` view controller that will be used to manage the navigation bar customizations.
    ///
    /// - Parameter context: The context for the view controller.
    /// - Returns: A `Wrapper` instance that represents the custom navigation bar configuration.
    public func makeUIViewController(context: Context) -> Wrapper {
        Wrapper(representable: self)
    }
    
    /// Updates the `Wrapper` view controller with the latest state, adding the trailing items to the navigation bar.
    ///
    /// - Parameters:
    ///     - uiViewController: The view controller that will be updated.
    ///     - context: The context for the view controller update.
    public func updateUIViewController(_ uiViewController: Wrapper, context: Context) {
        uiViewController.addTrailingItems()
    }
}
