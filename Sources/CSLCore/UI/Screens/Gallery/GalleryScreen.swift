import SwiftUI
import SFSafeSymbols
import SDWebImageSwiftUI

/// A screen that displays a horizontally scrollable gallery of images, with a close button and page control.
public struct CSLGalleryScreen: View {
    
    // MARK: - Enums
    
    private enum Values {
        
        /// The size of the close button image.
        static let closeButtonImageSize: CGFloat = 36
        
        /// The magnitude value used for dismissing the gallery screen.
        static let dismissMagnitudeValue: CGFloat = 500
        
        /// The horizontal offset for scroll transitions.
        static let scrollTransitionOffset: CGFloat = -150
    }
    
    // MARK: - Properties
    
    /// The environment dismiss action to close the gallery screen.
    @Environment(\.dismiss)
    private var dismiss
    
    /// The currently selected page (index) in the gallery.
    @State
    private var currentPage: Int
    
    /// The array of image URLs to display in the gallery.
    private var imageLinks: [String]
    
    // MARK: - Initialization
    
    /// Initializes the `CoreGalleryScreen` with a list of image links and an optional selected image.
    /// - Parameters:
    ///   - imageLinks: An array of image URLs to display in the gallery.
    ///   - selectedImage: An optional image URL that determines the initially selected page.
    public init(imageLinks: [String], selectedImage: String? = nil) {
        self.imageLinks = imageLinks
        _currentPage = State(initialValue: imageLinks.firstIndex(of: selectedImage ?? "") ?? 0)
    }
    
    // MARK: - Views
    
    public var body: some View {
        VStack(spacing: CSLConstants.verticalPadding) {
            closeButtonView
            
            galleryView
            
            if imageLinks.count > 1 { pageControlView }
        }
        .gesture(dismissDragGesture)
    }
}

// MARK: - Views

extension CSLGalleryScreen {
    
    /// View for the close button that dismisses the gallery screen.
    private var closeButtonView: some View {
        HStack {
            Spacer()
            
            Button(action: {
                dismiss()
            }, label: {
                Image(systemName: SFSymbol.xmarkCircleFill.rawValue)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(Color.secondaryLabel, .ultraThinMaterial)
                    .font(.system(size: Values.closeButtonImageSize))
            })
        }
        .padding(.horizontal, CSLConstants.horizontalPadding)
    }
    
    /// The main gallery view that displays the images in a horizontally scrolling layout.
    private var galleryView: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: CSLConstants.horizontalPadding) {
                ForEach(Array(zip(imageLinks.indices, imageLinks)), id: \.0) { index, item in
                    CSLImageView(imageLink: URL(string: item))
                        .scrollTransition(axis: .horizontal) { content, phase in
                            content
                                .offset(x: phase.isIdentity ? 0 : phase.value * Values.scrollTransitionOffset)
                        }
                        .containerRelativeFrame(.horizontal)
                        .clipShape(.rect(cornerRadius: CSLConstants.cornerRadius))
                        .roundedCornerWithBorder(radius: CSLConstants.cornerRadius)
                        .id(index)
                }
            }
            .scrollTargetLayout()
        }
        .contentMargins(.horizontal, CSLConstants.horizontalPadding, for: .scrollContent)
        .scrollTargetBehavior(.viewAligned)
        .scrollIndicators(.hidden)
        .scrollPosition(id: Binding($currentPage))
    }
    
    /// The page control view for navigating through multiple images.
    private var pageControlView: some View {
        CSLPageControl(
            numberOfPages: imageLinks.count,
            currentPage: $currentPage,
            withAutoScroll: false
        )
    }
    
    /// The drag gesture for dismissing the gallery screen by swiping.
    private var dismissDragGesture: some Gesture {
        DragGesture()
            .onChanged { gesture in
                guard gesture.startLocation.y < gesture.location.y,
                      gesture.velocity.height.magnitude > Values.dismissMagnitudeValue else { return }
                
                dismiss()
            }
    }
}

// MARK: - Previews

#Preview {
    CSLGalleryScreen(
        imageLinks: [
            "https://firebasestorage.googleapis.com/v0/b/shi-bakery.appspot.com/o/products%2Fbento_cakes%2F01.jpeg?alt=media&token=b1ef342e-ad32-40b5-8354-87c4c68fc95d",
            "https://firebasestorage.googleapis.com/v0/b/shi-bakery.appspot.com/o/products%2Fbento_cakes%2F03.jpeg?alt=media&token=8fe64c34-376c-4984-a482-787231e1ddbc",
        ],
        selectedImage: ""
    )
}
