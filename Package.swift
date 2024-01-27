// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "SSS-DesignSystem",
  platforms: [.iOS(.v15)],
  products: [
    .library(
      name: "SDS",
      targets: ["SDS"]),
  ],
  dependencies: [
  ],
  targets: [
    .target(
      name: "SDS",
      dependencies: [])
  ]
)
