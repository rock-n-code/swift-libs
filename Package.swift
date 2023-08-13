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
    .Target.communication,
    .Target.coordination,
    .Target.foundation,
    .Target.dependency,
]

private var targetsPackage: [Target] = [
    .target(
        name: .Target.communication,
        path: "Libraries/Communication"
    ),
    .target(
        name: .Target.coordination,
        path: "Libraries/Coordination"
    ),
    .target(
        name: .Target.foundation,
        path: "Libraries/Foundation"
    ),
    .target(
        name: .Target.dependency,
        path: "Libraries/Dependency"
    ),
    .testTarget(
        name: .Target.communication.tests,
        dependencies: [
            .init(stringLiteral: .Target.communication)
        ],
        path: "Tests/Communication"
    ),
    .testTarget(
        name: .Target.coordination.tests,
        dependencies: [
            .init(stringLiteral: .Target.coordination)
        ],
        path: "Tests/Coordination"
    ),
    .testTarget(
        name: .Target.foundation.tests,
        dependencies: [
            .init(stringLiteral: .Target.foundation)
        ],
        path: "Tests/Foundation"
    ),
    .testTarget(
        name: .Target.dependency.tests,
        dependencies: [
            .init(stringLiteral: .Target.dependency)
        ],
        path: "Tests/Dependency"
    ),
]

#if os(iOS) || os(macOS) || os(tvOS) || os(watchOS)
targetsLibrary.append(.Target.persistence)
targetsPackage.append(contentsOf: [
    .target(
        name: .Target.persistence,
        path: "Libraries/Persistence"
    ),
    .testTarget(
        name: .Target.persistence.tests,
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
    defaultLocalization: "en",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .tvOS(.v15),
        .watchOS(.v8),
    ],
    products: [
        .library(
            name: .Library.name,
            targets: targetsLibrary
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/apple/swift-docc-plugin",
            from: "1.0.0"
        ),
    ],
    targets: targetsPackage
)

// MARK: - String+Constants

private extension String {
    enum Package {
        static let name = "swift-libs"
    }
    
    enum Library {
        static let name = "SwiftLibs"
    }

    enum Target {
        static let communication = "SwiftLibsCommunication"
        static let coordination = "SwiftLibsCoordination"
        static let foundation = "SwiftLibsFoundation"
        static let dependency = "SwiftLibsDependency"
        static let persistence = "SwiftLibsPersistence"
    }
}

// MARK: - String+Computed

private extension String {
    var tests: String {
        self + "Tests"
    }
}
