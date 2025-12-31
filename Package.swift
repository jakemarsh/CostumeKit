// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CostumeKit",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .tvOS(.v15),
        .watchOS(.v8)
    ],
    products: [
        .library(
            name: "CostumeKit",
            targets: ["CostumeKit"]
        ),
    ],
    targets: [
        .target(
            name: "CostumeKit",
            dependencies: [],
            path: "Sources/CostumeKit"
        ),
        .testTarget(
            name: "CostumeKitTests",
            dependencies: ["CostumeKit"],
            path: "Tests/CostumeKitTests"
        ),
    ]
)
