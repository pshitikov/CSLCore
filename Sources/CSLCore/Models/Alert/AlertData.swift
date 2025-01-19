import SwiftUI

/// A model representing the data for a customizable alert.
///
/// The ``AlertData`` struct encapsulates the title, optional message, and buttons
/// for creating a flexible and reusable alert structure in SwiftUI.
///
/// Usage:
/// ```swift
/// let alertData = AlertData(
///     title: "Alert Title",
///     message: "This is the alert message.",
///     buttons: [
///         AlertButton(title: "OK", action: { print("OK tapped") }),
///         AlertButton(title: "Cancel", role: .cancel)
///     ]
/// )
/// ```
///
/// - Note: The `message` and `buttons` are optional. You can create a simple alert with just a title.
public struct AlertData {
    
    // MARK: - Properties
    
    /// The localized title of the alert, displayed prominently at the top.
    public let title: LocalizedStringKey
    
    /// An optional localized message providing additional information in the alert.
    public let message: LocalizedStringKey?
    
    /// An array of ``AlertButton`` objects representing the actions available in the alert.
    ///
    /// - Note: Defaults to an empty array, resulting in no action buttons if none are provided.
    public let buttons: [AlertButton]
    
    // MARK: - Initialization
    
    /// Creates a new instance of `AlertData`.
    ///
    /// - Parameters:
    ///   - title: The localized title of the alert.
    ///   - message: An optional localized message for the alert. Defaults to `nil`.
    ///   - buttons: An array of `AlertButton` objects representing the alert's actions. Defaults to an empty array.
    public init(
        title: LocalizedStringKey,
        message: LocalizedStringKey? = nil,
        buttons: [AlertButton] = []
    ) {
        self.title = title
        self.message = message
        self.buttons = buttons
    }
}
