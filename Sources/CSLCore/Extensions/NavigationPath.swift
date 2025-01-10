import SwiftUI

extension NavigationPath {
    
    /// Pops all elements from the navigation path, effectively returning to the root view.
    ///
    /// This method removes all elements from the `NavigationPath`, resetting the navigation stack
    /// and navigating back to the root view.
    ///
    /// - Example:
    ///     ```swift
    ///     @State private var navigationPath = NavigationPath()
    ///
    ///     var body: some View {
    ///         NavigationStack(path: $navigationPath) {
    ///             VStack {
    ///                 NavigationLink("Go to Detail View", value: "Detail")
    ///                 Button("Pop to Root") {
    ///                     navigationPath.popToRoot()  // Pops back to root
    ///                 }
    ///             }
    ///         }
    ///     }
    ///     ```
    ///
    /// - Note: This method is mutating and modifies the state of the `NavigationPath`.
    public mutating func popToRoot() { removeLast(count) }
}
