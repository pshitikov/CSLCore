import SwiftUI

/// A configuration model for creating customizable alerts in SwiftUI.
///
/// The ``CSLAlertConfiguration`` struct defines the essential components of an alert,
/// including its title, an optional message, and a list of buttons.
///
/// Usage:
/// ```swift
/// let alertConfig = CSLAlertConfiguration(
///     title: "Warning",
///     message: "Are you sure you want to proceed?",
///     buttons: [
///         CSLAlertButton(title: "Confirm", role: .destructive, action: { print("Confirmed") }),
///         CSLAlertButton(title: "Cancel", role: .cancel)
///     ]
/// )
/// ```
///
/// - Note: The `message` and `buttons` properties are optional, allowing for flexible alert configurations.
public struct CSLAlertConfiguration {
    
    // MARK: - Properties
    
    /// The localized title of the alert, displayed prominently at the top.
    public let title: LocalizedStringKey
    
    /// An optional localized message providing additional details for the alert.
    public let message: LocalizedStringKey?
    
    /// A list of ``CSLAlertButton`` objects defining the actions available in the alert.
    ///
    /// - Note: Defaults to an empty array if no buttons are specified, resulting in no actions.
    public let buttons: [CSLAlertButton]
    
    // MARK: - Initialization
    
    /// Creates a new instance of `CSLAlertConfiguration`.
    ///
    /// - Parameters:
    ///   - title: The localized title of the alert.
    ///   - message: An optional localized message providing additional details. Defaults to `nil`.
    ///   - buttons: An array of `CSLAlertButton` objects defining the actions available in the alert. Defaults to an empty array.
    public init(
        title: LocalizedStringKey,
        message: LocalizedStringKey? = nil,
        buttons: [CSLAlertButton] = []
    ) {
        self.title = title
        self.message = message
        self.buttons = buttons
    }
}
