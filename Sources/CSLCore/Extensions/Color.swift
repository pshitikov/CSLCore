import SwiftUI

/// An extension to `Color` that provides a set of predefined colors for common UI elements,
/// leveraging the system-defined `UIColor` colors for consistent app styling across different iOS versions.
extension Color {
    
    // MARK: - Text Colors
    
    /// A color for light text.
    /// Corresponds to `UIColor.lightText` for text that appears on dark backgrounds.
    public static let lightText = Color(UIColor.lightText)
    
    /// A color for dark text.
    /// Corresponds to `UIColor.darkText` for text that appears on light backgrounds.
    public static let darkText = Color(UIColor.darkText)
    
    /// A color for placeholder text.
    /// Corresponds to `UIColor.placeholderText` for text that appears when a field is empty.
    public static let placeholderText = Color(UIColor.placeholderText)
    
    // MARK: - Label Colors
    
    /// A primary label color used for text in UI elements.
    /// Corresponds to `UIColor.label` and adapts to light and dark mode.
    public static let label = Color(UIColor.label)
    
    /// A secondary label color used for less emphasized text.
    /// Corresponds to `UIColor.secondaryLabel` and adapts to light and dark mode.
    public static let secondaryLabel = Color(UIColor.secondaryLabel)
    
    /// A tertiary label color used for even less emphasized text.
    /// Corresponds to `UIColor.tertiaryLabel` and adapts to light and dark mode.
    public static let tertiaryLabel = Color(UIColor.tertiaryLabel)
    
    /// A quaternary label color used for the least emphasized text.
    /// Corresponds to `UIColor.quaternaryLabel` and adapts to light and dark mode.
    public static let quaternaryLabel = Color(UIColor.quaternaryLabel)
    
    // MARK: - Background Colors
    
    /// A background color for the main system background.
    /// Corresponds to `UIColor.systemBackground` and adapts to light and dark mode.
    public static let systemBackground = Color(UIColor.systemBackground)
    
    /// A background color for secondary system elements.
    /// Corresponds to `UIColor.secondarySystemBackground` and adapts to light and dark mode.
    public static let secondarySystemBackground = Color(UIColor.secondarySystemBackground)
    
    /// A background color for tertiary system elements.
    /// Corresponds to `UIColor.tertiarySystemBackground` and adapts to light and dark mode.
    public static let tertiarySystemBackground = Color(UIColor.tertiarySystemBackground)
    
    // MARK: - Fill Colors
    
    /// A fill color for system elements.
    /// Corresponds to `UIColor.systemFill` and adapts to light and dark mode.
    public static let systemFill = Color(UIColor.systemFill)
    
    /// A secondary fill color for less emphasized elements.
    /// Corresponds to `UIColor.secondarySystemFill` and adapts to light and dark mode.
    public static let secondarySystemFill = Color(UIColor.secondarySystemFill)
    
    /// A tertiary fill color for even less emphasized elements.
    /// Corresponds to `UIColor.tertiarySystemFill` and adapts to light and dark mode.
    public static let tertiarySystemFill = Color(UIColor.tertiarySystemFill)
    
    /// A quaternary fill color for the least emphasized elements.
    /// Corresponds to `UIColor.quaternarySystemFill` and adapts to light and dark mode.
    public static let quaternarySystemFill = Color(UIColor.quaternarySystemFill)
    
    // MARK: - Grouped Background Colors
    
    /// A background color used for grouped content.
    /// Corresponds to `UIColor.systemGroupedBackground` and adapts to light and dark mode.
    public static let systemGroupedBackground = Color(UIColor.systemGroupedBackground)
    
    /// A background color used for secondary grouped content.
    /// Corresponds to `UIColor.secondarySystemGroupedBackground` and adapts to light and dark mode.
    public static let secondarySystemGroupedBackground = Color(UIColor.secondarySystemGroupedBackground)
    
    /// A background color used for tertiary grouped content.
    /// Corresponds to `UIColor.tertiarySystemGroupedBackground` and adapts to light and dark mode.
    public static let tertiarySystemGroupedBackground = Color(UIColor.tertiarySystemGroupedBackground)
    
    // MARK: - Gray Colors
    
    /// A system gray color for UI elements.
    /// Corresponds to `UIColor.systemGray` and adapts to light and dark mode.
    public static let systemGray = Color(UIColor.systemGray)
    
    /// A lighter shade of system gray.
    /// Corresponds to `UIColor.systemGray2` and adapts to light and dark mode.
    public static let systemGray2 = Color(UIColor.systemGray2)
    
    /// A darker shade of system gray.
    /// Corresponds to `UIColor.systemGray3` and adapts to light and dark mode.
    public static let systemGray3 = Color(UIColor.systemGray3)
    
    /// An even darker shade of system gray.
    /// Corresponds to `UIColor.systemGray4` and adapts to light and dark mode.
    public static let systemGray4 = Color(UIColor.systemGray4)
    
    /// A very dark shade of system gray.
    /// Corresponds to `UIColor.systemGray5` and adapts to light and dark mode.
    public static let systemGray5 = Color(UIColor.systemGray5)
    
    /// The darkest shade of system gray.
    /// Corresponds to `UIColor.systemGray6` and adapts to light and dark mode.
    public static let systemGray6 = Color(UIColor.systemGray6)
    
    // MARK: - Other Colors
    
    /// A color used for separator lines in the UI.
    /// Corresponds to `UIColor.separator` and adapts to light and dark mode.
    public static let separator = Color(UIColor.separator)
    
    /// A color used for opaque separator lines.
    /// Corresponds to `UIColor.opaqueSeparator` and adapts to light and dark mode.
    public static let opaqueSeparator = Color(UIColor.opaqueSeparator)
    
    /// A color for link elements, such as hyperlinks.
    /// Corresponds to `UIColor.link` and adapts to light and dark mode.
    public static let link = Color(UIColor.link)
    
    // MARK: - System Colors
    
    /// A system blue color used for buttons and links.
    /// Corresponds to `UIColor.systemBlue` and adapts to light and dark mode.
    public static let systemBlue = Color(UIColor.systemBlue)
    
    /// A system purple color used for buttons and interactive elements.
    /// Corresponds to `UIColor.systemPurple` and adapts to light and dark mode.
    public static let systemPurple = Color(UIColor.systemPurple)
    
    /// A system green color used for success indicators.
    /// Corresponds to `UIColor.systemGreen` and adapts to light and dark mode.
    public static let systemGreen = Color(UIColor.systemGreen)
    
    /// A system yellow color used for warnings and alerts.
    /// Corresponds to `UIColor.systemYellow` and adapts to light and dark mode.
    public static let systemYellow = Color(UIColor.systemYellow)
    
    /// A system orange color used for highlights or accents.
    /// Corresponds to `UIColor.systemOrange` and adapts to light and dark mode.
    public static let systemOrange = Color(UIColor.systemOrange)
    
    /// A system pink color used for highlights and interactive elements.
    /// Corresponds to `UIColor.systemPink` and adapts to light and dark mode.
    public static let systemPink = Color(UIColor.systemPink)
    
    /// A system red color used for errors and warnings.
    /// Corresponds to `UIColor.systemRed` and adapts to light and dark mode.
    public static let systemRed = Color(UIColor.systemRed)
    
    /// A system teal color used for highlights or accents.
    /// Corresponds to `UIColor.systemTeal` and adapts to light and dark mode.
    public static let systemTeal = Color(UIColor.systemTeal)
    
    /// A system indigo color used for accent elements.
    /// Corresponds to `UIColor.systemIndigo` and adapts to light and dark mode.
    public static let systemIndigo = Color(UIColor.systemIndigo)
    
    // MARK: - Custom Colors
    
    /// A custom color defined in the app's asset catalog for search bar elements.
    /// Corresponds to a color named "SystemSearchBar" in the asset catalog.
    public static let systemSearchBar = Color("SystemSearchBar")
}
