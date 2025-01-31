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
        static let maxAppThemeViewWidth: CGFloat = 500
        
        static let imageSize: CGSize = .init(width: 100, height: 220)
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
    @State
    private var currentAppTheme: CSLAppTheme
    
    /// Closure called when a theme is selected.
    private let didSelectAppTheme: ((CSLAppTheme) -> Void)?
    
    /// Initializes the `CoreAppThemeScreen` view.
    /// - Parameters:
    ///   - lightImage: The image for the light theme.
    ///   - darkImage: The image for the dark theme.
    ///   - systemImage: The image for the system default theme.
    ///   - currentAppTheme: The currently selected theme.
    ///   - didSelectAppTheme: A closure called when a theme is selected.
    public init(
        lightImage: Image,
        darkImage: Image,
        systemImage: Image,
        currentAppTheme: CSLAppTheme,
        didSelectAppTheme: ((CSLAppTheme) -> Void)?
    ) {
        self.lightImage = lightImage
        self.darkImage = darkImage
        self.systemImage = systemImage
        _currentAppTheme = State(initialValue: currentAppTheme)
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
                ForEach(CSLAppTheme.allCases.indices, id: \.self) { index in
                    themeView(for: CSLAppTheme.allCases[index])
                    
                    if index < CSLAppTheme.allCases.count - 1 { Spacer() }
                }
            }
        }
        .frame(maxWidth: Values.maxAppThemeViewWidth)
    }
    
    /// A view for an individual theme option.
    /// - Parameter theme: The theme to display.
    @ViewBuilder
    private func themeView(for theme: CSLAppTheme) -> some View {
        VStack(spacing: CSLConstants.verticalPadding) {
            Group {
                switch theme {
                case .light: lightImage.resizable()
                case .dark: darkImage.resizable()
                case .system: systemImage.resizable()
                }
            }
            .aspectRatio(contentMode: .fill)
            .frame(width: Values.imageSize.width, height: Values.imageSize.height)
            .roundedCornerWithBorder(radius: CSLConstants.cornerRadius)
            
            Text(theme.title, bundle: .module)
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
            currentAppTheme = theme
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
