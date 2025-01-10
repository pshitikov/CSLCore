import SwiftUI

/// A utility enum that holds constant values for layout and animation purposes throughout the application.
public enum CSLConstants {
    
    // MARK: - TimeInterval Constants
    
    /// The delay time before a progress view appears, used for animations or transitions.
    public static let progressViewInsertionDelay: TimeInterval = 2
    
    // MARK: - Layout Constants (Padding, Spacing, and Corner Radius)
    
    /// The top padding for lists in the application.
    public static let listTopPadding: CGFloat = 16
    
    /// The corner radius applied to most UI elements.
    public static let cornerRadius: CGFloat = 16
    
    /// A smaller corner radius, typically used for elements requiring less rounding.
    public static let smallCornerRadius: CGFloat = 8
    
    /// The standard horizontal padding applied to UI elements.
    public static let horizontalPadding: CGFloat = 20
    
    /// The standard horizontal spacing between UI elements.
    public static let horizontalSpacing: CGFloat = 12
    
    /// The standard vertical padding applied to UI elements.
    public static let verticalPadding: CGFloat = 16
    
    /// The standard vertical spacing between UI elements.
    public static let verticalSpacing: CGFloat = 8
}
