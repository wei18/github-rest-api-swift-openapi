# GitHub's REST API Swift Language Code
[![](https://img.shields.io/badge/docc-read_documentation-blue)](https://swiftpackageindex.com/wei18/github-rest-api-swift-openapi/documentation)
[![](https://img.shields.io/github/v/release/wei18/github-rest-api-swift-openapi)](https://github.com/wei18/github-rest-api-swift-openapi/releases)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fwei18%2Fgithub-rest-api-swift-openapi%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/wei18/github-rest-api-swift-openapi)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fwei18%2Fgithub-rest-api-swift-openapi%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/wei18/github-rest-api-swift-openapi)


This Swift code generator is built upon the [Swift OpenAPI Generator](https://github.com/apple/swift-openapi-generator) and leverages the OpenAPI description for GitHub's REST API. The goal is to automate the creation of Swift language code, providing developers with a seamless way to interact with GitHub's REST API.

## Usage
For example you can import these frameworks to fetch github users, or see reference [UsersTests.swift](https://github.com/Wei18/github-rest-api-swift-openapi/blob/46bd7a951cd6a2bda9a9d26d843d55bb12f769c3/Tests/UsersTests/UsersTests.swift#L8-L15).
```swift
import GitHubRestAPIUsers
import OpenAPIRuntime
import OpenAPIURLSession

let client = Client(serverURL: try Servers.Server1.url(), transport: URLSessionTransport())
let users = try await client.usersList().ok.body.json 
```

<details>
<summary>Full Supported Frameworks</summary>
    
```swift
import GitHubRestAPIActions
import GitHubRestAPIActivity
import GitHubRestAPIAgentTasks
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

The [tutorial](https://swiftpackageindex.com/wei18/github-rest-api-swift-openapi/main/tutorials/githubrestapiissues) walks you through the following example step by step, or refer below.

<details>
<summary>Example of code for enhanced issues comment API</summary>

```swift
// Usage.swift
// -
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
            middlewares: [AuthenticationMiddleware(token: "***")]
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

<details>
<summary>Example of code for the `GITHUB_TOKEN` to authenticate.</summary>
    
```swift
import Foundation
import GitHubRestAPIUsers
import OpenAPIRuntime
import OpenAPIURLSession
import HTTPTypes

/// Example: ProcessInfo.processInfo.environment["GITHUB_TOKEN"] ?? ""
let token: String = "***"

let client = Client(
    serverURL: try Servers.Server1.url(),
    transport: URLSessionTransport(),
    middlewares: [AuthenticationMiddleware(token: token)]
)

/// Injects an authorization header to every request.
struct AuthenticationMiddleware: ClientMiddleware {

    private let token: String

    init(token: String) {
        self.token = token
    }
    private var header: [String: String] { ["Authorization": "Bearer \(token)" ] }

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
```
</details>

## Installation

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler.

Once you have your Swift package set up, adding github-rest-api-swift-openapi as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

dependencies: [
    .package(url: "https://github.com/wei18/github-rest-api-swift-openapi.git", from: "1.0.0"),
]
```

## Overview

[OpenAPI](https://www.openapis.org/) serves as a standardized way to document HTTP services. It allows developers to automate workflows, such as generating code for making HTTP requests or implementing API servers. 

The [Swift OpenAPI Generator](https://github.com/apple/swift-openapi-generator) is a Swift package plugin designed to generate code at build-time, ensuring it remains synchronized with the OpenAPI document.

Use [Submodules](https://git-scm.com/book/en/v2/Git-Tools-Submodules) to clone [github/rest-api-description](https://github.com/github/rest-api-description) and then split openapi tags into multiple modules (Swift Package Products).

# Motivation

Wanna use Swift as the development language to create some convenient and user-friendly GitHub Actions.

# Contributions

Contributions are welcome! If you encounter issues or have suggestions for improvements, feel free to open an issue or submit a pull request.

This repository is automatically kept up to date with the submodule [github/rest-api-description](https://github.com/github/rest-api-description).

If you've identified a mismatch between GitHub API's Swift code and these descriptions, or found an issue with the format of a schema, [please open an issue to github/rest-api-description](https://github.com/github/rest-api-description/issues/new?template=schema-inaccuracy.md) or [open an issue to apple/swift-openapi-generator](https://github.com/apple/swift-openapi-generator/issues).
