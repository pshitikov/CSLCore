import SwiftUI

/// A model representing a button in an alert, conforming to the `Identifiable` protocol.
///
/// The ``AlertButton`` struct is used to define the title, role, and action for a button in an alert.
/// Each button is uniquely identifiable, making it suitable for use in collections like `ForEach`.
///
/// Usage:
/// ```swift
/// let button = AlertButton(
///     title: "OK",
///     role: .cancel,
///     action: { print("Button tapped") }
/// )
/// ```
///
/// - Note: The `action` closure is optional and defaults to `nil`. Use this for buttons that do not require an action.
public struct AlertButton: Identifiable {
    
    // MARK: - Identifiable
    
    /// A unique identifier for the button.
    public let id = UUID()
    
    // MARK: - Properties
    
    /// The localized title of the button, displayed in the alert.
    public let title: LocalizedStringKey
    
    /// The role of the button, which can affect its appearance and behavior.
    ///
    /// - Note: Common roles include `.destructive`, `.cancel`, or `nil` for default styling.
    public let role: ButtonRole?
    
    /// The action to perform when the button is tapped.
    ///
    /// - Note: This closure is optional and will be `nil` if no action is provided.
    public let action: (() -> Void)?
    
    // MARK: - Initialization
    
    /// Creates a new instance of `AlertButton`.
    ///
    /// - Parameters:
    ///   - title: The localized title of the button.
    ///   - role: The role of the button, such as `.destructive`, `.cancel`, or `nil` for default styling. Defaults to `nil`.
    ///   - action: An optional closure to execute when the button is tapped. Defaults to `nil`.
    public init(
        title: LocalizedStringKey,
        role: ButtonRole? = nil,
        action: (() -> Void)? = nil
    ) {
        self.title = title
        self.role = role
        self.action = action
    }
}
