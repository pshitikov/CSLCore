import SwiftUI

/// A custom `ViewModifier` that executes an action when the view appears for the first time.
///
/// The ``OnFirstAppearModifier`` is used to trigger a closure only once,
/// the first time a view appears in the view hierarchy.
/// This is useful for performing one-time setup or side effects
/// when a view becomes visible for the first time.
///
/// - Note: The action will not be triggered again even if the view is re-rendered.
///
/// Usage:
/// ```swift
/// YourView()
///     .modifier(OnFirstAppearModifier {
///         // Your action here
///     })
/// ```
///
/// Alternatively, use the `onFirstAppear` convenience method on any `View`.
public struct OnFirstAppearModifier: ViewModifier {
    
    // MARK: - Properties
    
    /// Tracks whether the view has appeared before.
    @State
    private var isAppeared = false
    
    /// The closure to execute when the view appears for the first time.
    private let onFirstAppearAction: () -> Void
    
    // MARK: - Initialization
    
    /// Creates a new instance of `OnFirstAppearModifier`.
    ///
    /// - Parameter onFirstAppearAction: A closure to execute when the view appears for the first time.
    public init(_ onFirstAppearAction: @escaping () -> Void) {
        self.onFirstAppearAction = onFirstAppearAction
    }
    
    // MARK: - Body
    
    /// The body of the modifier that applies the `onAppear` logic.
    ///
    /// - Parameter content: The content view to which the modifier is applied.
    /// - Returns: A view that triggers the specified action on its first appearance.
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
    /// - Parameter onFirstAppearAction: A closure to execute when the view appears for the first time.
    /// - Returns: A view with the `onFirstAppear` behavior applied.
    public func onFirstAppear(_ onFirstAppearAction: @escaping () -> Void) -> some View {
        modifier(OnFirstAppearModifier(onFirstAppearAction))
    }
}
