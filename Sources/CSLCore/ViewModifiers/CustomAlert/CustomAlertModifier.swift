import SwiftUI

/// A custom `ViewModifier` for presenting a configurable alert with a title, message, and action buttons.
///
/// Use `CustomAlertModifier` to display an alert using a binding to `CSLAlertConfiguration`,
/// which defines the alert's content and visibility. This modifier makes it simple to manage and customize
/// alerts in SwiftUI.
///
/// - Note: The alert is automatically dismissed when the binding is set to `nil`.
///
/// ### Example Usage
/// ```swift
/// @State private var alertConfiguration: CSLAlertConfiguration? = CSLAlertConfiguration(
///     title: "Alert Title",
///     message: "This is the alert message.",
///     buttons: [
///         CSLAlertButton(title: "OK", action: { print("OK tapped") })
///     ]
/// )
///
/// YourView()
///     .modifier(CustomAlertModifier(configuration: $alertConfiguration))
/// ```
///
/// Alternatively, use the `.customAlert` view extension for improved readability.
public struct CustomAlertModifier: ViewModifier {
    
    // MARK: - Properties
    
    /// A binding to the alert configuration that determines the content and visibility of the alert.
    @Binding
    private var configuration: CSLAlertConfiguration?
    
    // MARK: - Initialization
    
    /// Initializes the modifier with a binding to the alert configuration.
    ///
    /// - Parameter configuration: A binding to `CSLAlertConfiguration` that provides the alert's title, message, and buttons.
    public init(configuration: Binding<CSLAlertConfiguration?>) {
        self._configuration = configuration
    }
    
    // MARK: - Body
    
    /// Composes the content view with an alert overlay based on the provided configuration.
    ///
    /// - Parameter content: The base content view to which the alert is applied.
    /// - Returns: A modified view that presents an alert when the binding is non-`nil`.
    public func body(content: Content) -> some View {
        content
            .alert(
                configuration?.title ?? "",
                isPresented: Binding<Bool>(
                    get: { configuration != nil },
                    set: { value in configuration = value ? configuration : nil }
                ),
                presenting: configuration
            ) { configuration in
                ForEach(configuration.buttons) { button in
                    Button(
                        role: button.role,
                        action: button.action ?? { }, // swiftlint:disable:this no_empty_block
                        label: { Text(button.title) }
                    )
                }
            } message: { configuration in
                if let message = configuration.message {
                    Text(message)
                }
            }
    }
}

// MARK: - View Extension

extension View {
    
    /// Adds a configurable alert to the view using a binding to `CSLAlertConfiguration`.
    ///
    /// This extension provides a convenience method for applying the `CustomAlertModifier`,
    /// improving code readability and simplifying usage.
    ///
    /// ### Example Usage
    /// ```swift
    /// @State private var alertConfiguration: CSLAlertConfiguration? = CSLAlertConfiguration(
    ///     title: "Alert Title",
    ///     message: "This is the alert message.",
    ///     buttons: [
///         CSLAlertButton(title: "OK", action: { print("OK tapped") })
///     ]
/// )
///
/// YourView()
///     .customAlert(configuration: $alertConfiguration)
/// ```
    ///
    /// - Parameter configuration: A binding to `CSLAlertConfiguration` defining the alert's title, message, and buttons.
    /// - Returns: A view that displays the alert when the binding is non-`nil`.
    public func customAlert(configuration: Binding<CSLAlertConfiguration?>) -> some View {
        modifier(CustomAlertModifier(configuration: configuration))
    }
}
