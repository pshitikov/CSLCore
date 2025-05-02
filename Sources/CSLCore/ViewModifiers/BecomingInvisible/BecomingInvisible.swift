import SwiftUI

/// A view modifier that triggers an action every time the view becomes completely invisible on screen.
///
/// Use `BecomingInvisible` to detect when a view is no longer visible within the screen bounds.
/// This can be useful for pausing tasks, stopping animations, saving state, or cleaning up resources.
///
/// Visibility is determined based on whether the view's global frame intersects the screen bounds.
///
/// Example usage:
/// ```swift
/// YourView()
///     .onBecomingInvisible {
///         // Perform cleanup or pause work here
///     }
/// ```
///
/// - Note: The action is triggered **each time** the view becomes invisible.
/// If the view reappears and becomes invisible again, the action will be re-triggered.
///
/// - SeeAlso: ``View/onBecomingInvisible(perform:)``

public struct BecomingInvisible: ViewModifier {
    
    // MARK: - Properties

    /// The action to perform when the view becomes invisible.
    @State
    public var action: (() -> Void)?
    
    // MARK: - Body

    public func body(content: Content) -> some View {
        content.overlay {
            GeometryReader { proxy in
                Color.clear
                    .preference(
                        key: VisibleKey.self,
                        value: UIScreen.main.bounds.intersects(proxy.frame(in: .global))
                    )
                    .onPreferenceChange(VisibleKey.self) { isVisible in
                        guard !isVisible, let action else { return }
                        
                        action()
                    }
            }
        }
    }
}

// MARK: - Preference Key

extension BecomingInvisible {
    
    /// A preference key used to track visibility state of the view.
    private struct VisibleKey: PreferenceKey {
        
        static var defaultValue: Bool = false
        
        static func reduce(value: inout Bool, nextValue: () -> Bool) { /* Default Implementation */ }
    }
}

// MARK: - View Extension

extension View {
    
    /// Adds an action to perform when the view becomes completely invisible on screen.
    ///
    /// This is a convenience method for applying `BecomingInvisible`.
    ///
    /// - Parameter action: A closure to perform when the view is no longer visible within the screen bounds.
    /// - Returns: A modified view that triggers the action when it becomes invisible.
    ///
    /// - SeeAlso: `BecomingInvisible`
    public func onBecomingInvisible(perform action: @escaping () -> Void) -> some View {
        modifier(BecomingInvisible(action: action))
    }
}
