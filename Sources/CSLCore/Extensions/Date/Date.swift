import Foundation

/// A collection of date-related utilities, including formatting and comparisons.
extension Date {
    
    /// A shared static `DateFormatter` instance for reusability.
    public static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        
        formatter.locale = Locale.current
        
        return formatter
    }()
    
    // MARK: - Initializers
    
    /// Initializes a `Date` from a string using a given format.
    /// - Parameters:
    ///   - string: The date string to parse.
    ///   - format: The date format used for parsing the string.
    public init?(string: String, format: DateFormat) {
        self.init(string: string, format: format.rawValue, timezone: format.decodingTimeZone)
    }
    
    /// Initializes a `Date` from a string using a custom date format and an optional timezone.
    /// - Parameters:
    ///   - string: The date string to parse.
    ///   - format: The custom date format.
    ///   - timezone: An optional timezone for decoding the string.
    public init?(string: String, format: String, timezone: TimeZone? = nil) {
        let formatter = Date.formatter
        formatter.timeZone = timezone
        formatter.dateFormat = format
        
        guard let value = formatter.date(from: string) else { return nil }
        self = value
    }
    
    /// Initializes a `Date` with a specific year, month, and day.
    /// - Parameters:
    ///   - year: The year component.
    ///   - month: The month component.
    ///   - day: The day component.
    public init(year: Int, month: Int, day: Int) {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        
        guard let value = Calendar.gregorian.date(from: dateComponents) else {
            self = Date()
            
            return
        }
        
        self = value
    }
    
    // MARK: - String Conversion
    
    /// Converts the current date to a string using a given format.
    /// - Parameters:
    ///   - format: The `DateFormat` that determines how the date is formatted.
    /// - Returns: A formatted string representing the date.
    public func string(as format: DateFormat) -> String {
        string(as: format.rawValue, timezone: format.encodingTimeZone) + format.additionalString
    }
    
    /// Converts the current date to a string using a custom format.
    /// - Parameters:
    ///   - format: The custom date format.
    ///   - timezone: An optional timezone for encoding the string.
    /// - Returns: A formatted string representing the date.
    public func string(as format: String, timezone: TimeZone? = nil) -> String {
        let formatter = Date.formatter
        formatter.timeZone = timezone
        formatter.dateFormat = format
        
        return formatter.string(from: self)
    }
    
    // MARK: - Date Comparisons
    
    /// Checks if the current date is between two other dates.
    /// - Parameters:
    ///   - date1: The first date to compare.
    ///   - date2: The second date to compare.
    /// - Returns: A boolean indicating whether the current date is between the two provided dates.
    public func isBetween(_ date1: Date, _ date2: Date) -> Bool { (min(date1, date2)...max(date1, date2)) ~= self }
    
    /// Adds a specified amount of time to the current date.
    /// - Parameters:
    ///   - years: The number of years to add.
    ///   - months: The number of months to add.
    ///   - days: The number of days to add.
    ///   - minutes: The number of minutes to add.
    /// - Returns: A new date with the added time.
    public func adding(years: Int = 0, months: Int = 0, days: Int = 0, minutes: Int = 0) -> Date {
        var dateComponent = DateComponents()
        
        if years != 0 { dateComponent.year = years }
        if months != 0 { dateComponent.month = months }
        if days != 0 { dateComponent.day = days }
        if minutes != 0 { dateComponent.minute = minutes }
        
        guard let newDate = Calendar.gregorian.date(byAdding: dateComponent, to: self) else { return self }
        
        return newDate
    }
    
    /// Returns the components of the current date between the given `end` date.
    /// - Parameters:
    ///   - components: The calendar components to extract.
    ///   - end: The end date for the comparison.
    /// - Returns: A `DateComponents` object containing the extracted components.
    public func components(_ components: Set<Calendar.Component>, before end: Date) -> DateComponents {
        Calendar.gregorian.dateComponents(components, from: self, to: end)
    }
    
    // MARK: - Date Properties
    
    /// Returns a string representing the current date in history format (e.g., "Today", "Yesterday").
    public var stringInHistory: String {
        if isToday {
            return "Сегодня"
        } else if isYesterday {
            return "Вчера"
        } else if isThisYear {
            return string(as: .ddMMMMEEEE)
        } else {
            return string(as: .ddMMMMyyyy)
        }
    }
    
    /// A boolean indicating whether the current date is today.
    public var isToday: Bool { Calendar.gregorian.isDateInToday(self) }
    
    /// A boolean indicating whether the current date is yesterday.
    public var isYesterday: Bool { Calendar.gregorian.isDateInYesterday(self) }
    
    /// A boolean indicating whether the current date is tomorrow.
    public var isTomorrow: Bool { Calendar.gregorian.isDateInTomorrow(self) }
    
    /// A boolean indicating whether the current date is in the current year.
    public var isThisYear: Bool { year == Date().year }
    
    /// Returns the start of the day for the current date.
    public var startOfTheDay: Date { Calendar.gregorian.startOfDay(for: self) }
    
    /// Returns the start of the month for the current date.
    public var startOfTheMonth: Date? { Calendar.gregorian.dateInterval(of: .month, for: self)?.start }
    
    // MARK: - Date Components
    
    /// The hour component of the current date.
    public var hour: Int { Calendar.gregorian.component(.hour, from: self) }
    
    /// The day component of the current date.
    public var day: Int { Calendar.gregorian.component(.day, from: self) }
    
    /// The weekday component of the current date.
    public var weekday: Int { Calendar.gregorian.component(.weekday, from: self) }
    
    /// The month component of the current date.
    public var month: Int { Calendar.gregorian.component(.month, from: self) }
    
    /// The year component of the current date.
    public var year: Int { Calendar.gregorian.component(.year, from: self) }
    
    /// The number of days in the current month.
    public var daysInMonth: Int { Calendar.gregorian.range(of: .day, in: .month, for: self)?.count ?? 0 }
    
    /// The total number of days in the current month, adjusted for calendar layout.
    public var calendarDaysInMonth: Int {
        var daysInMonth = daysInMonth + calendarMonthPrefix
        let daysSuffix = daysInMonth % 7
        if daysSuffix != 0 {
            daysInMonth += 7 - daysSuffix
        }
        
        return daysInMonth
    }
    
    /// The number of days the current month starts with, used for calendar layout.
    public var calendarMonthPrefix: Int {
        let prefix = weekday - Calendar.gregorian.firstWeekday
        
        return prefix < 0 ? 7 + prefix : prefix
    }
}
