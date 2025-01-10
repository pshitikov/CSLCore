import SwiftUI

/// A view modifier that applies an opacity transition with a customizable insertion delay.
///
/// The ``OpacityAnimationModifier`` provides an asymmetric opacity transition effect to views.
/// You can specify a delay for the opacity animation when the view is inserted, making it
/// ideal for creating smooth appearance effects.
///
/// Usage:
/// ```swift
/// SomeView()
///     .modifier(OpacityAnimationModifier(insertionDelay: 0.2))
/// ```
///
/// Alternatively, use the `withOpacityAnimation(insertionDelay:)` method provided in the `View` extension.
public struct OpacityAnimationModifier: ViewModifier {
    
    // MARK: - Properties
    
    /// The delay before the opacity transition is applied during the view's insertion.
    private var insertionDelay: TimeInterval
    
    // MARK: - Initialization
    
    /// Initializes the modifier with the specified insertion delay.
    ///
    /// - Parameter insertionDelay: The delay before the opacity transition begins, in seconds.
    public init(insertionDelay: TimeInterval) {
        self.insertionDelay = insertionDelay
    }
    
    // MARK: - Body
    
    /// Applies the opacity transition to the content view.
    ///
    /// This method adds an asymmetric transition to the view, applying an opacity animation
    /// during insertion and a simple opacity removal during removal.
    ///
    /// - Parameter content: The content to which the opacity transition will be applied.
    /// - Returns: A view with the opacity transition applied.
    public func body(content: Content) -> some View {
        content
            .transition(
                .asymmetric(
                    insertion: .opacity.animation(.default.delay(insertionDelay)),
                    removal: .opacity
                )
            )
    }
}

// MARK: - View Extension

extension View {
    
    /// Adds an opacity animation to a view with a customizable delay for insertion.
    ///
    /// This method applies the ``OpacityAnimationModifier`` to the view, creating a smooth opacity transition effect.
    /// You can specify an optional delay for the animation when the view is inserted.
    ///
    /// - Parameter insertionDelay: The delay before the opacity animation starts during the view's insertion.
    ///   The default value is `0.1` seconds.
    /// - Returns: A view with the opacity animation applied.
    ///
    /// - Example:
    /// ```swift
    /// Text("Hello, World!")
    ///     .withOpacityAnimation(insertionDelay: 0.2)
    /// ```
    ///
    /// - Note: This is a declarative way to apply custom animation effects, leveraging SwiftUI's `View` modifiers.
    public func withOpacityAnimation(insertionDelay: TimeInterval = 0.1) -> some View {
        modifier(OpacityAnimationModifier(insertionDelay: insertionDelay))
    }
}
