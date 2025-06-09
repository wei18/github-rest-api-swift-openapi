// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "manifest-Mint",
    dependencies: [
        .package(url: "https://github.com/yonaskolb/Mint", exact: "0.18.0"),
    ]
)
