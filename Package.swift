// swift-tools-version: 5.7
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

// MARK: - Variables

private var targetsLibrary: [String] = [
    .Target.communications,
    .Target.coordination,
    .Target.core,
    .Target.dependencies,
]

private var targetsPackage: [Target] = [
    .target(
        name: .Target.communications,
        dependencies: []
    ),
    .target(
        name: .Target.coordination,
        dependencies: []
    ),
    .target(
        name: .Target.core,
        dependencies: []
    ),
    .target(
        name: .Target.dependencies,
        dependencies: []
    ),
    .testTarget(
        name: "CommunicationsTests",
        dependencies: [
            .init(stringLiteral: .Target.communications)
        ],
        path: "Tests/Communications"
    ),
    .testTarget(
        name: "CoordinationTests",
        dependencies: [
            .init(stringLiteral: .Target.coordination)
        ],
        path: "Tests/Coordination"
    ),
    .testTarget(
        name: "CoreTests",
        dependencies: [
            .init(stringLiteral: .Target.core)
        ],
        path: "Tests/Core"
    ),
    .testTarget(
        name: "DependenciesTests",
        dependencies: [
            .init(stringLiteral: .Target.dependencies)
        ],
        path: "Tests/Dependencies"
    ),
]

#if os(iOS) || os(macOS) || os(tvOS) || os(watchOS)
targetsLibrary.append(.Target.persistence)
targetsPackage.append(contentsOf: [
    .target(
        name: .Target.persistence,
        dependencies: []
    ),
    .testTarget(
        name: "PersistenceTests",
        dependencies: [
            .init(stringLiteral: .Target.persistence)
        ],
        path: "Tests/Persistence",
        resources: [
            .process("Resources")
        ]
    ),
])
#endif

// MARK: - Package

let package = Package(
    name: .Package.name,
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .tvOS(.v15),
        .watchOS(.v8)
    ],
    products: [
        .library(
            name: .Package.name,
            targets: targetsLibrary
        ),
    ],
    dependencies: [],
    targets: targetsPackage
)

// MARK: - String+Constants

private extension String {
    enum Package {
        static let name = "SwiftLibs"
    }

    enum Target {
        static let communications = "Communications"
        static let coordination = "Coordination"
        static let core = "Core"
        static let dependencies = "Dependencies"
        static let persistence = "Persistence"
    }
}
