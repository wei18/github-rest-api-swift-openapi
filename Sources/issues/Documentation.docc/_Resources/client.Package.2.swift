// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "GitHubAPIClient",
    dependencies: [
        .package(url: "https://github.com/Wei18/github-rest-api-swift-openapi.git", from: "3.0.0"),
    ],
    targets: [
        .executableTarget(
            name: "GitHubAPIClient",
            dependencies: [
                .product(name: "GitHubRestAPIIssues", package: "github-rest-api-swift-openapi"),
            ]
        )
    ]
)
