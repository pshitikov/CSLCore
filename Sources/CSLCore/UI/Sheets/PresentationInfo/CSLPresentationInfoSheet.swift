import SwiftUI
import SFSafeSymbols

/// A reusable SwiftUI component for presenting information in a modal screen format.
/// This view includes a title, description, and an optional action button for additional functionality.
public struct CSLPresentationInfoSheet: View {
    
    // MARK: - Enums
    
    /// Layout constants for spacing and sizing within the view.
    private enum Values {
        
        /// Vertical spacing between elements.
        static let verticalSpacing: CGFloat = 8
        
        /// Size of the close button in the header.
        static let closeButtonSize: CGFloat = 30
        
        /// Top padding for the action button.
        static let closeButtonTopPadding: CGFloat = 20
    }
    
    // MARK: - Properties
    
    /// Dismisses the current view when called.
    @Environment(\.dismiss)
    private var dismiss
    
    /// The title displayed in the header.
    private let title: LocalizedStringKey
    
    /// The description displayed in the body.
    private let description: LocalizedStringKey
    
    /// The title for the action button (optional).
    private let buttonTitle: LocalizedStringKey?
    
    /// The screen height for presentation configuration.
    @State
    private var screenHeight: CGFloat = 0
    
    /// The action to be executed when the button is tapped (optional).
    private let didSelect: (() -> Void)?
    
    // MARK: - Initialization
    
    /// Initializes the view with its properties.
    ///
    /// - Parameters:
    ///   - title: The title to display.
    ///   - description: The description text.
    ///   - buttonTitle: The title of the action button (optional).
    ///   - screenHeight: The height of the screen (default: 300).
    ///   - didSelect: An optional action to execute when the button is tapped.
    public init(
        title: LocalizedStringKey,
        description: LocalizedStringKey,
        buttonTitle: LocalizedStringKey? = nil,
        didSelect: (() -> Void)? = nil
    ) {
        self.title = title
        self.description = description
        self.buttonTitle = buttonTitle
        self.didSelect = didSelect
    }
    
    // MARK: - Body
    
    /// The body of the view.
    public var body: some View {
        VStack(alignment: .leading, spacing: Values.verticalSpacing) {
            header
            descriptionView
        }
        .safeAreaInset(edge: .bottom, content: { actionButton })
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

extension CSLPresentationInfoSheet {
    
    /// The header view containing the title and close button.
    private var header: some View {
        HStack {
            Text(title)
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
    
    /// The description view displaying the main text content.
    private var descriptionView: some View {
        Text(description)
            .fixedSize(horizontal: false, vertical: true)
            .font(.body)
            .foregroundStyle(Color.secondaryLabel)
    }
    
    /// The action button view, shown if a button title is provided.
    @ViewBuilder
    private var actionButton: some View {
        if let buttonTitle {
            Button(buttonTitle) {
                dismiss()
                didSelect?()
            }
            .buttonStyle(CSLCustomButtonStyle.primary)
            .padding(.top, Values.closeButtonTopPadding)
        }
    }
}

// MARK: - Previews

#Preview {
    CSLPresentationInfoSheet(
        title: "Sample Title",
        description: "This is a detailed description of the content presented in this modal screen.",
        buttonTitle: "Confirm"
    )
}
