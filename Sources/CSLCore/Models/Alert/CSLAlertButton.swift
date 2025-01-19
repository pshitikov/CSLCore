import SwiftUI

/// A model representing a button within an alert, conforming to the `Identifiable` protocol.
///
/// The ``CSLAlertButton`` struct defines the title, role, and action for a button used in an alert.
/// Each button has a unique identifier, making it suitable for use in dynamic collections like `ForEach`.
///
/// Usage:
/// ```swift
/// let confirmButton = CSLAlertButton(
///     title: "Confirm",
///     role: .destructive,
///     action: { print("Confirmed") }
/// )
///
/// let cancelButton = CSLAlertButton(
///     title: "Cancel",
///     role: .cancel
/// )
/// ```
///
/// - Note: The `action` property is optional and defaults to `nil`. Use it for buttons that do not require a specific action.
public struct CSLAlertButton: Identifiable {
    
    // MARK: - Identifiable
    
    /// A unique identifier for the button.
    public let id = UUID()
    
    // MARK: - Properties
    
    /// The localized title of the button, displayed in the alert.
    public let title: LocalizedStringKey
    
    /// The role of the button, which can affect its appearance and behavior.
    ///
    /// - Note: Common roles include `.destructive`, `.cancel`, or `nil` for a default button.
    public let role: ButtonRole?
    
    /// The action to perform when the button is tapped.
    ///
    /// - Note: This closure is optional and defaults to `nil` if no action is required.
    public let action: (() -> Void)?
    
    // MARK: - Initialization
    
    /// Creates a new instance of `CSLAlertButton`.
    ///
    /// - Parameters:
    ///   - title: The localized title of the button.
    ///   - role: The role of the button, such as `.destructive`, `.cancel`, or `nil` for a default role. Defaults to `nil`.
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
