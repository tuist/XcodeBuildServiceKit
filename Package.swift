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
        .library(
            name: "XCBProtocol",
            type: .static,
            targets: ["XCBProtocol"]
        ),
        .library(
            name: "XCBProtocol_11_3",
            type: .static,
            targets: ["XCBProtocol_11_3"]
        ),
        .library(
            name: "XCBProtocol_11_4",
            type: .static,
            targets: ["XCBProtocol_11_4"]
        ),
        .library(
            name: "XCBProtocol_12_0",
            type: .static,
            targets: ["XCBProtocol_12_0"]
        ),
        .library(
            name: "XCBProtocol_12_5",
            type: .static,
            targets: ["XCBProtocol_12_5"]
        ),
        .library(
            name: "XCBProtocol_13_0",
            type: .static,
            targets: ["XCBProtocol_13_0"]
        ),
        .library(
            name: "XCBProtocol_13_3",
            type: .static,
            targets: ["XCBProtocol_13_3"]
        )
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
            name: "XCBProtocol_11_3",
            dependencies: [
                .product(name: "NIO", package: "swift-nio")
            ]
        ),
        .target(
            name: "XCBProtocol_11_4",
            dependencies: [
                .product(name: "NIO", package: "swift-nio")
            ]
        ),
        .target(
            name: "XCBProtocol_12_0",
            dependencies: [
                .product(name: "NIO", package: "swift-nio")
            ]
        ),
        .target(
            name: "XCBProtocol_12_5",
            dependencies: [
                .product(name: "NIO", package: "swift-nio")
            ]
        ),
        .target(
            name: "XCBProtocol_13_0",
            dependencies: [
                .product(name: "NIO", package: "swift-nio")
            ]
        ),
        .target(
            name: "XCBProtocol_13_3",
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
