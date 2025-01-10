import SwiftUI

/// A customizable button style for consistent and visually appealing buttons in SwiftUI.
public struct CSLCustomButtonStyle: ButtonStyle {
    
    // MARK: - Enums
    
    public enum Values {
        
        public static let maxWidth: CGFloat = 380
        public static let horizontalPadding: CGFloat = 6
        public static let pressedOpacity: CGFloat = 0.5
        public static let disabledOpacity: CGFloat = 0.5
        public static let shadowOpacity: CGFloat = 0.3
        public static let shadowRadius: CGFloat = 10
        public static let cornerRadius: CGFloat = 15
        public static let buttonHeight: CGFloat = 48
        public static let defaultBackground: Color = .blue
    }
    
    // MARK: - Background Style
    
    /// Represents the background style for the button.
    public enum Background {
        case color(Color)
        case gradient(LinearGradient)
        
        var view: AnyView {
            switch self {
            case .color(let color):
                return AnyView(color)
            case .gradient(let gradient):
                return AnyView(gradient)
            }
        }
    }
    
    // MARK: - Properties
    
    private let background: Background
    private let titleColor: Color
    private let shadowColor: Color?
    private let shadowOpacity: CGFloat
    private let cornerRadius: CGFloat
    private let buttonHeight: CGFloat
    private let isLoading: Bool
    private let isDisabled: Bool
    
    // MARK: - Initialization
    
    /// Initializes a new `CSLCustomButtonStyle`.
    ///
    /// - Parameters:
    ///   - background: The background style (color or gradient) for the button.
    ///   - titleColor: The color of the button's title text.
    ///   - shadowColor: The color of the button's shadow. Defaults to `nil`.
    ///   - shadowOpacity: The opacity of the shadow. Defaults to `0.3`.
    ///   - cornerRadius: The corner radius of the button. Defaults to `15`.
    ///   - buttonHeight: The height of the button. Defaults to `48`.
    ///   - isLoading: Whether the button is in a loading state. Defaults to `false`.
    ///   - isDisabled: Whether the button is disabled. Defaults to `false`.
    public init(
        background: Background = .color(Values.defaultBackground),
        titleColor: Color,
        shadowColor: Color? = nil,
        shadowOpacity: CGFloat = Values.shadowOpacity,
        cornerRadius: CGFloat = Values.cornerRadius,
        buttonHeight: CGFloat = Values.buttonHeight,
        isLoading: Bool = false,
        isDisabled: Bool = false
    ) {
        self.background = background
        self.titleColor = titleColor
        self.shadowColor = shadowColor
        self.shadowOpacity = shadowOpacity
        self.cornerRadius = cornerRadius
        self.buttonHeight = buttonHeight
        self.isLoading = isLoading
        self.isDisabled = isDisabled
    }
    
    // MARK: - ButtonStyle Conformance
    
    /// Creates the appearance and behavior of the button using the provided configuration.
    ///
    /// - Parameter configuration: A `ButtonStyle.Configuration` object containing the button's label and interaction state.
    /// - Returns: A view representing the styled button.
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(height: buttonHeight)
            .frame(maxWidth: Values.maxWidth)
            .padding(.horizontal, Values.horizontalPadding)
            .background(backgroundView(configuration: configuration))
            .foregroundColor(titleColor)
            .cornerRadius(cornerRadius)
            .opacity(opacity(for: configuration.isPressed))
            .shadow(color: shadowColor?.opacity(shadowOpacity) ?? .clear, radius: Values.shadowRadius)
            .overlay(loadingOverlay)
    }
    
    // MARK: - Private Views
    
    /// The background view for the button.
    private func backgroundView(configuration: Configuration) -> some View {
        Group {
            if isDisabled {
                Color.systemGray
            } else {
                background.view
            }
        }
    }
    
    /// The loading overlay view.
    private var loadingOverlay: some View {
        Group {
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .tint(Color.white)
            }
        }
    }
    
    // MARK: - Private Methods
    
    /// Determines the opacity for the button based on its state.
    ///
    /// - Parameter isPressed: A Boolean value indicating whether the button is currently being pressed.
    /// - Returns: The appropriate opacity value.
    private func opacity(for isPressed: Bool) -> CGFloat {
        if isDisabled {
            return Values.disabledOpacity
        } else if isPressed {
            return Values.pressedOpacity
        } else {
            return 1
        }
    }
}
