import SwiftUI
import SFSafeSymbols

/// A reusable SwiftUI screen that prompts users to update the app.
/// Includes an image, description, update button, dismiss button, and a hint message.
public struct CSLUpdateAppSheet: View {
    
    // MARK: - Enums
    
    /// Constants for layout, styling, and localized strings used in the view.
    @MainActor
    private enum Values {
        
        static let verticalSpacing: CGFloat = 12
        static let closeButtonSize: CGFloat = 30
        static let closeButtonTopPadding: CGFloat = 20
        static let maxImageWidth: CGFloat = 100
        static let maxImageHeight: CGFloat = 100
        
        static let screenTitle: LocalizedStringKey = "core_update_app_screen_title"
        static let description: LocalizedStringKey = "core_update_app_screen_description"
        
        static let updateButtonTitle: LocalizedStringKey = "core_update_app_screen_update_button_title"
        static let dismissButtonTitle: LocalizedStringKey = "core_update_app_screen_dismiss_button_title"
        
        static let hintTitle: LocalizedStringKey = "core_update_app_screen_hint_title"
    }
    
    // MARK: - Properties
    
    /// The environment dismiss action to close the view.
    @Environment(\.dismiss)
    private var dismiss
    
    /// The dynamic height of the screen, used for presentation detents.
    @State
    private var screenHeight: CGFloat = 0
    
    /// The image displayed at the top of the screen.
    private let image: Image
    
    /// The application ID used to open the app's page in the App Store.
    private let applicationId: String
    
    // MARK: - Initialization
    
    /// Initializes the screen with the provided image and application ID.
    ///
    /// - Parameters:
    ///   - image: The image to display at the top of the screen.
    ///   - applicationId: The App Store ID of the application to update.
    public init(
        image: Image,
        applicationId: String
    ) {
        self.image = image
        self.applicationId = applicationId
    }
    
    // MARK: - Body
    
    /// The body of the view, containing the header, image, description, and action buttons.
    public var body: some View {
        VStack(alignment: .leading, spacing: Values.verticalSpacing) {
            headerView
            
            imageView
            
            descriptionView
        }
        .safeAreaInset(edge: .bottom, content: { bottomView })
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

// MARK: - Subviews

extension CSLUpdateAppSheet {
    
    /// The header view containing the title and close button.
    private var headerView: some View {
        HStack {
            Text(Values.screenTitle, bundle: .module)
                .fixedSize(horizontal: false, vertical: true)
                .font(.title2.bold())
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
    
    /// The image view displaying the provided image in the center of the screen.
    private var imageView: some View {
        HStack {
            Spacer()
            
            image
                .resizable()
                .scaledToFill()
                .frame(maxWidth: Values.maxImageWidth, maxHeight: Values.maxImageHeight, alignment: .center)
                .roundedCornerWithBorder(radius: CSLConstants.cornerRadius)
                .allowsHitTesting(false)
            
            Spacer()
        }
    }
    
    /// The description text displayed below the image.
    private var descriptionView: some View {
        Text(Values.description, bundle: .module)
            .frame(maxWidth: .infinity, alignment: .center)
            .fixedSize(horizontal: false, vertical: true)
            .font(.body)
            .foregroundStyle(Color.secondaryLabel)
            .multilineTextAlignment(.center)
    }
    
    /// The bottom view containing action buttons and hint text.
    @ViewBuilder
    private var bottomView: some View {
        VStack {
            updateButtonView
            
            dismissButtonView
            
            enableUpdatingView
        }
        .padding(.top, Values.closeButtonTopPadding)
    }
    
    /// The dismiss button that closes the screen.
    private var dismissButtonView: some View {
        Button(
            action: { dismiss() },
            label: {
                Text(Values.dismissButtonTitle, bundle: .module)
                    .buttonStyle(CSLCustomButtonStyle.gray)
            }
        )
    }
    
    /// The update button that opens the App Store to the app's page.
    private var updateButtonView: some View {
        Button(
            action: {
                dismiss()
                
                Task { @MainActor in
                    try await UIApplication.presentStoreProductViewController(itunesItemIdentifier: applicationId)
                }
            },
            label: {
                Text(Values.updateButtonTitle, bundle: .module)
            }
        )
        .buttonStyle(CSLCustomButtonStyle.primary)
    }
    
    /// A hint text displayed below the buttons, providing additional information.
    private var enableUpdatingView: some View {
        Text(Values.hintTitle, bundle: .module)
            .frame(maxWidth: .infinity, alignment: .center)
            .fixedSize(horizontal: false, vertical: true)
            .foregroundStyle(Color.secondaryLabel)
            .font(.caption)
            .multilineTextAlignment(.center)
            .padding(.top, CSLConstants.verticalSpacing)
    }
}

// MARK: - Previews

#Preview {
    CSLUpdateAppSheet(
        image: Image(systemName: SFSymbol.heart.rawValue),
        applicationId: ""
    )
}
