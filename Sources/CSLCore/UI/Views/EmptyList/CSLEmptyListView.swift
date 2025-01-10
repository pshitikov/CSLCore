import SwiftUI

/// A SwiftUI view that displays an empty list with a smooth opacity animation.
/// The list is scroll-disabled, ensuring no content is displayed.
public struct CSLEmptyListView: View {
    
    // MARK: - Body
    
    /// The content body of the view. It displays an empty list with a smooth opacity animation.
    /// The list is scroll-disabled, ensuring no scrolling interaction.
    public var body: some View {
        List { EmptyView() }
            .scrollDisabled(true) // Disables scrolling interaction in the list
            .withOpacityAnimation() // Applies an opacity animation for a smooth transition
    }
    
    // MARK: - Initialization
    
    /// Initializes an instance of `CSLEmptyListView` with default settings.
    ///
    /// This initializer does not require any parameters or additional configuration.
    public init() { /* Default implementation */ }
}

// MARK: - Previews

/// Preview for `CSLEmptyListView` to visualize the view in SwiftUI canvas.
#Preview { CSLEmptyListView() }
