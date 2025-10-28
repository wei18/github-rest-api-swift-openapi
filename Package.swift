// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import Foundation
import PackageDescription

/// Generated via `$swift PackageBuilder.swift`
let package = Package(
    name: "GitHubRestAPISwiftOpenAPI",
    platforms: [
        .macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6), .visionOS(.v1),
    ],
    products: [
        .library(name: "GitHubRestAPIActions", targets: ["GitHubRestAPIActions"]),
        .library(name: "GitHubRestAPIActivity", targets: ["GitHubRestAPIActivity"]),
        .library(name: "GitHubRestAPIApps", targets: ["GitHubRestAPIApps"]),
        .library(name: "GitHubRestAPIBilling", targets: ["GitHubRestAPIBilling"]),
        .library(name: "GitHubRestAPICampaigns", targets: ["GitHubRestAPICampaigns"]),
        .library(name: "GitHubRestAPIChecks", targets: ["GitHubRestAPIChecks"]),
        .library(name: "GitHubRestAPIClassroom", targets: ["GitHubRestAPIClassroom"]),
        .library(name: "GitHubRestAPICode_Scanning", targets: ["GitHubRestAPICode_Scanning"]),
        .library(name: "GitHubRestAPICode_Security", targets: ["GitHubRestAPICode_Security"]),
        .library(name: "GitHubRestAPICodes_Of_Conduct", targets: ["GitHubRestAPICodes_Of_Conduct"]),
        .library(name: "GitHubRestAPICodespaces", targets: ["GitHubRestAPICodespaces"]),
        .library(name: "GitHubRestAPICopilot", targets: ["GitHubRestAPICopilot"]),
        .library(name: "GitHubRestAPICredentials", targets: ["GitHubRestAPICredentials"]),
        .library(name: "GitHubRestAPIDependabot", targets: ["GitHubRestAPIDependabot"]),
        .library(name: "GitHubRestAPIDependency_Graph", targets: ["GitHubRestAPIDependency_Graph"]),
        .library(name: "GitHubRestAPIDesktop", targets: ["GitHubRestAPIDesktop"]),
        .library(name: "GitHubRestAPIEmojis", targets: ["GitHubRestAPIEmojis"]),
        .library(name: "GitHubRestAPIEnterprise_Team_Memberships", targets: ["GitHubRestAPIEnterprise_Team_Memberships"]),
        .library(name: "GitHubRestAPIEnterprise_Team_Organizations", targets: ["GitHubRestAPIEnterprise_Team_Organizations"]),
        .library(name: "GitHubRestAPIEnterprise_Teams", targets: ["GitHubRestAPIEnterprise_Teams"]),
        .library(name: "GitHubRestAPIGists", targets: ["GitHubRestAPIGists"]),
        .library(name: "GitHubRestAPIGit", targets: ["GitHubRestAPIGit"]),
        .library(name: "GitHubRestAPIGitignore", targets: ["GitHubRestAPIGitignore"]),
        .library(name: "GitHubRestAPIHosted_Compute", targets: ["GitHubRestAPIHosted_Compute"]),
        .library(name: "GitHubRestAPIInteractions", targets: ["GitHubRestAPIInteractions"]),
        .library(name: "GitHubRestAPIIssues", targets: ["GitHubRestAPIIssues"]),
        .library(name: "GitHubRestAPILicenses", targets: ["GitHubRestAPILicenses"]),
        .library(name: "GitHubRestAPIMarkdown", targets: ["GitHubRestAPIMarkdown"]),
        .library(name: "GitHubRestAPIMerge_Queue", targets: ["GitHubRestAPIMerge_Queue"]),
        .library(name: "GitHubRestAPIMeta", targets: ["GitHubRestAPIMeta"]),
        .library(name: "GitHubRestAPIMigrations", targets: ["GitHubRestAPIMigrations"]),
        .library(name: "GitHubRestAPIOidc", targets: ["GitHubRestAPIOidc"]),
        .library(name: "GitHubRestAPIOrgs", targets: ["GitHubRestAPIOrgs"]),
        .library(name: "GitHubRestAPIPackages", targets: ["GitHubRestAPIPackages"]),
        .library(name: "GitHubRestAPIPrivate_Registries", targets: ["GitHubRestAPIPrivate_Registries"]),
        .library(name: "GitHubRestAPIProjects", targets: ["GitHubRestAPIProjects"]),
        .library(name: "GitHubRestAPIProjects_Classic", targets: ["GitHubRestAPIProjects_Classic"]),
        .library(name: "GitHubRestAPIPulls", targets: ["GitHubRestAPIPulls"]),
        .library(name: "GitHubRestAPIRate_Limit", targets: ["GitHubRestAPIRate_Limit"]),
        .library(name: "GitHubRestAPIReactions", targets: ["GitHubRestAPIReactions"]),
        .library(name: "GitHubRestAPIRepos", targets: ["GitHubRestAPIRepos"]),
        .library(name: "GitHubRestAPISearch", targets: ["GitHubRestAPISearch"]),
        .library(name: "GitHubRestAPISecret_Scanning", targets: ["GitHubRestAPISecret_Scanning"]),
        .library(name: "GitHubRestAPISecurity_Advisories", targets: ["GitHubRestAPISecurity_Advisories"]),
        .library(name: "GitHubRestAPITeams", targets: ["GitHubRestAPITeams"]),
        .library(name: "GitHubRestAPIUsers", targets: ["GitHubRestAPIUsers"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-openapi-runtime", from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-openapi-urlsession", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "GitHubRestAPIActions",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
            ],
            path: "Sources/actions"
        ),
        .target(
            name: "GitHubRestAPIActivity",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
            ],
            path: "Sources/activity"
        ),
        .target(
            name: "GitHubRestAPIApps",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
            ],
            path: "Sources/apps"
        ),
        .target(
            name: "GitHubRestAPIBilling",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
            ],
            path: "Sources/billing"
        ),
        .target(
            name: "GitHubRestAPICampaigns",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
            ],
            path: "Sources/campaigns"
        ),
        .target(
            name: "GitHubRestAPIChecks",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
            ],
            path: "Sources/checks"
        ),
        .target(
            name: "GitHubRestAPIClassroom",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
            ],
            path: "Sources/classroom"
        ),
        .target(
            name: "GitHubRestAPICode_Scanning",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
            ],
            path: "Sources/code-scanning"
        ),
        .target(
            name: "GitHubRestAPICode_Security",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
            ],
            path: "Sources/code-security"
        ),
        .target(
            name: "GitHubRestAPICodes_Of_Conduct",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
            ],
            path: "Sources/codes-of-conduct"
        ),
        .target(
            name: "GitHubRestAPICodespaces",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
            ],
            path: "Sources/codespaces"
        ),
        .target(
            name: "GitHubRestAPICopilot",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
            ],
            path: "Sources/copilot"
        ),
        .target(
            name: "GitHubRestAPICredentials",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
            ],
            path: "Sources/credentials"
        ),
        .target(
            name: "GitHubRestAPIDependabot",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
            ],
            path: "Sources/dependabot"
        ),
        .target(
            name: "GitHubRestAPIDependency_Graph",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
            ],
            path: "Sources/dependency-graph"
        ),
        .target(
            name: "GitHubRestAPIDesktop",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
            ],
            path: "Sources/desktop"
        ),
        .target(
            name: "GitHubRestAPIEmojis",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
            ],
            path: "Sources/emojis"
        ),
        .target(
            name: "GitHubRestAPIEnterprise_Team_Memberships",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
            ],
            path: "Sources/enterprise-team-memberships"
        ),
        .target(
            name: "GitHubRestAPIEnterprise_Team_Organizations",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
            ],
            path: "Sources/enterprise-team-organizations"
        ),
        .target(
            name: "GitHubRestAPIEnterprise_Teams",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
            ],
            path: "Sources/enterprise-teams"
        ),
        .target(
            name: "GitHubRestAPIGists",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
            ],
            path: "Sources/gists"
        ),
        .target(
            name: "GitHubRestAPIGit",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
            ],
            path: "Sources/git"
        ),
        .target(
            name: "GitHubRestAPIGitignore",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
            ],
            path: "Sources/gitignore"
        ),
        .target(
            name: "GitHubRestAPIHosted_Compute",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
            ],
            path: "Sources/hosted-compute"
        ),
        .target(
            name: "GitHubRestAPIInteractions",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
            ],
            path: "Sources/interactions"
        ),
        .target(
            name: "GitHubRestAPIIssues",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
            ],
            path: "Sources/issues"
        ),
        .target(
            name: "GitHubRestAPILicenses",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
            ],
            path: "Sources/licenses"
        ),
        .target(
            name: "GitHubRestAPIMarkdown",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
            ],
            path: "Sources/markdown"
        ),
        .target(
            name: "GitHubRestAPIMerge_Queue",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
            ],
            path: "Sources/merge-queue"
        ),
        .target(
            name: "GitHubRestAPIMeta",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
            ],
            path: "Sources/meta"
        ),
        .target(
            name: "GitHubRestAPIMigrations",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
            ],
            path: "Sources/migrations"
        ),
        .target(
            name: "GitHubRestAPIOidc",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
            ],
            path: "Sources/oidc"
        ),
        .target(
            name: "GitHubRestAPIOrgs",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
            ],
            path: "Sources/orgs"
        ),
        .target(
            name: "GitHubRestAPIPackages",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
            ],
            path: "Sources/packages"
        ),
        .target(
            name: "GitHubRestAPIPrivate_Registries",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
            ],
            path: "Sources/private-registries"
        ),
        .target(
            name: "GitHubRestAPIProjects",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
            ],
            path: "Sources/projects"
        ),
        .target(
            name: "GitHubRestAPIProjects_Classic",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
            ],
            path: "Sources/projects-classic"
        ),
        .target(
            name: "GitHubRestAPIPulls",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
            ],
            path: "Sources/pulls"
        ),
        .target(
            name: "GitHubRestAPIRate_Limit",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
            ],
            path: "Sources/rate-limit"
        ),
        .target(
            name: "GitHubRestAPIReactions",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
            ],
            path: "Sources/reactions"
        ),
        .target(
            name: "GitHubRestAPIRepos",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
            ],
            path: "Sources/repos"
        ),
        .target(
            name: "GitHubRestAPISearch",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
            ],
            path: "Sources/search"
        ),
        .target(
            name: "GitHubRestAPISecret_Scanning",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
            ],
            path: "Sources/secret-scanning"
        ),
        .target(
            name: "GitHubRestAPISecurity_Advisories",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
            ],
            path: "Sources/security-advisories"
        ),
        .target(
            name: "GitHubRestAPITeams",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
            ],
            path: "Sources/teams"
        ),
        .target(
            name: "GitHubRestAPIUsers",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
            ],
            path: "Sources/users"
        ),
        .testTarget(
            name: "UsersTests",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
                .target(name: "GitHubRestAPIUsers"),
            ]
        )
    ]
)

// swift-docc is not needed for package users
if ProcessInfo.processInfo.environment["ENABLE_DOCC_SUPPORT"] == "1" {
    package.dependencies += [
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.3.0"),
    ]
}
