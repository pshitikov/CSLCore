import SwiftUI

/// A custom SwiftUI view that wraps a `UIPageControl` for managing a page control with optional auto-scrolling.
///
/// This view provides a page control with the ability to display multiple pages and allows interaction with the page indicator.
/// It also includes an optional auto-scroll feature that automatically advances the pages after a specified duration.
///
/// - Parameters:
///   - numberOfPages: The total number of pages the control should display.
///   - currentPage: A binding to the current page index, which is updated when the user interacts with the control.
///   - withAutoScroll: A flag indicating whether the page control should automatically scroll to the next page after a set duration.
///
/// - See Also: `UIPageControl`, `UIViewRepresentable`
public struct CSLPageControl: UIViewRepresentable {
    
    // MARK: - Enums
    
    private enum Values {
        
        static let preferredDuration: TimeInterval = 10
    }
    
    // MARK: - Properties
    
    /// A binding to the current page index, which updates when the user interacts with the page control.
    @Binding
    private var currentPage: Int
    
    /// The total number of pages the page control should display.
    private var numberOfPages: Int
    
    /// A flag indicating whether auto-scrolling is enabled.
    private var withAutoScroll: Bool
    
    // MARK: - Initialization
    
    /// Initializes a new `CSLPageControl` with the specified number of pages, current page, and auto-scroll option.
    ///
    /// - Parameters:
    ///   - numberOfPages: The total number of pages.
    ///   - currentPage: A binding to the current page index.
    ///   - withAutoScroll: A flag indicating whether auto-scroll should be enabled.
    public init(numberOfPages: Int, currentPage: Binding<Int>, withAutoScroll: Bool) {
        self.numberOfPages = numberOfPages
        _currentPage = currentPage
        self.withAutoScroll = withAutoScroll
    }
    
    // MARK: - UIViewRepresentable
    
    /// Creates a coordinator to handle interactions with the `UIPageControl`.
    ///
    /// - Returns: A new `Coordinator` instance.
    public func makeCoordinator() -> Coordinator { Coordinator(self) }
    
    /// Creates the `UIPageControl` for use in the SwiftUI view.
    ///
    /// - Parameters:
    ///   - context: The context for the `UIViewRepresentable` view.
    /// - Returns: A configured `UIPageControl` instance.
    public func makeUIView(context: Context) -> UIPageControl {
        let control = UIPageControl()
        control.pageIndicatorTintColor = UIColor(Color.systemGray4)
        control.currentPageIndicatorTintColor = UIColor(Color.accentColor)
        control.numberOfPages = numberOfPages
        control.addTarget(
            context.coordinator,
            action: #selector(Coordinator.updateCurrentPage(sender:)),
            for: .valueChanged
        )
                
        if withAutoScroll {
            let progress = UIPageControlTimerProgress(preferredDuration: Values.preferredDuration)
            progress.resetsToInitialPageAfterEnd = true
            progress.resumeTimer()
            
            control.progress = progress
        }
        
        return control
    }
    
    /// Updates the `UIPageControl` with the current page index.
    ///
    /// - Parameters:
    ///   - uiView: The `UIPageControl` to update.
    ///   - context: The context for the `UIViewRepresentable` view.
    public func updateUIView(_ uiView: UIPageControl, context: Context) { uiView.currentPage = currentPage }
}

// MARK: - Coordinator

extension CSLPageControl {
    
    /// A coordinator class that handles user interactions with the page control.
    public final class Coordinator: NSObject {
        
        // MARK: - Properties
        
        /// A reference to the `CSLPageControl` instance that this coordinator is managing.
        var control: CSLPageControl
        
        // MARK: - Initialization
        
        /// Initializes the coordinator with a reference to the `CSLPageControl`.
        ///
        /// - Parameters:
        ///   - control: The `CSLPageControl` instance to manage.
        public init(_ control: CSLPageControl) { self.control = control }
        
        // MARK: - Internal functions
        
        /// Updates the current page index when the user interacts with the page control.
        ///
        /// - Parameters:
        ///   - sender: The `UIPageControl` instance that triggered the update.
        @MainActor
        @objc
        func updateCurrentPage(sender: UIPageControl) { control.currentPage = sender.currentPage }
    }
}
