import Foundation

// MARK: - Properties

extension Decimal {
    
    /// A computed property that converts the `Decimal` value to a `Double`.
    ///
    /// This property leverages `NSDecimalNumber` to perform the conversion from `Decimal` to `Double`.
    ///
    /// - Returns: A `Double` value representing the `Decimal` number.
    ///
    /// - Example:
    /// ```swift
    /// let decimalValue: Decimal = 10.5
    /// let doubleValue: Double = decimalValue.doubleValue
    /// print(doubleValue)  // Output: 10.5
    /// ```
    public var doubleValue: Double { NSDecimalNumber(decimal: self).doubleValue }
}

// MARK: - Functions

extension Decimal {
    
    /// Formats the `Decimal` value as a string according to the specified number formatter style.
    ///
    /// This method uses `NumberFormatter` to format the `Decimal` value as a string. The default formatting style is `.currency`,
    /// but other styles like `.decimal`, `.percent` can also be used. When the style is `.currency`, the formatter applies
    /// the correct currency code, which defaults to the current locale's currency.
    ///
    /// - Parameters:
    ///   - style: The style of the number formatter (default is `.currency`). It can be `.decimal`, `.percent`, or `.currency`.
    ///   - currencyCode: The currency code to use when the style is `.currency` (default is the current locale's currency).
    ///   - minimumFractionDigits: The minimum number of fraction digits to display (default is `0`).
    ///   - maximumFractionDigits: The maximum number of fraction digits to display (default is `2`).
    ///
    /// - Returns: A `String` representing the formatted `Decimal` value according to the specified style.
    ///
    /// - Example:
    /// ```swift
    /// let amount: Decimal = 1234.567
    /// let formattedAmount = amount.formatValue(style: .currency)
    /// print(formattedAmount)  // Output: "$1,234.57" (depending on locale)
    ///
    /// let formattedDecimal = amount.formatValue(style: .decimal, minimumFractionDigits: 1, maximumFractionDigits: 3)
    /// print(formattedDecimal)  // Output: "1,234.567"
    /// ```
    public func formatValue(
        style: NumberFormatter.Style = .currency,
        currencyCode: Locale.Currency? = Locale.current.currency,
        minimumFractionDigits: Int = 0,
        maximumFractionDigits: Int = 2
    ) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = style
        formatter.usesGroupingSeparator = true
        formatter.minimumFractionDigits = minimumFractionDigits
        formatter.maximumFractionDigits = maximumFractionDigits
        
        if style == .currency {
            let currencyCode = currencyCode?.identifier ?? Locale.Currency.unknown.identifier
            formatter.currencyCode = currencyCode
        }
        
        return formatter.string(from: doubleValue as NSNumber) ?? ""
    }
}
