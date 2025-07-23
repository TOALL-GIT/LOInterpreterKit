// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LOInterpreterKit",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "LOInterpreterKit",
            targets: ["LOInterpreterKitWrapper"]),
        .library(
            name: "LOInterpreterPodKit",
            targets: ["LOInterpreterPodKitWrapper"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Moya/Moya.git", from: "15.0.0"),
        .package(url: "https://github.com/AgoraIO/AgoraRtcEngine_iOS.git", exact: "4.5.2"),
        .package(url: "https://github.com/stephencelis/SQLite.swift.git", from: "0.13.3"),
    ],
    targets: [
        // Binary Targets
        .binaryTarget(
            name: "LOInterpreterKit",
            path: "./LOInterpreterKit.xcframework"
        ),
        .binaryTarget(
            name: "LOInterpreterPodKit",
            path: "./LOInterpreterPodKit.xcframework"
        ),
        
        // Wrappers to declare dependencies
        .target(
            name: "LOInterpreterKitWrapper",
            dependencies: [
                "LOInterpreterKit",
                .product(name: "Moya", package: "Moya"),
                .product(name: "RtcBasic", package: "AgoraRtcEngine_iOS"),
                .product(name: "SQLite", package: "SQLite.swift")
            ],
            path: "LOInterpreterKitWrapperStub"
        ),
        .target(
            name: "LOInterpreterPodKitWrapper",
            dependencies: [
                "LOInterpreterPodKit",
                .product(name: "Moya", package: "Moya"),
                .product(name: "RtcBasic", package: "AgoraRtcEngine_iOS"),
                .product(name: "SQLite", package: "SQLite.swift")
            ],
            path: "LOInterpreterPodKitWrapperStub"
        )
    ]
)
