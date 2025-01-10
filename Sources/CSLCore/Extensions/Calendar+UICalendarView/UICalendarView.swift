import SwiftUI

extension UICalendarView {
    
    /// Reloads the decorations for all visible days in the currently visible month.
    ///
    /// This method calculates the range of days in the visible month and reloads the decorations for each of these days.
    /// If the `animated` parameter is `true`, the decoration updates will be animated.
    ///
    /// - Parameter animated: A Boolean value that determines whether the decoration reload should be animated.
    /// If `true`, the reload will be animated; if `false`, the reload will occur immediately without animation.
    ///
    /// - Example:
    ///     ```swift
    ///     let calendarView = UICalendarView()
    ///     calendarView.reloadDecorationsForVisibleMonth(animated: true)
    ///     // The calendar view reloads decorations for all visible days of the month with animation.
    ///     ```
    ///
    /// - Note: This method uses the `visibleDateComponents` property to determine the current visible month and calculates the range of days for that month.
    /// It then calls `reloadDecorations(forDateComponents:animated:)` to reload the decorations for each day in the visible month.
    ///
    /// - Complexity: O(n) where `n` is the number of days in the visible month. The method iterates through the range of days to reload their decorations.
    public func reloadDecorationsForVisibleMonth(animated: Bool) {
        guard let visibleMonth = calendar.date(from: visibleDateComponents),
              let range = calendar.range(of: .day, in: .month, for: visibleMonth) else { return }
        
        var daysToReload = [DateComponents]()
        
        for day in range {
            var components = visibleDateComponents
            components.day = day
            daysToReload.append(components)
        }
        
        reloadDecorations(forDateComponents: daysToReload, animated: animated)
    }
}
