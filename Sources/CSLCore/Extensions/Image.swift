import Foundation
import SwiftUI

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

extension Image {
    
    /// Initializes an `Image` from raw image data.
    ///
    /// This initializer attempts to create an `Image` object from a `Data` object. It works for both iOS (via `UIImage`) and macOS (via `NSImage`) platforms, depending on which framework is available. If the `Data` cannot be converted to a valid image, the initializer returns `nil`.
    ///
    /// - Parameters:
    ///   - data: A `Data` object representing image data (e.g., PNG, JPEG).
    ///
    /// - Returns: An optional `Image` created from the provided data. Returns `nil` if the data cannot be converted into an image.
    ///
    /// - Example:
    /// ```swift
    /// if let imageData = Data(contentsOf: someImageURL) {
    ///     if let image = Image(data: imageData) {
    ///         // Use the image
    ///     } else {
    ///         // Handle invalid image data
    ///     }
    /// }
    /// ```
    ///
    /// - Note: On iOS, the image is created using `UIImage`. On macOS, the image is created using `NSImage`. If the data is not valid or cannot be parsed as an image, this initializer returns `nil`.
    public init?(data: Data) {
        #if canImport(UIKit)
        if let uiImage = UIImage(data: data) {
            self.init(uiImage: uiImage)
        } else {
            return nil
        }
        #elseif canImport(AppKit)
        if let nsImage = NSImage(data: data) {
            self.init(nsImage: nsImage)
        } else {
            return nil
        }
        #else
        return nil
        #endif
    }
}
