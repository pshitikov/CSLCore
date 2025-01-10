import SwiftUI

extension UIApplication {
    
    /// An object designed for convenient operation with the values of the application version.
    ///
    /// Implements the `RawRepresentable` and `Comparable` protocols.
    /// This struct is used to represent a version number as a string, allowing comparisons between versions.
    public struct Version: RawRepresentable, Comparable {
        
        // MARK: - Properties
        
        /// The raw value to use for the new instance.
        ///
        /// The `rawValue` is a string that represents the version of the application,
        /// consisting of numeric values separated by dots, such as "8", "8.2", "8.2.19", etc.
        public private(set) var rawValue: String
        
        // MARK: - Initialization
        
        /// Creates a new instance with the specified raw value.
        ///
        /// The `rawValue` is a string that must represent a version number consisting of major, minor, and patch components.
        ///
        /// - Parameter rawValue: The raw value to use for the new instance.
        /// - Throws: `VersionError.invalidVersion` if the `rawValue` is empty or invalid.
        public init?(rawValue: String) {
            guard !rawValue.isEmpty, rawValue.split(separator: ".").allSatisfy({ Int($0) != nil }) else {
                return nil
            }
            
            self.rawValue = rawValue
        }
        
        // MARK: - Comparable
        
        /// Returns a Boolean value indicating whether the value of the first
        /// argument is less than that of the second argument.
        ///
        /// This function is the only requirement of the `Comparable` protocol. The
        /// remainder of the relational operator functions are implemented by the
        /// standard library for any type that conforms to `Comparable`.
        ///
        /// The comparison is done by splitting the version strings into components,
        /// and comparing each component numerically.
        ///
        /// - Parameters:
        ///   - lhs: A `Version` value to compare.
        ///   - rhs: Another `Version` value to compare.
        /// - Returns: `true` if the first version is considered less than the second version.
        public static func < (lhs: Self, rhs: Self) -> Bool {
            // Split version strings into components and safely convert to integers
            let lhsComponents = lhs.rawValue
                .split(separator: ".")
                .compactMap { Int($0) }
            
            let rhsComponents = rhs.rawValue
                .split(separator: ".")
                .compactMap { Int($0) }
            
            // Compare components lexicographically or by length if necessary
            let minLength = min(lhsComponents.count, rhsComponents.count)
            
            for index in 0..<minLength {
                if lhsComponents[index] < rhsComponents[index] {
                    return true
                } else if lhsComponents[index] > rhsComponents[index] {
                    return false
                }
            }
            
            // If the versions are identical in the first N components, the shorter version is considered less
            return lhsComponents.count < rhsComponents.count
        }
    }
}
