import SwiftUI

/// A SwiftUI view that displays a circular progress indicator with an optional insertion delay.
///
/// The `CSLProgressView` provides a simple circular progress indicator, which can be customized with an insertion delay to control when the progress view appears. This can be useful for ensuring that the progress view is only displayed after a specified amount of time, preventing it from flickering or appearing unnecessarily quickly.
///
/// - Parameters:
///   - insertionDelay: The amount of time (in seconds) to wait before showing the progress view. This is useful for preventing the progress view from being shown immediately when the view is rendered. Defaults to `CSLConstants.progressViewInsertionDelay`.
///
/// - See Also: `ProgressView`, `withOpacityAnimation`
public struct CSLProgressView: View {
    
    // MARK: - Properties
    
    /// The delay before the progress view becomes visible (in seconds).
    private let insertionDelay: TimeInterval
    
    // MARK: - Initialization
    
    /// Initializes a new instance of `CSLProgressView` with an optional insertion delay.
    ///
    /// - Parameters:
    ///   - insertionDelay: The amount of time (in seconds) to wait before showing the progress view. Defaults to `CSLConstants.progressViewInsertionDelay`.
    public init(insertionDelay: TimeInterval = CSLConstants.progressViewInsertionDelay) {
        self.insertionDelay = insertionDelay
    }
    
    // MARK: - Body
    
    /// The body of the view that displays the circular progress indicator with a fade-in animation.
    public var body: some View {
        ProgressView()
            .progressViewStyle(.circular)
            .withOpacityAnimation(insertionDelay: insertionDelay)
    }
}

// MARK: - Previews

#Preview { CSLProgressView() }
