
import SwiftUI

extension Task where Success == Never, Failure == Never {
    
    /// Suspends the current task for the specified number of seconds.
    ///
    /// - Parameter seconds: The duration to sleep, represented in seconds.
    /// - Throws: An error if the sleep operation is canceled before completion.
    /// - Note: This method respects cooperative cancellation. If the task is canceled while sleeping, the method will throw an error and stop execution.
    public static func sleep(seconds: TimeInterval) async throws {
        let duration = UInt64(seconds * 1_000_000_000)
        
        try await Task.sleep(nanoseconds: duration)
    }
}
