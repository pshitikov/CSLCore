import SwiftUI

/// A view modifier that tracks and updates the height of a view dynamically.
///
/// The ``PresentationHeightModifier`` calculates the height of a view using a `GeometryReader` and updates
/// a binding with the measured height. This can be useful for dynamically adjusting UI layouts
/// based on the size of a specific view.
///
/// Usage:
/// ```swift
/// SomeView()
///     .modifier(PresentationHeightModifier(height: $height))
/// ```
///
/// Alternatively, use the convenience method `dynamicHeight(height:)` provided in the `View` extension.
///
/// - Note: The height is calculated and updated in real-time as the view's size changes.
public struct PresentationHeightModifier: ViewModifier {
    
    // MARK: - Properties
    
    /// A binding to the height value that will be updated by the modifier.
    @Binding
    private var height: CGFloat
    
    // MARK: - Initialization
    
    /// Initializes the modifier with a binding to the height value.
    ///
    /// - Parameter height: A binding to the height value that will be updated by the modifier.
    public init(height: Binding<CGFloat>) { self._height = height }
    
    // MARK: - Body
    
    /// Applies the height tracking logic to the content view.
    ///
    /// - Parameter content: The content to which the height tracking will be applied.
    /// - Returns: A view with the height tracking applied.
    public func body(content: Content) -> some View {
        content
            .overlay { geometryReader }
            .onPreferenceChange(Key.self) { newHeight in height = newHeight }
    }
    
    // MARK: - Views
    
    /// A `GeometryReader` that calculates the height of the view and updates the binding.
    ///
    /// This is used in the `body` to calculate the height of the view and pass it
    /// through a preference key for tracking.
    private var geometryReader: some View {
        GeometryReader { geometry in
            Color.clear.preference(key: Key.self, value: geometry.size.height)
        }
    }
}

// MARK: - View Extension

extension View {
    
    /// Adds dynamic height tracking to a view.
    ///
    /// This method uses the `PresentationHeightModifier` to calculate the height of a view
    /// and bind it to the provided height value.
    ///
    /// - Parameter height: A binding to the height value that will be updated dynamically.
    /// - Returns: A view with dynamic height tracking applied.
    public func dynamicHeight(height: Binding<CGFloat>) -> some View {
        modifier(PresentationHeightModifier(height: height))
    }
}
