import SwiftUI
import SFSafeSymbols

/// A SwiftUI view that allows users to select an application theme (light, dark, or system).
public struct CSLAppThemeSheet: View {
    
    // MARK: - Constants
    
    private enum Values {
        
        /// Vertical spacing between elements.
        static let verticalSpacing: CGFloat = 20
        
        /// Size of the close button in the header.
        static let closeButtonSize: CGFloat = 30
        
        /// Size of the theme icon.
        static let iconSize: CGFloat = 30
        
        /// Localized title for the screen.
        static let screenTitle: LocalizedStringKey = "core_app_theme_screen_title"
        
        /// Max width of app theme view.
        static let maxAppThemeViewWidth: CGFloat = 380
    }
    
    // MARK: - Properties
    
    /// Dismiss action provided by the environment.
    @Environment(\.dismiss)
    private var dismiss
    
    /// The dynamic height of the screen.
    @State
    private var screenHeight: CGFloat = 0
    
    /// The image representing the light theme.
    private let lightImage: Image
    
    /// The image representing the dark theme.
    private let darkImage: Image
    
    /// The image representing the system default theme.
    private let systemImage: Image
    
    /// The currently selected theme.
    private let currentAppTheme: AppTheme
    
    /// Closure called when a theme is selected.
    private let didSelectAppTheme: ((AppTheme) -> Void)?
    
    /// Initializes the `CoreAppThemeScreen` view.
    /// - Parameters:
    ///   - lightImage: The image for the light theme.
    ///   - darkImage: The image for the dark theme.
    ///   - systemImage: The image for the system default theme.
    ///   - currentAppTheme: The currently selected theme.
    ///   - didSelectAppTheme: A closure called when a theme is selected.
    init(
        lightImage: Image,
        darkImage: Image,
        systemImage: Image,
        currentAppTheme: AppTheme,
        didSelectAppTheme: ((AppTheme) -> Void)?
    ) {
        self.lightImage = lightImage
        self.darkImage = darkImage
        self.systemImage = systemImage
        self.currentAppTheme = currentAppTheme
        self.didSelectAppTheme = didSelectAppTheme
    }
    
    // MARK: - Body
    
    public var body: some View {
        VStack(alignment: .leading, spacing: Values.verticalSpacing) {
            headerView
            appThemeView
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical)
        .padding(.horizontal, CSLConstants.horizontalPadding)
        .modifier(PresentationHeightModifier(height: $screenHeight))
        .interactiveDismissDisabled(false)
        .presentationBackgroundInteraction(.disabled)
        .presentationDragIndicator(.visible)
        .presentationDetents([.height(screenHeight)])
    }
}

// MARK: - Views

extension CSLAppThemeSheet {
    
    /// The header view containing the screen title and dismiss button.
    private var headerView: some View {
        HStack {
            Text(Values.screenTitle, bundle: .module)
                .font(.title2.bold())
                .multilineTextAlignment(.leading)
            
            Spacer()
            
            Button {
                dismiss()
            } label: {
                Image(systemName: SFSymbol.xmarkCircleFill.rawValue)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(Color.tertiaryLabel, .ultraThinMaterial)
                    .font(.system(size: Values.closeButtonSize))
            }
        }
    }
    
    /// The grid view displaying theme options.
    private var appThemeView: some View {
        Grid {
            GridRow {
                ForEach(AppTheme.allCases.indices, id: \.self) { index in
                    themeView(for: AppTheme.allCases[index])
                    
                    if index < AppTheme.allCases.count - 1 { Spacer() }
                }
            }
        }
        .frame(maxWidth: Values.maxAppThemeViewWidth)
    }
    
    /// A view for an individual theme option.
    /// - Parameter theme: The theme to display.
    @ViewBuilder
    private func themeView(for theme: AppTheme) -> some View {
        VStack(spacing: CSLConstants.verticalPadding) {
            Text(theme.title)
                .font(.callout)
            
            if currentAppTheme == theme {
                Image(systemName: SFSymbol.checkmarkCircleFill.rawValue)
                    .resizable()
                    .frame(width: Values.iconSize, height: Values.iconSize)
                    .foregroundStyle(Color.accentColor, Color.quaternarySystemFill)
            } else {
                Image(systemName: SFSymbol.circleFill.rawValue)
                    .resizable()
                    .frame(width: Values.iconSize, height: Values.iconSize)
                    .foregroundStyle(Color.quaternarySystemFill)
            }
        }
        .onTapGesture {
            didSelectAppTheme?(theme)
        }
    }
}

// MARK: - Previews

#Preview {
    CSLAppThemeSheet(
        lightImage: Image(systemName: "heart"),
        darkImage: Image(systemName: "heart"),
        systemImage: Image(systemName: "heart"),
        currentAppTheme: .dark,
        didSelectAppTheme: nil
    )
}
