import SwiftUI

// MARK: - Initialization

extension EdgeInsets {
    
    /// Initializes `EdgeInsets` with equal padding for all sides.
    ///
    /// - Parameter side: The padding value to apply to the `top`, `leading`, `bottom`, and `trailing` edges.
    ///
    /// - Example:
    ///     ```swift
    ///     let insets = EdgeInsets(side: 10)
    ///     // insets.top, insets.leading, insets.bottom, insets.trailing are all 10
    ///     ```
    public init(side: CGFloat) {
        self.init(
            top: side,
            leading: side,
            bottom: side,
            trailing: side
        )
    }
    
    /// Initializes `EdgeInsets` with separate horizontal and vertical padding values.
    ///
    /// - Parameters:
    ///   - horizontal: The padding value to apply to the `leading` and `trailing` edges.
    ///   - vertical: The padding value to apply to the `top` and `bottom` edges.
    ///
    /// - Example:
    ///     ```swift
    ///     let insets = EdgeInsets(horizontal: 15, vertical: 10)
    ///     // insets.leading, insets.trailing are 15
    ///     // insets.top, insets.bottom are 10
    ///     ```
    public init(horizontal: CGFloat, vertical: CGFloat) {
        self.init(
            top: vertical,
            leading: horizontal,
            bottom: vertical,
            trailing: horizontal
        )
    }
}
