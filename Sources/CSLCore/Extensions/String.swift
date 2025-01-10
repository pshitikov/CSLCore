import Foundation

extension String {
    
    /// Checks if the current string contains all words from another string, ignoring case.
    ///
    /// This method splits the `other` string into individual words (separated by spaces), converts them to lowercase,
    /// and checks if each word is found in the current string (also converted to lowercase).
    /// It returns `true` if all words in `other` are present in the current string; otherwise, it returns `false`.
    ///
    /// - Parameter other: The string containing words to search for in the current string.
    /// - Returns: `true` if the current string contains all words from `other`; `false` otherwise.
    ///
    /// - Example:
    ///     ```swift
    ///     let sentence = "Swift programming is awesome"
    ///     let searchString = "swift programming"
    ///     let contains = sentence.smartContains(searchString)
    ///     // contains is true because both "swift" and "programming" are found in the sentence.
    ///     ```
    ///
    /// - Note: The comparison is case-insensitive. Words are separated by spaces, and empty words are ignored.
    ///
    /// - Complexity: O(n * m) where `n` is the number of words in the `other` string, and `m` is the average length of each word in the `other` string.
    /// This is because for each word, the method performs a case-insensitive search in the current string, which takes linear time in the size of the string.
    public func smartContains(_ other: String) -> Bool {
        let array: [String] = other
            .lowercased()
            .components(separatedBy: " ")
            .filter { !$0.isEmpty }
        
        let result = array
            .allSatisfy { lowercased().range(of: $0) != nil }
        
        return result
    }
}
