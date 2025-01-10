import SwiftUI

/// A custom SwiftUI view that creates a parallax effect for the header content as the user scrolls.
///
/// This view allows for creating a header that responds to scroll events, with its content moving at a different speed than the rest of the view, creating a parallax effect. It can be used as a header for scrollable content, with the header content becoming "sticky" or shifting dynamically as the user scrolls.
///
/// - Parameters:
///   - coordinateSpace: The coordinate space that the geometry reader should use to calculate the frame of the content.
///   - defaultHeight: The default height of the header.
///   - content: A closure that returns the content to display inside the header.
///
/// - See Also: `GeometryReader`, `ViewBuilder`
public struct CSLParallaxHeaderView<Content: View, Space: Hashable>: View {
    
    // MARK: - Properties
    
    /// A closure that provides the content to be displayed inside the header.
    private let content: () -> Content
    
    /// The coordinate space in which the frame calculations are performed.
    private let coordinateSpace: Space
    
    /// The default height of the header.
    private let defaultHeight: CGFloat
    
    // MARK: - Initialization
    
    /// Initializes a new instance of `CSLParallaxHeaderView` with the specified coordinate space, default height, and content.
    ///
    /// - Parameters:
    ///   - coordinateSpace: The coordinate space used for frame calculations (typically `.global` or `.named`).
    ///   - defaultHeight: The default height for the header.
    ///   - content: A view builder closure that returns the content of the header.
    public init(
        coordinateSpace: Space,
        defaultHeight: CGFloat,
        @ViewBuilder _ content: @escaping () -> Content
    ) {
        self.content = content
        self.coordinateSpace = coordinateSpace
        self.defaultHeight = defaultHeight
    }
    
    // MARK: - Body
    
    /// The body of the `CSLParallaxHeaderView`, which includes a `GeometryReader` to track scroll position and apply the parallax effect.
    public var body: some View {
        GeometryReader { proxy in
            content()
                .frame(
                    width: proxy.size.width,
                    height: proxy.size.height + heightModifier(for: proxy)
                )
                .offset(y: offset(for: proxy))
                .edgesIgnoringSafeArea(.horizontal)
        }
        .frame(height: defaultHeight)
    }
    
    // MARK: - Private Functions
    
    /// Calculates the vertical offset of the header content based on the scroll position.
    ///
    /// The offset is adjusted to create the parallax effect, making the content scroll slower or faster than the main content.
    ///
    /// - Parameters:
    ///   - proxy: The `GeometryProxy` used to calculate the position of the content in the coordinate space.
    /// - Returns: The vertical offset value to apply to the content.
    private func offset(for proxy: GeometryProxy) -> CGFloat {
        let frame = proxy.frame(in: .named(coordinateSpace))
        
        if frame.minY < 0 {
            return -frame.minY * 0.8
        }
        
        return -frame.minY
    }
    
    /// Calculates the height modifier for the header based on the scroll position.
    ///
    /// This height modifier ensures that the header grows or shrinks in size depending on the user's scroll position.
    ///
    /// - Parameters:
    ///   - proxy: The `GeometryProxy` used to calculate the frame of the content.
    /// - Returns: The height modifier to apply to the header content.
    private func heightModifier(for proxy: GeometryProxy) -> CGFloat {
        let frame = proxy.frame(in: .named(coordinateSpace))
        
        return max(0, frame.minY)
    }
}
