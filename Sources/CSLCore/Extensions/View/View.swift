import SwiftUI

extension View {
    
    /// Hides the keyboard when called.
    ///
    /// This method sends a resignation action to the first responder, causing the keyboard to be dismissed.
    ///
    /// - Example:
    ///     ```swift
    ///     Button("Hide Keyboard") {
    ///         someView.hideKeyboard()  // Hides the keyboard
    ///     }
    ///     ```
    ///
    /// - Note: This method works globally by calling `resignFirstResponder` on the current first responder.
    public func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
    
    /// Adds a custom overlay for a large navigation bar title with a trailing item.
    ///
    /// This method adds an overlay to the view that includes a custom large navigation bar title with a trailing item, which can be customized with the provided `trailing` closure.
    ///
    /// - Parameter trailing: A closure that returns a view to be displayed in the trailing position of the navigation bar.
    /// - Returns: A view with a large navigation bar title and trailing items.
    ///
    /// - Example:
    ///     ```swift
    ///     someView.navigationBarLargeTitleItems {
    ///         Button("Edit") {
    ///             // Action
    ///         }
    ///     }
    ///     ```
    ///
    /// - Note: This method uses `CoreNavigationBarLargeTitleItems` to apply the large title configuration, and ensures the overlay fits within the navigation context.
    @ViewBuilder
    public func navigationBarLargeTitleItems<Content>(
        trailing: @escaping () -> Content
    ) -> some View where Content: View {
        overlay(
            CSLNavigationBarLargeTitleItems(trailing: trailing)
                .frame(width: 0, height: 0)
        )
    }
    
    /// Applies a rounded corner with a border to the view.
    ///
    /// This method clips the view to a rounded shape with specified corner radius and corners to round,
    /// and overlays a border around the shape with a customizable color and width.
    ///
    /// - Parameters:
    ///     - lineWidth: The width of the border line. Default is `0.7`.
    ///     - borderColor: The color of the border. Default is `Color.systemGray5`.
    ///     - radius: The corner radius to apply to the view.
    ///     - corners: The specific corners to apply the rounded effect to. Default is `.allCorners`.
    /// - Returns: A view with a rounded border applied.
    ///
    /// - Example:
    ///     ```swift
    ///     someView.roundedCornerWithBorder(lineWidth: 2, borderColor: .blue, radius: 15)
    ///     ```
    ///
    /// - Note: This method uses `RoundedCorner` to clip and apply the border to the view.
    public func roundedCornerWithBorder(
        lineWidth: CGFloat = 0.7,
        borderColor: Color = Color.systemGray5,
        radius: CGFloat,
        corners: UIRectCorner = .allCorners
    ) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
            .overlay(
                RoundedCorner(radius: radius, corners: corners)
                    .stroke(borderColor, lineWidth: lineWidth)
            )
    }
    
    /// Applies the given transform if the given condition evaluates to `true`.
    ///
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder
    public func `if`<Content: View>(_ condition: @autoclosure () -> Bool, transform: (Self) -> Content) -> some View {
        if condition() {
            transform(self)
        } else {
            self
        }
    }
    
    public func frame(side: CGFloat) -> some View { frame(width: side, height: side) }
}
