import SwiftUI

/// A view modifier that triggers an action every time the view becomes fully visible on screen.
///
/// Use `BecomingVisible` to detect when a view enters the visible screen area.
/// This can be useful for resuming tasks, triggering animations, or starting lazy loading when the view becomes visible.
///
/// Visibility is determined by checking whether the view's global frame intersects the screen bounds.
///
/// Example usage:
/// ```swift
/// YourView()
///     .onBecomingVisible {
///         // Resume tasks or trigger animations
///     }
/// ```
///
/// - Note: The action is triggered **each time** the view becomes visible.
/// If the view disappears and becomes visible again, the action will be re-triggered.
///
/// - SeeAlso: ``View/onBecomingVisible(perform:)``
public struct BecomingVisible: ViewModifier {
    
    // MARK: - Properties

    /// The action to perform when the view becomes visible.
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
                        guard isVisible, let action else { return }
                        action()
                    }
            }
        }
    }
}

// MARK: - PreferenceKey

extension BecomingVisible {
    
    /// A preference key used to track the visibility state of the view.
    private struct VisibleKey: PreferenceKey {
        
        static var defaultValue: Bool = false
        
        static func reduce(value: inout Bool, nextValue: () -> Bool) { /* Default Implementation */ }
    }
}

// MARK: - View Extension

extension View {
    
    /// Adds an action to perform every time the view becomes fully visible on screen.
    ///
    /// This is a convenience method for applying `BecomingVisible`.
    ///
    /// - Parameter action: A closure to perform when the view becomes visible within the screen bounds.
    /// - Returns: A modified view that triggers the action whenever it becomes visible.
    ///
    /// - SeeAlso: `BecomingVisible`
    public func onBecomingVisible(perform action: @escaping () -> Void) -> some View {
        modifier(BecomingVisible(action: action))
    }
}
