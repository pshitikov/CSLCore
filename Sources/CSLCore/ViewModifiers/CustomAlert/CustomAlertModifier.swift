import SwiftUI

/// A custom `ViewModifier` that displays a customizable alert using provided alert data.
///
/// The ``CustomAlertModifier`` is used to present an alert with a title, message, and customizable buttons.
/// It works with a binding to `AlertData` that specifies the alert's content and manages its visibility.
///
/// - Note: The alert automatically dismisses when the binding is set to `nil`.
///
/// Usage:
/// ```swift
/// @State private var alertData: AlertData? = AlertData(
///     title: "Alert Title",
///     message: "This is the alert message.",
///     buttons: [AlertButton(title: "OK", action: { print("OK tapped") })]
/// )
///
/// YourView()
///     .modifier(CustomAlertModifier(data: $alertData))
/// ```
///
/// Alternatively, use the `customAlert` convenience method on any `View`.
public struct CustomAlertModifier: ViewModifier {
    
    // MARK: - Properties
    
    /// A binding to the alert data that controls the alert's content and visibility.
    @Binding
    private var data: AlertData?
    
    // MARK: - Initialization
    
    /// Creates a new instance of `CustomAlertModifier`.
    ///
    /// - Parameter data: A binding to optional `AlertData` that determines the alert's title, message, and buttons.
    public init(data: Binding<AlertData?>) { self._data = data }
    
    // MARK: - Body
    
    /// The body of the modifier that applies the alert to the content.
    ///
    /// - Parameter content: The content view to which the alert is applied.
    /// - Returns: A view with an alert overlay.
    public func body(content: Content) -> some View {
        content
            .alert(
                data?.title ?? "",
                isPresented: Binding<Bool>(
                    get: { data != nil },
                    set: { value in data = value ? data : nil }
                ),
                presenting: data
            ) { data in
                ForEach(data.buttons) { button in
                    Button(
                        role: button.role,
                        action: button.action ?? { }, // swiftlint:disable:this no_empty_block
                        label: { Text(button.title) }
                    )
                }
            } message: { data in
                if let message = data.message { Text(message) }
            }
    }
}

// MARK: - View Extension

extension View {
    
    /// Adds a customizable alert to the view using the provided alert data binding.
    ///
    /// The `customAlert` method is a convenience method to apply the ``CustomAlertModifier``.
    ///
    /// Usage:
    /// ```swift
    /// @State private var alertData: AlertData? = AlertData(
    ///     title: "Alert Title",
    ///     message: "This is the alert message.",
    ///     buttons: [AlertButton(title: "OK", action: { print("OK tapped") })]
    /// )
    ///
    /// YourView()
    ///     .customAlert(data: $alertData)
    /// ```
    ///
    /// - Parameter data: A binding to optional `AlertData` that determines the alert's title, message, and buttons.
    /// - Returns: A view with an alert overlay.
    public func customAlert(data: Binding<AlertData?>) -> some View { modifier(CustomAlertModifier(data: data)) }
}
