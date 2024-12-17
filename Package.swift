// swift-tools-version: 5.8.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "XCBBuildServiceProxyKit",
    platforms: [.macOS("12.0")],
    products: [
        .library(
            name: "XCBBuildServiceProxyKit",
            type: .static,
            targets: ["XCBBuildServiceProxyKit"]
        ),
        .library(
            name: "MessagePack",
            type: .static,
            targets: ["MessagePack"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-log", .upToNextMajor(from: "1.4.2")),
        .package(url: "https://github.com/apple/swift-nio", .upToNextMajor(from: "2.40.0")),
    ],
    targets: [
        .target(
            name: "XCBBuildServiceProxyKit",
            dependencies: [
                "MessagePack",
                "XCBProtocol",
                .product(name: "Logging", package: "swift-log"),
            ]
        ),
        .target(
            name: "XCBProtocol",
            dependencies: [
                .product(name: "NIO", package: "swift-nio"),
            ]
        ),
        .target(
            name: "XCBProtocol_11_3",
            dependencies: [
                "XCBProtocol",
                .product(name: "NIO", package: "swift-nio"),
            ]
        ),
        .target(
            name: "XCBProtocol_11_4",
            dependencies: [
                "XCBProtocol",
                .product(name: "NIO", package: "swift-nio"),
            ]
        ),
        .target(
            name: "XCBProtocol_12_0",
            dependencies: [
                "XCBProtocol",
                .product(name: "NIO", package: "swift-nio"),
            ]
        ),
        .target(
            name: "XCBProtocol_12_5",
            dependencies: [
                .product(name: "NIO", package: "swift-nio"),
                "XCBProtocol",
            ]
        ),
        .target(
            name: "XCBProtocol_13_0",
            dependencies: [
                "XCBProtocol",
                .product(name: "NIO", package: "swift-nio"),
            ]
        ),
        .target(
            name: "XCBProtocol_13_3",
            dependencies: [
                "XCBProtocol",
                .product(name: "NIO", package: "swift-nio"),
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
