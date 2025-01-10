import UIKit

/// Enum that represents a period of time, either a single date or a range of dates.
///
/// This enum helps developers easily model and handle time periods in various formats.
public enum Period: Equatable {
    
    /// Represents a single date.
    case single(Date)
    
    /// Represents a range of dates.
    case range(Date, Date)
    
    /// Initializes a `Period` from a string.
    ///
    /// This initializer parses a string that can represent either a single date or a date range in the format `ddMMyyyy` or `ddMMyyyy-ddMMyyyy`.
    /// It is a flexible way to create periods from user input or external data.
    ///
    /// - Parameter string: A string representing a single date or a date range.
    /// - Returns: A `Period` instance, or `nil` if the string format is invalid.
    public init?(string: String?) {
        guard let string else { return nil }
        
        let components = string.components(separatedBy: "-")
        
        if components.count == 1,
           let date = Date(string: components[0], format: .ddMMyyyy) {
            self = .single(date)
        } else if components.count == 2,
                  let start = Date(string: components[0], format: .ddMMyyyy),
                  let end = Date(string: components[1], format: .ddMMyyyy) {
            self = .range(start, end)
        } else {
            return nil
        }
    }
    
    /// Compares two `Period` instances for equality.
    ///
    /// Two `Period` instances are considered equal if they represent the same date or range of dates.
    ///
    /// - Parameters:
    ///   - lhs: The left-hand side period.
    ///   - rhs: The right-hand side period.
    /// - Returns: A Boolean value indicating whether the two periods are equal.
    public static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case (.range(let lhsStart, let lhsEnd), .range(let rhsStart, let rhsEnd)):
            return lhsStart.startOfTheDay == rhsStart.startOfTheDay && lhsEnd.startOfTheDay == rhsEnd.startOfTheDay
        case (.single(let lhs), .single(let rhs)):
            return lhs.startOfTheDay == rhs.startOfTheDay
        case (_, _):
            return false
        }
    }
    
    /// Returns a human-readable string representation of the period.
    ///
    /// This computed property provides a localized and intuitive string representation of a time period.
    /// It formats the string based on whether the period is a single date or a range of dates.
    ///
    /// - Returns: A human-readable string representing the period.
    public var readableString: String {
        switch self {
        case .range(let start, let end) where start == end:
            return start.string(as: .ddMMMMyyyy)
        case .range(let start, let end):
            guard start.year == end.year,
                  start.isThisYear else {
                return "\(start.string(as: .ddMMyyyy)) - \(end.string(as: .ddMMyyyy))"
            }
            return "\(start.string(as: .ddMMMM)) - \(end.string(as: .ddMMMM))"
        case .single(let date):
            return date.string(as: .ddMMMMyyyy)
        }
    }
    
    /// The start date of the period.
    ///
    /// This property returns the start date for both single and range periods, making it easier to access the starting point of a time period.
    public var start: Date {
        switch self {
        case .range(let start, _): start
        case .single(let date): date
        }
    }
    
    /// The end date of the period.
    ///
    /// This property returns the end date for both single and range periods, making it easier to access the ending point of a time period.
    public var end: Date {
        switch self {
        case .range(_, let end): end
        case .single(let date): date
        }
    }
}
