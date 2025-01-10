import SwiftUI
import SafariServices
import StoreKit

// MARK: - Enums

extension UIApplication {
    
    /// Constants to use in this extension.
    private enum Values {
        
        /// Dictionary key for `Bundle.main.infoDictionary` which contains the version of the application.
        static let versionKey = "CFBundleShortVersionString"
    }
}

// MARK: - Static properties

extension UIApplication {
    
    /// Returns the full version of the application consisting of a version and a build.
    ///
    /// This property combines the version and build to provide a full version string.
    /// Example: `8.2.19 (96)`
    public static var fullVersion: String {
        "\(version?.rawValue ?? "") (\(build?.rawValue ?? ""))"
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    /// Returns the application version.
    ///
    /// This property retrieves the version of the application as defined in the `Info.plist`.
    /// Example: `8.2.19`
    public static var version: Version? {
        guard let version = Bundle.main.infoDictionary?[Values.versionKey] as? String else { return nil }
        
        return Version(rawValue: version)
    }
    
    /// Returns the application build.
    ///
    /// This property retrieves the build number of the application as defined in the `Info.plist`.
    /// Example: `96`
    public static var build: Version? {
        guard let build = Bundle.main.infoDictionary?[kCFBundleVersionKey as String] as? String else { return nil }
        
        return Version(rawValue: build)
    }
}

// MARK: - Static functions

extension UIApplication {
    
    /// Checks if the current app version meets or exceeds a specified minimum version.
    ///
    /// This method compares the current app version with a given minimum version.
    /// It returns `true` if the current version is greater than or equal to the specified minimum version.
    /// If the version values are invalid (e.g., incorrect format or missing values), the method defaults to `true`.
    ///
    /// - Parameter minVersion: The minimum supported version.
    /// - Returns: `true` if the current version is greater than or equal to the minimum version, `false` otherwise.
    ///           If version values are invalid, returns `true` by default.
    ///
    /// - Example:
    /// ```swift
    /// UIApplication.isCurrentVersionAvailable(minVersion: "2.0.0")
    /// ```
    public static func isCurrentVersionAvailable(minVersion: String) -> Bool {
        guard let minVersion = Version(rawValue: minVersion),
              let currentVersionValue = Version(rawValue: "\(version?.rawValue ?? "").\(build?.rawValue ?? "")") else { return true }
        
        return minVersion <= currentVersionValue
    }
    
    /// Checks if the current app version is less than a specified maximum version.
    ///
    /// This method compares the current app version with a given maximum version.
    /// It returns `true` if the current version is less than the specified maximum version.
    /// If the version values are invalid (e.g., incorrect format or missing values), the method defaults to `false`.
    ///
    /// - Parameter maxVersion: The latest version available.
    /// - Returns: `true` if the current version is less than `maxVersion`, `false` otherwise.
    ///           If version values are invalid, returns `false` by default.
    ///
    /// - Example:
    /// ```swift
    /// UIApplication.isNewVersionAvailable(maxVersion: "2.5.0")
    /// ```
    public static func isNewVersionAvailable(maxVersion: String) -> Bool {
        guard let maxVersion = Version(rawValue: maxVersion),
              let currentVersionValue = Version(rawValue: "\(version?.rawValue ?? "").\(build?.rawValue ?? "")") else { return false }
        
        return currentVersionValue < maxVersion
    }
    
    /// Presents the modal screen for the specified `url` using the `SFSafariViewController`.
    ///
    /// This method presents the `SFSafariViewController` on top of the `rootViewController`
    /// of the `keyWindow` to display the provided URL.
    ///
    /// - Parameter url: The `URL` to open in Safari.
    public static func presentSafariViewController(url: URL) {
        let safariViewController = SFSafariViewController(url: url)
        
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .filter { $0.activationState == .foregroundActive }
            .first?
            .keyWindow?
            .rootViewController?
            .present(safariViewController, animated: true)
    }
    
    /// Presents the modal screen for the specified `itunesItemIdentifier` using the `SKStoreProductViewController`.
    ///
    /// This method presents the `SKStoreProductViewController` to display the app's product page from the App Store.
    ///
    /// - Parameter itunesItemIdentifier: The unique identifier of the app from App Store Connect.
    /// - Returns: `true` if the screen has opened successfully.
    /// - Throws: An error if the product view controller could not be loaded.
    @discardableResult
    public static func presentStoreProductViewController(itunesItemIdentifier: String) async throws -> Bool {
        let storeProductViewController = SKStoreProductViewController()
        let parameters = [
            SKStoreProductParameterITunesItemIdentifier: itunesItemIdentifier,
        ] as [String: Any]
        
        let result = try await storeProductViewController.loadProduct(withParameters: parameters)
        
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .filter { $0.activationState == .foregroundActive }
            .first?
            .keyWindow?
            .rootViewController?
            .present(storeProductViewController, animated: true)
        
        return result
    }
}
