import XCTest
import SwiftUI

final class ColorExtensionTests: XCTestCase {
    
    func testColorsAreNotNil() {
        let colors: [Color] = [
            // Text Colors
            .lightText, .darkText, .placeholderText,
            
            // Label Colors
            .label, .secondaryLabel, .tertiaryLabel, .quaternaryLabel,
            
            // Background Colors
            .systemBackground, .secondarySystemBackground, .tertiarySystemBackground,
            
            // Fill Colors
            .systemFill, .secondarySystemFill, .tertiarySystemFill, .quaternarySystemFill,
            
            // Grouped Background Colors
            .systemGroupedBackground, .secondarySystemGroupedBackground, .tertiarySystemGroupedBackground,
            
            // Gray Colors
            .systemGray, .systemGray2, .systemGray3, .systemGray4, .systemGray5, .systemGray6,
            
            // Other Colors
            .separator, .opaqueSeparator, .link,
            
            // System Colors
            .systemBlue, .systemPurple, .systemGreen, .systemYellow, .systemOrange,
            .systemPink, .systemRed, .systemTeal, .systemIndigo,
        ]
        
        for color in colors {
            XCTAssertNotNil(color, "Expected color to be non-nil")
        }
    }
}
