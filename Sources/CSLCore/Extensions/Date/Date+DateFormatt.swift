import UIKit

extension Date {
    
    /// A custom struct that defines various date formats used throughout the application.
    public struct DateFormat: RawRepresentable {
        
        // MARK: - Properties
        
        public private(set) var rawValue: String
        public private(set) var additionalString = ""
        public private(set) var decodingTimeZone: TimeZone?
        public private(set) var encodingTimeZone: TimeZone?
        
        // MARK: - Initiazation
        
        /// Initialize a `DateFormat` with a raw format string.
        public init(rawValue: String) { self.rawValue = rawValue }
        
        /// Initialize a `DateFormat` with an optional additional string, and optional time zones for decoding and encoding.
        public init(
            rawValue: String,
            additionalString: String = "",
            decodingTimeZone: TimeZone? = nil,
            encodingTimeZone: TimeZone? = nil
        ) {
            self.rawValue = rawValue
            self.additionalString = additionalString
            self.decodingTimeZone = decodingTimeZone
            self.encodingTimeZone = encodingTimeZone
        }
        
        // MARK: - Static properties
        
        public static let HHmm = Self(rawValue: "HH:mm")
        public static let weekday = Self(rawValue: "EEEE")
        public static let month = Self(rawValue: "LLLL")
        public static let monthShort = Self(rawValue: "LLL")
        public static let monthYear = Self(rawValue: "LLLL yyyy")
        public static let year = Self(rawValue: "yyyy")
        
        public static let yyyyMMdd = Self(rawValue: "yyyy-MM-dd")
        public static let ISO8601 = Self(rawValue: "yyyy-MM-dd'T'HH:mm:ssZ")
        public static let oldISO8601 = Self(rawValue: "yyyy-MM-dd'T'HH:mm:ss.SSSXXX")
        
        public static let ddMM = Self(rawValue: "dd.MM")
        public static let ddMMMM = Self(rawValue: "dd MMMM")
        public static let ddMMMMEEEE = Self(rawValue: "dd MMMM, EEEE")
        public static let ddMMyyyy = Self(rawValue: "dd.MM.yyyy")
        public static let ddMMyyyySlash = Self(rawValue: "dd/MM/yyyy")
        public static let ddMMyyyyHHmm = Self(rawValue: "dd.MM.yyyy HH:mm")
        public static let ddMMyyyyTime = Self(rawValue: "dd.MM.yyyy HH:mm:ss")
        public static let ddMMMMyyyy = Self(rawValue: "dd MMMM yyyy", additionalString: " г.")
    }
}
