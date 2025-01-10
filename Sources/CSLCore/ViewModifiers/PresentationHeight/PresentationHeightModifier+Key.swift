import SwiftUI

public extension PresentationHeightModifier {
    
    /// A `PreferenceKey` used by the `PresentationHeightModifier` to pass height information up the view hierarchy.
    ///
    /// This key is used to retrieve and propagate the height value calculated by the `GeometryReader` inside the `PresentationHeightModifier`.
    struct Key: @preconcurrency PreferenceKey {
        
        // MARK: - Properties
        
        /// The default value of the height, which is `0` initially.
        @MainActor public static var defaultValue: CGFloat = 0
        
        // MARK: - Static functions
        
        /// Combines the height values from multiple `PreferenceKey` updates.
        ///
        /// This function ensures that the latest height value is stored by reducing the current value with the next value.
        ///
        /// - Parameters:
        ///   - value: The accumulated height value.
        ///   - nextValue: A closure that returns the next height value to combine.
        public static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) { value = nextValue() }
    }
}
