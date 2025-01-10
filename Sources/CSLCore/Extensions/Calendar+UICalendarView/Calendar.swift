import UIKit

extension Calendar {
    
    /// A Gregorian calendar with the current locale.
    ///
    /// This static property returns a Gregorian calendar instance, initialized with the current locale of the device.
    /// It allows developers to work with a calendar that adapts to the user's locale.
    ///
    /// - Returns: A `Calendar` instance with the Gregorian identifier and current locale.
    public static var gregorian: Calendar {
        var calendar = Calendar(identifier: .gregorian)
        
        calendar.locale = Locale.current
        
        return calendar
    }
    
    /// The short names for the weekend days.
    ///
    /// This computed property returns an array containing the short weekday names for the weekend days
    /// (last and first) in the current locale. It provides an easy way to access weekend day symbols.
    ///
    /// - Returns: An array of strings containing the names of the weekend days.
    public var shortRestDays: [String] {
        let symbols = shortWeekdaySymbols
        
        return [symbols.last, symbols.first].compactMap { $0 }
    }
}
