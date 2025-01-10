import SwiftUI

/// A custom `Shape` that defines a rounded rectangle with configurable corner radius and specific corners to round.
public struct RoundedCorner: Shape {
    
    // MARK: - Properties
    
    /// The radius of the corners. Default is `.infinity` for fully rounded corners.
    public var radius: CGFloat = .infinity
    
    /// The specific corners to round. Default is `.allCorners` which rounds all corners.
    public var corners: UIRectCorner = .allCorners
    
    // MARK: - Public functions
    
    /// Creates a path for a rounded corner shape.
    ///
    /// This method generates a `Path` that defines a rounded rectangle with the specified corner radius and corners to round.
    ///
    /// - Parameter rect: The rectangle to apply the rounded corners to.
    /// - Returns: A `Path` representing the rounded corners.
    ///
    /// - Example:
    ///     ```swift
    ///     let roundedPath = RoundedCorner(radius: 10, corners: .topLeft).path(in: rect)
    ///     ```
    ///
    /// - Note: The method uses `UIBezierPath` to create the rounded path and returns it as a `Path` for SwiftUI compatibility.
    public func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        
        return Path(path.cgPath)
    }
}
