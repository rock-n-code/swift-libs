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
                "Coordination",
                "Core",
                "Dependencies"
            ]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Coordination",
            dependencies: [],
            exclude: excludePlatforms
        ),
        .target(
            name: "Core",
            dependencies: []
        ),
        .target(
            name: "Dependencies",
            dependencies: []
        ),
        .testTarget(
            name: "CoordinationTests",
            dependencies: [
                "Coordination"
            ],
            path: "Tests/Coordination",
            exclude: excludePlatforms
        ),
        .testTarget(
            name: "CoreTests",
            dependencies: [
                "Core"
            ],
            path: "Tests/Core"
        ),
        .testTarget(
            name: "DependenciesTests",
            dependencies: [
                "Dependencies"
            ],
            path: "Tests/Dependencies"
        ),
    ]
)

// MARK: - String+Constants

private extension String {
    enum PlatformFolder {
        static let iOS = "Platform/iOS"
    }
}
