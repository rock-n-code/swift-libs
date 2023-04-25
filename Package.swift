// swift-tools-version: 5.5
//
// This source file is part of the SwiftLibs open source project
//
// Copyright (c) 2023 Röck+Cöde VoF. and the SwiftLibs project authors
// Licensed under the EUPL 1.2 or later.
//
// See LICENSE.txt for license information
// See CONTRIBUTORS.txt for the list of SwiftLibs project authors
//

import PackageDescription

private var excludePlatforms: [String] = [.PlatformFolder.iOS]

#if os(iOS)
excludePlatforms = []
#endif

let package = Package(
    name: "SwiftLibs",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .tvOS(.v15),
        .watchOS(.v8)
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
