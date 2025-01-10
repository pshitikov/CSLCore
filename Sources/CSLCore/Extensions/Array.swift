import Foundation

extension Array where Element: Equatable {
    
    /// Removes the first occurrence of a specified element from the array.
    ///
    /// - Parameter element: The `Element` to be removed from the array.
    /// - Returns: The removed element if found, otherwise `nil`.
    ///
    /// - Example:
    ///     ```swift
    ///     var numbers = [1, 2, 3, 4]
    ///     let removedElement = numbers.remove(element: 3)
    ///     // numbers is now [1, 2, 4]
    ///     // removedElement is 3
    ///     ```
    ///
    /// - Note: The method uses `firstIndex(where:)` to locate the element and `remove(at:)` to perform the removal.
    @discardableResult
    public mutating func remove(element: Element) -> Element? {
        guard let removedIndex = firstIndex(where: { $0 == element }) else { return nil }
        
        return remove(at: removedIndex)
    }
    
    /// Adds an element to the array if it doesn't already exist, or replaces the first occurrence of the specified element.
    ///
    /// - Parameter element: The `Element` to add or replace in the array.
    ///
    /// - Example:
    ///     ```swift
    ///     var names = ["Alice", "Bob", "Charlie"]
    ///     names.put(element: "Bob")   // Replaces "Bob" with "Bob" (no net change)
    ///     names.put(element: "Eve")   // Appends "Eve"
    ///     // names is now ["Alice", "Bob", "Charlie", "Eve"]
    ///     ```
    ///
    /// - Note: The method uses `firstIndex(where:)` to check if the element exists, and either replaces the existing one or appends a new one.
    public mutating func put(element: Element) {
        if let replacedIndex = firstIndex(where: { $0 == element }) {
            self[replacedIndex] = element
        } else {
            append(element)
        }
    }
}
