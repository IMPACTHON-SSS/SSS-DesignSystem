// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SSS-DesignSystem",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "SDS",
            targets: ["SDS"]),
    ],
    dependencies: [
        .package(url: "https://github.com/rorodriguez116/Camera-SwiftUI.git", from: "0.5.0")
    ],
    targets: [
        .target(
            name: "SDS",
            dependencies: [.product(name: "Camera-SwiftUI", package: "Camera-SwiftUI")])
    ]
)
