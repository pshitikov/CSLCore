import SwiftUI

/// A view modifier that performs an action only the first time the view appears.
///
/// Use `OnFirstAppearModifier` to run a closure **once**, when the view enters the view hierarchy for the first time.
/// This is useful for triggering side effects such as:
/// - Initial data loading
/// - Analytics tracking
/// - One-time animations or transitions
///
/// The action will not be triggered again even if the view is re-rendered.
///
/// You can apply this modifier directly:
/// ```swift
/// YourView()
///     .modifier(OnFirstAppearModifier {
///         // Your action here
///     })
/// ```
///
/// Or use the `.onFirstAppear(_:)` convenience method:
/// ```swift
/// YourView()
///     .onFirstAppear {
///         // Your action here
///     }
/// ```
///
/// - SeeAlso: `View.onFirstAppear(_:)`
public struct OnFirstAppearModifier: ViewModifier {
    
    // MARK: - Properties
    
    /// Tracks whether the view has already appeared.
    @State
    private var isAppeared = false
    
    /// The closure to perform on first appearance.
    private let onFirstAppearAction: () -> Void
    
    // MARK: - Initialization
    
    /// Creates a modifier that triggers an action once when the view appears.
    ///
    /// - Parameter onFirstAppearAction: A closure to perform when the view appears for the first time.
    public init(_ onFirstAppearAction: @escaping () -> Void) {
        self.onFirstAppearAction = onFirstAppearAction
    }
    
    // MARK: - Body
    
    public func body(content: Content) -> some View {
        content
            .onAppear {
                guard !isAppeared else { return }
                isAppeared = true
                onFirstAppearAction()
            }
    }
}

// MARK: - View Extension

extension View {
    
    /// Adds an action to perform only when the view appears for the first time.
    ///
    /// This is a convenience method for applying `OnFirstAppearModifier`.
    ///
    /// - Parameter onFirstAppearAction: A closure to perform when the view appears for the first time.
    /// - Returns: A view that triggers the action only once on its first appearance.
    ///
    /// - SeeAlso: `OnFirstAppearModifier`
    public func onFirstAppear(_ onFirstAppearAction: @escaping () -> Void) -> some View {
        modifier(OnFirstAppearModifier(onFirstAppearAction))
    }
}
