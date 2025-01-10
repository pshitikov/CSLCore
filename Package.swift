// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CSLCore",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v17),
    ],
    products: [
        .library(
            name: "CSLCore",
            targets: ["CSLCore"]),
    ],
    dependencies: [
        .package(url: "https://github.com/SDWebImage/SDWebImageSwiftUI.git", exact: "3.1.1"),
        .package(url: "https://github.com/SFSafeSymbols/SFSafeSymbols.git", exact: "5.3.0"),
        .package(url: "https://github.com/SimplyDanny/SwiftLintPlugins", exact: "0.57.1")
    ],
    targets: [
        .target(
            name: "CSLCore",
            dependencies: [
                .product(name: "SDWebImageSwiftUI", package: "SDWebImageSwiftUI"),
                .product(name: "SFSafeSymbols", package: "SFSafeSymbols"),
            ],
            resources: [
                .process("Resources")
            ],
            plugins: [
                .plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLintPlugins"),
            ]
        ),
        .testTarget(
            name: "CSLCoreTests",
            dependencies: ["CSLCore", "SDWebImageSwiftUI", "SFSafeSymbols"]
        ),
    ]
)
