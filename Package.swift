// swift-tools-version: 5.8.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "XcodeBuildServiceKit",
    platforms: [.macOS("12.0")],
    products: [
        .library(
            name: "XcodeBuildServiceKit",
            type: .static,
            targets: ["XcodeBuildServiceKit"]
        ),
        .library(
            name: "MessagePack",
            type: .static,
            targets: ["MessagePack"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-log", .upToNextMajor(from: "1.4.2")),
        .package(url: "https://github.com/apple/swift-nio", .upToNextMajor(from: "2.40.0"))
    ],
    targets: [
        .target(
            name: "XcodeBuildServiceKit",
            dependencies: [
                "MessagePack",
                "XCBProtocol",
                .product(name: "Logging", package: "swift-log")
            ]
        ),
        .target(
            name: "XCBProtocol",
            dependencies: [
                .product(name: "NIO", package: "swift-nio")
            ]
        ),
        .target(
            name: "MessagePack",
            dependencies: [
            ]
        ),
        .testTarget(
            name: "MessagePackTests",
            dependencies: [
                "MessagePack",
            ]
        ),
    ]
)
