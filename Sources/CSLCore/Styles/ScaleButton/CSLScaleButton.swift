import SwiftUI

/// A button style that provides a scaling animation effect when the button is pressed.
public struct CSLScaleButtonStyle: ButtonStyle {
    
    // MARK: - Enums
    
    /// A private enumeration containing constants for the scaling animation.
    private enum Values {
        
        /// The scale factor applied to the button when pressed.
        static let scale: CGFloat = 0.95
        
        /// The duration of the scaling animation in seconds.
        static let animationDuration = 0.25
    }
    
    // MARK: - Initialization
    
    public init() { /* Default implementation */ }
    
    // MARK: - ButtonStyle
    
    /// Creates a view that represents the body of a button.
    ///
    /// - Parameter configuration: The properties of the button, including its label and its pressed state.
    /// - Returns: A view representing the button's appearance and behavior.
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? Values.scale : 1)
            .animation(.easeInOut(duration: Values.animationDuration), value: UUID())
    }
}
