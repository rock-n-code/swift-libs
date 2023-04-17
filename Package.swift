// swift-tools-version: 5.8

import PackageDescription

private var excludePlatforms: [String] = [.PlatformFolder.iOS]

#if os(iOS)
excludePlatforms = []
#endif

let package = Package(
    name: "SwiftLibs",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: "SwiftLibs",
            targets: [
                "Communications",
                "Coordination",
                "Core",
                "Dependencies",
                "Persistence"
            ]
        ),
    ],
    dependencies: [],
    targets: [
        // MARK: Targets
        .target(
            name: "Communications",
            dependencies: []
        ),
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
        .target(
            name: "Persistence",
            dependencies: []
        ),
        // MARK: Test targets
        .testTarget(
            name: "CommunicationsTests",
            dependencies: [
                "Communications"
            ],
            path: "Tests/Communications"
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
        .testTarget(
            name: "PersistenceTests",
            dependencies: [
                "Persistence"
            ],
            path: "Tests/Persistence"
        ),
    ]
)

// MARK: - String+Constants

private extension String {
    enum PlatformFolder {
        static let iOS = "Platform/iOS"
    }
}
