// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "SwiftLibs",
    products: [
        .library(
            name: "SwiftLibs",
            targets: [
                "SwiftLibs"
            ]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SwiftLibs",
            dependencies: [
            ]
        ),
        .testTarget(
            name: "SwiftLibsTests",
            dependencies: [
                "SwiftLibs"
            ]
        ),
    ]
)
