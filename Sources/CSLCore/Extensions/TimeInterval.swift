import Foundation

extension TimeInterval {
    
    /// Formats the `TimeInterval` into a human-readable string using the specified units.
    ///
    /// This method formats a time interval (in seconds) into a string representation, using the specified units
    /// such as days, hours, minutes, or seconds. The result is abbreviated (e.g., "1h" for one hour), and any
    /// units with a zero value are omitted from the output.
    ///
    /// - Parameter units: A set of `NSCalendar.Unit` values that specify which time units to include in the formatted string.
    ///   Examples include `.hour`, `.minute`, `.second`, `.day`, etc.
    /// - Returns: A formatted string representing the time interval using the specified units, or `nil` if the formatting fails.
    ///
    /// - Example:
    ///     ```swift
    ///     let timeInterval: TimeInterval = 3661 // 1 hour and 1 minute
    ///     let formattedTime = timeInterval.format(using: [.hour, .minute, .second])
    ///     // formattedTime is "1h 1m"
    ///     ```
    ///
    /// - Note: The `DateComponentsFormatter` is used for formatting, with a style of `.abbreviated` for short unit names.
    ///         The `zeroFormattingBehavior` is set to `.dropAll`, so units with a value of zero are not displayed.
    ///
    /// - Complexity: O(n) where `n` is the number of allowed units to format, as the method constructs a formatted string based on the given units.
    public func format(using units: NSCalendar.Unit) -> String? {
        let formatter = DateComponentsFormatter()
        
        formatter.allowedUnits = units
        formatter.unitsStyle = .abbreviated
        formatter.zeroFormattingBehavior = .dropAll
        
        return formatter.string(from: self)
    }
}
