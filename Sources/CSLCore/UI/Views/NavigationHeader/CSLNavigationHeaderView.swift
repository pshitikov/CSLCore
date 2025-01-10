import SwiftUI

/// An extension on `View` that adds the ability to overlay a custom header view onto the current view.
///
/// This method allows you to add a custom header view at the top of the screen by passing a closure that returns a `View`.
/// The header view is embedded into the navigation bar area using `CSLNavigationHeaderView`. You can also specify
/// the height of the header.
///
/// - Parameters:
///   - headerView: A closure that returns the custom header view to be displayed. The view can be any type conforming to `View`.
///   - height: The height of the custom header view.
///
/// - Returns: A modified view with the custom header overlayed.
///
/// - Example:
/// ```
/// struct ContentView: View {
///     var body: some View {
///         Text("Hello, world!")
///             .customHeaderView({
///                 Text("Custom Header")
///                     .font(.headline)
///                     .foregroundColor(.blue)
///             }, height: 50)
///     }
/// }
/// ```
public extension View {
    
    /// Adds a custom header view to the current view.
    ///
    /// - Parameters:
    ///   - headerView: A closure that returns the header view to display.
    ///   - height: The height of the header view.
    /// - Returns: A modified view with the header view overlay.
    @ViewBuilder
    func customHeaderView<Content: View>(@ViewBuilder _ headerView: @escaping () -> Content, height: CGFloat) -> some View {
        overlay(content: {
            CSLNavigationHeaderView(headerView: headerView, height: height)
                .frame(width: 0, height: 0)
        })
    }
}

/// A custom navigation header view that can be used in SwiftUI views.
///
/// This view uses `UIViewControllerRepresentable` to wrap a custom header view in a `UIViewController`
/// that can be used in a navigation bar. The header view is displayed in the navigation bar area, and its height is configurable.
///
/// - Parameters:
///   - headerView: A closure that returns the custom header view to be displayed.
///   - height: The height of the custom header view.
public struct CSLNavigationHeaderView<HeaderView: View>: UIViewControllerRepresentable {
    
    // MARK: - Properties
    
    /// The header view to display in the navigation bar.
    @ViewBuilder
    public var headerView: () -> HeaderView
    
    /// The height of the header view.
    let height: CGFloat
    
    // MARK: - UIViewControllerRepresentable
    
    /// Creates the `UIViewController` for the header view.
    ///
    /// - Parameter context: The context for the `UIViewControllerRepresentable`.
    /// - Returns: A new instance of `UIViewController`.
    public func makeUIViewController(context: Context) -> UIViewController {
        ViewControllerWrapper(
            headerView: headerView,
            height: height
        )
    }
    
    /// Updates the `UIViewController` if needed.
    ///
    /// - Parameters:
    ///   - uiViewController: The view controller to update.
    ///   - context: The context for the `UIViewControllerRepresentable`.
    public func updateUIViewController(_ uiViewController: UIViewController, context: Context) {} // swiftlint:disable:this no_empty_block
}

extension CSLNavigationHeaderView {
    
    /// A wrapper view controller that displays the header view in the navigation bar.
    class ViewControllerWrapper: UIViewController {
        
        // MARK: - Properties
        
        /// The header view to display.
        let headerView: () -> HeaderView
        
        /// The height of the header view.
        let height: CGFloat
        
        // MARK: - Initialization
        
        /// Initializes the view controller with a custom header view and height.
        ///
        /// - Parameters:
        ///   - headerView: A closure that returns the custom header view.
        ///   - height: The height of the custom header view.
        init(headerView: @escaping () -> HeaderView, height: CGFloat) {
            self.headerView = headerView
            self.height = height
            
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: - Life cycle
        
        /// Called when the view is about to appear.
        ///
        /// This method sets the header view in the navigation controller’s bottom palette.
        /// It also ensures that the header view is properly sized and clear of any background.
        override func viewWillAppear(_ animated: Bool) {
            guard let navigationController = self.navigationController, let navigationItem = navigationController.visibleViewController?.navigationItem else { return }
            
            let navBarPallete = NSClassFromString("_UINavigationBarPalette") as? UIView.Type
            
            let castedHeaderView = UIHostingController(rootView: self.headerView()).view
            castedHeaderView?.frame.size.height = height
            castedHeaderView?.backgroundColor = .clear
            
            let palette = navBarPallete?.perform(NSSelectorFromString("alloc"))
                .takeUnretainedValue()
                .perform(NSSelectorFromString("initWithContentView:"), with: castedHeaderView)
                .takeUnretainedValue()
            
            navigationItem.perform(NSSelectorFromString("_setBottomPalette:"), with: palette)
            
            super.viewWillAppear(animated)
        }
    }
}
