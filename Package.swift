// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "SwiftLibs",
    products: [
        .library(
            name: "SwiftLibs",
            targets: [
                "Core"
            ]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Core",
            dependencies: [
            ]
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
