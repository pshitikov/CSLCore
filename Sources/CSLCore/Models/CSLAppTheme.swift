import SwiftUI

/// Represents the application's theme settings.
///
/// The `CSLAppTheme` enum defines three possible theme options: `light`, `dark`, and `system`.
/// It provides properties for localized titles, user interface styles, and corresponding color schemes, making it easy to integrate theme customization in a SwiftUI application.
public enum CSLAppTheme: String, CaseIterable, Hashable {
    
    // MARK: - Cases
    
    /// The light theme.
    case light
    
    /// The dark theme.
    case dark
    
    /// The system theme (adapts to the device's settings).
    case system
    
    // MARK: - Properties
    
    /// The localized title of the theme.
    ///
    /// This property provides a `LocalizedStringKey` representing the theme's name, which can be used directly in SwiftUI views.
    public var title: LocalizedStringKey {
        switch self {
        case .light: LocalizedStringKey("app_theme_light_title")
        case .dark: LocalizedStringKey("app_theme_dark_title")
        case .system: LocalizedStringKey("app_theme_system_title")
        }
    }
    
    /// The user interface style associated with the theme.
    ///
    /// This property provides the corresponding `UIUserInterfaceStyle` for the theme.
    public var userInterfaceStyle: UIUserInterfaceStyle {
        switch self {
        case .light: .light
        case .dark: .dark
        case .system: .unspecified
        }
    }
    
    /// The SwiftUI color scheme associated with the theme.
    ///
    /// This property provides a `ColorScheme` value to be used in SwiftUI views.
    public var colorScheme: ColorScheme? {
        switch self {
        case .light: .light
        case .dark: .dark
        case .system: nil
        }
    }
}
