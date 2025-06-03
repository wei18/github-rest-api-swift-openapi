// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "manifest-swift-openapi-generator",
    dependencies: [
        .package(url: "https://github.com/apple/swift-openapi-generator", exact: "1.8.0"),
    ]
)
