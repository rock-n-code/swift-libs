// swift-tools-version: 5.8

import PackageDescription

private var excludePlatforms: [String] = [.PlatformFolder.iOS]

#if os(iOS)
excludePlatforms = []
#endif

let package = Package(
    name: "SwiftLibs",
    products: [
        .library(
            name: "SwiftLibs",
            targets: [
                "Coordinator",
                "Core"
            ]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Coordinator",
            dependencies: [],
            exclude: excludePlatforms
        ),
        .target(
            name: "Core",
            dependencies: []
        ),
        .testTarget(
            name: "CoordinatorTests",
            dependencies: [
                "Coordinator"
            ],
            path: "Tests/Coordinator",
            exclude: excludePlatforms
        ),
        .testTarget(
            name: "CoreTests",
            dependencies: [
                "Core"
            ],
            path: "Tests/Core"
        ),
    ]
)

// MARK: - String+Constants

private extension String {
    enum PlatformFolder {
        static let iOS = "Platform/iOS"
    }
}
