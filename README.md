# GitHubRestAPISwiftOpenAPI

[![](https://img.shields.io/badge/docc-read_documentation-blue)](https://swiftpackageindex.com/wei18/github-rest-api-swift-openapi/documentation)
[![](https://img.shields.io/github/v/release/wei18/github-rest-api-swift-openapi)](https://github.com/wei18/github-rest-api-swift-openapi/releases)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fwei18%2Fgithub-rest-api-swift-openapi%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/wei18/github-rest-api-swift-openapi)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fwei18%2Fgithub-rest-api-swift-openapi%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/wei18/github-rest-api-swift-openapi)
[![](https://img.shields.io/github/license/wei18/github-rest-api-swift-openapi)](LICENSE)

English | [繁體中文](README.zh-TW.md)

Type-safe Swift clients for GitHub's REST API, generated from GitHub's official
[OpenAPI description](https://github.com/github/rest-api-description) with Apple's
[Swift OpenAPI Generator](https://github.com/apple/swift-openapi-generator).

## Features

- **Type-safe by construction** — every endpoint, parameter, and response schema is
  generated from GitHub's official OpenAPI document; mismatches fail at compile time.
- **Modular** — each GitHub API category ships as its own library product
  (e.g. `GitHubRestAPIIssues`, `GitHubRestAPIRepos`), so you only build what you use.
- **Always up to date** — the package tracks GitHub's API description automatically
  and publishes a release every month.
- **Cross-platform** — macOS, iOS, tvOS, watchOS, visionOS, and Linux.

## Requirements

| | Minimum |
| --- | --- |
| Swift | 5.9 |
| macOS | 10.15 |
| iOS / tvOS | 13 |
| watchOS | 6 |
| visionOS | 1 |

## Installation

Add the package to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/wei18/github-rest-api-swift-openapi.git", from: "3.0.0"),
]
```

Then declare the products you need as target dependencies:

```swift
.target(
    name: "YourTarget",
    dependencies: [
        .product(name: "GitHubRestAPIUsers", package: "github-rest-api-swift-openapi"),
    ]
)
```

In Xcode: **File ▸ Add Package Dependencies…** and enter the repository URL.

## Quick Start

```swift
import GitHubRestAPIUsers
import OpenAPIRuntime
import OpenAPIURLSession

let client = Client(serverURL: try Servers.Server1.url(), transport: URLSessionTransport())
let users = try await client.usersList().ok.body.json
```

The [tutorial](https://swiftpackageindex.com/wei18/github-rest-api-swift-openapi/main/tutorials/githubrestapiissues)
walks through a complete example step by step, from adding the dependency to
pattern matching on responses.

### Authentication

Inject a token with a `ClientMiddleware`:

```swift
import Foundation
import GitHubRestAPIUsers
import OpenAPIRuntime
import OpenAPIURLSession
import HTTPTypes

/// Injects an authorization header into every request.
struct AuthenticationMiddleware: ClientMiddleware {

    let token: String

    func intercept(
        _ request: HTTPRequest,
        body: HTTPBody?,
        baseURL: URL,
        operationID: String,
        next: @Sendable (HTTPRequest, HTTPBody?, URL) async throws -> (HTTPResponse, HTTPBody?)
    ) async throws -> (HTTPResponse, HTTPBody?) {
        var request = request
        request.headerFields.append(HTTPField(name: .authorization, value: "Bearer \(token)"))
        return try await next(request, body, baseURL)
    }
}

let client = Client(
    serverURL: try Servers.Server1.url(),
    transport: URLSessionTransport(),
    middlewares: [AuthenticationMiddleware(token: ProcessInfo.processInfo.environment["GITHUB_TOKEN"] ?? "")]
)
```

### Real-world example: upsert an issue comment

<details>
<summary>Update a bot comment in place, or create it if absent — the pattern used by CI status comments.</summary>

```swift
import Foundation
import GitHubRestAPIIssues
import OpenAPIRuntime
import OpenAPIURLSession
import HTTPTypes

struct GitHubRestAPIIssuesExtension {

    let owner: String
    let repo: String
    /// The issue number or pull number.
    let number: Int

    /// Update the comment if the anchor is found; otherwise, create it.
    func comment(anchor: String, body: String) async throws {
        let hidingContent = "<!-- Comment anchor: \(anchor) -->"
        let newBody = "\(body)\n\n\(hidingContent)"

        let client = Client(
            serverURL: try Servers.Server1.url(),
            transport: URLSessionTransport(),
            middlewares: [AuthenticationMiddleware(token: ProcessInfo.processInfo.environment["GITHUB_TOKEN"] ?? "")]
        )

        let comments = try await client.issuesListComments(
            path: .init(owner: owner, repo: repo, issueNumber: number)
        ).ok.body.json

        if let comment = comments.first(where: { $0.body?.contains(hidingContent) == true }) {
            _ = try await client.issuesUpdateComment(
                path: .init(owner: owner, repo: repo, commentId: comment.id),
                body: .json(.init(body: newBody))
            )
        } else {
            _ = try await client.issuesCreateComment(
                path: .init(owner: owner, repo: repo, issueNumber: number),
                body: .json(.init(body: newBody))
            )
        }
    }
}
```
</details>

## Available Modules

One library product per GitHub API category — 50 in total.

<details>
<summary>Full module list</summary>

```swift
import GitHubRestAPIActions
import GitHubRestAPIActivity
import GitHubRestAPIAgentTasks
import GitHubRestAPIAgents
import GitHubRestAPIApps
import GitHubRestAPIBilling
import GitHubRestAPICampaigns
import GitHubRestAPIChecks
import GitHubRestAPIClassroom
import GitHubRestAPICodeQuality
import GitHubRestAPICodeScanning
import GitHubRestAPICodeSecurity
import GitHubRestAPICodesOfConduct
import GitHubRestAPICodespaces
import GitHubRestAPICopilot
import GitHubRestAPICopilotSpaces
import GitHubRestAPICredentials
import GitHubRestAPIDependabot
import GitHubRestAPIDependencyGraph
import GitHubRestAPIDesktop
import GitHubRestAPIEmojis
import GitHubRestAPIEnterpriseTeamMemberships
import GitHubRestAPIEnterpriseTeamOrganizations
import GitHubRestAPIEnterpriseTeams
import GitHubRestAPIGists
import GitHubRestAPIGit
import GitHubRestAPIGitignore
import GitHubRestAPIHostedCompute
import GitHubRestAPIInteractions
import GitHubRestAPIIssues
import GitHubRestAPILicenses
import GitHubRestAPIMarkdown
import GitHubRestAPIMergeQueue
import GitHubRestAPIMeta
import GitHubRestAPIMigrations
import GitHubRestAPIOidc
import GitHubRestAPIOrgs
import GitHubRestAPIPackages
import GitHubRestAPIPrivateRegistries
import GitHubRestAPIProjects
import GitHubRestAPIProjectsClassic
import GitHubRestAPIPulls
import GitHubRestAPIRateLimit
import GitHubRestAPIReactions
import GitHubRestAPIRepos
import GitHubRestAPISearch
import GitHubRestAPISecretScanning
import GitHubRestAPISecurityAdvisories
import GitHubRestAPITeams
import GitHubRestAPIUsers
```
</details>

Browse the full API surface in the
[DocC documentation](https://swiftpackageindex.com/wei18/github-rest-api-swift-openapi/documentation).

## How It Works

```
github/rest-api-description (git submodule, updated weekly by Dependabot)
        │
        ▼  one module per OpenAPI tag
swift-openapi-generator ──▶ Sources/<tag>/{Client,Types}.swift
        │
        ▼
Package.swift / .spi.yml (kept in sync automatically)
```

- Dependabot bumps the OpenAPI description weekly; CI regenerates all modules,
  smoke-builds, and merges automatically.
- A release is tagged monthly. Release tags are cut from a branch with the
  submodule removed, so resolving the package never downloads the large
  OpenAPI description repository.

## Contributing

Most of `Sources/` is generated — see [CONTRIBUTING.md](CONTRIBUTING.md) for
what is hand-written, how the pipeline works, and where to report
API-mismatch issues upstream.

## License

This project is licensed under the [MIT License](LICENSE).
