import SwiftUI

/// A custom `TextFieldStyle` for creating a text field with a floating prompt label, customizable styling, and animations.
///
/// The `CSLTextField` applies a floating label effect where the prompt moves up and scales down when the user starts typing. The text field is styled with padding, rounded corners, and a subtle stroke. This style enhances the visual appearance and provides a smooth user experience during input.
///
/// - Parameters:
///   - text: A binding to the text value that the user enters in the text field.
///   - prompt: A localized string key that represents the prompt label to be displayed inside the text field. The prompt floats above the field when text is entered.
///
/// - See Also: `TextFieldStyle`, `TextField`, `ZStack`, `Animation`
public struct CSLTextField: TextFieldStyle {
    
    // MARK: - Enums
    
    private enum Values {
        
        static let height: CGFloat = 50
        
        static let promptYOffset: CGFloat = -25
        static let promptScaleEffect: CGFloat = 0.8
        
        static let strokeCornerRadius: CGFloat = 8
        static let strokeWidth: CGFloat = 0.3
        
        static let horizontalPadding: CGFloat = 16
        static let topPadding: CGFloat = 15
    }
    
    // MARK: - Properties
    
    /// A binding to the text value entered by the user.
    let text: Binding<String>
    
    /// The prompt label text that will float above the text field.
    let prompt: LocalizedStringKey
    
    // MARK: - Initialization
    
    /// Initializes a new instance of `CSLTextField` with the provided text binding and prompt label.
    ///
    /// - Parameters:
    ///   - text: A binding to the text value that the user enters.
    ///   - prompt: The prompt label text that floats above the text field.
    public init(text: Binding<String>, prompt: LocalizedStringKey) {
        self.text = text
        self.prompt = prompt
    }
    
    // MARK: - Body
    
    /// The body of the text field, applying the floating label effect and custom styling.
    ///
    /// - Parameters:
    ///   - configuration: The `TextField` configuration passed by SwiftUI's `TextFieldStyle` protocol.
    ///
    /// - Returns: A custom-styled text field with a floating label and animated effects.
    public func _body(configuration: TextField<Self._Label>) -> some View {
        ZStack(alignment: .leading) {
            Text(prompt)
                .foregroundColor(Color(.placeholderText))
                .offset(y: text.wrappedValue.isEmpty ? 0 : Values.promptYOffset)
                .scaleEffect(
                    text.wrappedValue.isEmpty ? 1 : Values.promptScaleEffect,
                    anchor: .leading
                )
            
            configuration
                .labelsHidden()
        }
        .padding(.top, text.wrappedValue.isEmpty ? 0 : Values.topPadding)
        .frame(height: Values.height)
        .padding(.horizontal, Values.horizontalPadding)
        .overlay(
            RoundedRectangle(cornerRadius: Values.strokeCornerRadius)
                .stroke(lineWidth: Values.strokeWidth)
                .foregroundStyle(Color.secondaryLabel)
        )
        .animation(.default, value: UUID())
    }
}
