import SwiftUI

extension CSLCustomButtonStyle {
    
    // MARK: - Public Static Properties
    
    /// A primary button style with an accent-colored background and white text.
    ///
    /// - Background: Accent color (`Color.accentColor`).
    /// - Title Color: White (`Color.white`).
    public static let primary = Self(
        background: .color(Color.accentColor),
        titleColor: Color.white
    )
    
    /// A button style with a black background and text color matching the system background.
    ///
    /// - Background: Black (`Color.label`).
    /// - Title Color: System background color (`Color.systemBackground`).
    public static let black = Self(
        background: .color(Color.label),
        titleColor: Color.systemBackground
    )
    
    /// A gray button style with a muted appearance for inactive states.
    ///
    /// - Background: Light gray fill (`Color.quaternarySystemFill`).
    /// - Title Color: Same as background (`Color.quaternarySystemFill`).
    public static let gray = Self(
        background: .color(Color.quaternarySystemFill),
        titleColor: Color.quaternarySystemFill
    )
    
    /// A deselected button style for list items with no background and gray text.
    ///
    /// - Background: Clear (`Color.clear`).
    /// - Title Color: System gray (`Color.systemGray`).
    public static let deselectedButtonList = Self(
        background: .color(Color.clear),
        titleColor: Color.systemGray
    )
    
    /// A selected button style for list items with a secondary system group background, label text color, and a subtle shadow.
    ///
    /// - Background: Secondary system grouped background (`Color.secondarySystemGroupedBackground`).
    /// - Title Color: Label color (`Color.label`).
    /// - Shadow:
    ///   - Color: Label color (`Color.label`).
    ///   - Opacity: `0.1`.
    public static let selectedButtonList = Self(
        background: .color(Color.secondarySystemGroupedBackground),
        titleColor: Color.label,
        shadowColor: Color.label,
        shadowOpacity: 0.1
    )
}
