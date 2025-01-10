import SwiftUI
import SFSafeSymbols

/// A SwiftUI view that provides a screen for notification settings.
public struct CSLNotificationSettingsSheet: View {
    
    // MARK: - Enums
    
    /// Contains constant values used within the view.
    private enum Values {
        
        /// Vertical spacing between elements in the screen.
        static let verticalSpacing: CGFloat = 12
        
        /// Size of the close button.
        static let closeButtonSize: CGFloat = 30
        
        /// Padding above the close button.
        static let closeButtonTopPadding: CGFloat = 20
        
        /// Maximum width of the displayed image.
        static let maxImageWidth: CGFloat = 500
        
        /// Maximum height of the displayed image.
        static let maxImageHeight: CGFloat = 290
        
        /// Title displayed at the top of the screen.
        static let screenTitle: LocalizedStringKey = "core_notification_settings_screen_title"
        
        /// Title for the button that directs the user to notification settings.
        static let buttonTitle: LocalizedStringKey = "core_notification_settings_screen_button_title"
        
        /// Description text explaining how to change notification settings.
        static let description: LocalizedStringKey = "core_notification_settings_screen_description"
    }
    
    // MARK: - Properties
    
    /// Environment property that allows the screen to be dismissed.
    @Environment(\.dismiss)
    private var dismiss
    
    /// State variable to track the screen height.
    @State
    private var screenHeight: CGFloat = 0
    
    /// The image displayed on the screen.
    private let image: Image
    
    // MARK: - Initialization
    
    /// Initializes a ``CoreNotificationSettingsScreen`` with the provided image.
    ///
    /// - Parameter image: The image to display in the view.
    public init(image: Image) { self.image = image }
    
    // MARK: - Body
    
    /// The main body of the screen, consisting of several views stacked vertically.
    public var body: some View {
        VStack(alignment: .leading, spacing: Values.verticalSpacing) {
            headerView
            imageView
            descriptionView
        }
        .safeAreaInset(edge: .bottom, content: { actionButtonView })
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

extension CSLNotificationSettingsSheet {
    
    /// The header section containing the screen title and a close button.
    private var headerView: some View {
        HStack {
            Text(Values.screenTitle, bundle: .module)
                .fixedSize(horizontal: false, vertical: true)
                .font(Font.title2)
                .bold()
                .multilineTextAlignment(.leading)
            
            Spacer()
            
            Button(action: {
                dismiss()
            }, label: {
                Image(systemName: SFSymbol.xmarkCircleFill.rawValue)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(Color.tertiaryLabel, .ultraThinMaterial)
                    .font(.system(size: Values.closeButtonSize))
            })
        }
    }
    
    /// Displays the provided image with resizable properties and constraints.
    private var imageView: some View {
        image
            .resizable()
            .scaledToFill()
            .frame(maxWidth: Values.maxImageWidth, maxHeight: Values.maxImageHeight, alignment: .top)
            .roundedCornerWithBorder(radius: CSLConstants.cornerRadius)
            .allowsHitTesting(false)
    }
    
    /// Displays the description text about changing notification settings.
    private var descriptionView: some View {
        Text(Values.description, bundle: .module)
            .fixedSize(horizontal: false, vertical: true)
            .font(Font.body)
            .foregroundStyle(Color.secondaryLabel)
    }
    
    /// The action button that dismisses the screen and opens the notification settings.
    @ViewBuilder
    private var actionButtonView: some View {
        Button {
            dismiss()
            
            guard let appSettings = URL(string: UIApplication.openNotificationSettingsURLString),
                  UIApplication.shared.canOpenURL(appSettings) else { return }
            
            UIApplication.shared.open(appSettings)
        } label: {
            Text(Values.buttonTitle, bundle: .module)
        }
        .buttonStyle(CSLCustomButtonStyle.primary)
        .padding(.top, Values.closeButtonTopPadding)
    }
}

// MARK: - Previews

#Preview {
    CSLNotificationSettingsSheet(image: Image(systemName: "heart"))
}
