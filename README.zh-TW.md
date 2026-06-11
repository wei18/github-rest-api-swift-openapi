# GitHubRestAPISwiftOpenAPI

[![](https://img.shields.io/badge/docc-read_documentation-blue)](https://swiftpackageindex.com/wei18/github-rest-api-swift-openapi/documentation)
[![](https://img.shields.io/github/v/release/wei18/github-rest-api-swift-openapi)](https://github.com/wei18/github-rest-api-swift-openapi/releases)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fwei18%2Fgithub-rest-api-swift-openapi%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/wei18/github-rest-api-swift-openapi)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fwei18%2Fgithub-rest-api-swift-openapi%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/wei18/github-rest-api-swift-openapi)
[![](https://img.shields.io/github/license/wei18/github-rest-api-swift-openapi)](LICENSE)

[English](README.md) | 繁體中文

型別安全的 GitHub REST API Swift 客戶端，由 GitHub 官方的
[OpenAPI 描述文件](https://github.com/github/rest-api-description) 搭配 Apple 的
[Swift OpenAPI Generator](https://github.com/apple/swift-openapi-generator) 自動生成。

## 特色

- **建構即型別安全** — 每個端點、參數與回應結構都從 GitHub 官方 OpenAPI 文件生成，
  任何不一致在編譯期就會被攔下。
- **模組化** — 每個 GitHub API 分類都是獨立的 library product
  （例如 `GitHubRestAPIIssues`、`GitHubRestAPIRepos`），只編譯你用到的部分。
- **持續更新** — 套件自動追蹤 GitHub 的 API 描述文件，每月發布新版本。
- **跨平台** — 支援 macOS、iOS、tvOS、watchOS、visionOS 與 Linux。

## 系統需求

| | 最低版本 |
| --- | --- |
| Swift | 5.9 |
| macOS | 10.15 |
| iOS / tvOS | 13 |
| watchOS | 6 |
| visionOS | 1 |

## 安裝

在 `Package.swift` 加入套件依賴：

```swift
dependencies: [
    .package(url: "https://github.com/wei18/github-rest-api-swift-openapi.git", from: "3.0.0"),
]
```

再於 target 宣告需要的 products：

```swift
.target(
    name: "YourTarget",
    dependencies: [
        .product(name: "GitHubRestAPIUsers", package: "github-rest-api-swift-openapi"),
    ]
)
```

使用 Xcode：**File ▸ Add Package Dependencies…** 並輸入本 repository 的網址。

## 快速開始

```swift
import GitHubRestAPIUsers
import OpenAPIRuntime
import OpenAPIURLSession

let client = Client(serverURL: try Servers.Server1.url(), transport: URLSessionTransport())
let users = try await client.usersList().ok.body.json
```

[教學文件](https://swiftpackageindex.com/wei18/github-rest-api-swift-openapi/main/tutorials/githubrestapiissues)
會一步步帶你完成完整範例：從加入依賴到對回應做模式比對。

### 認證

透過 `ClientMiddleware` 注入 token：

```swift
import Foundation
import GitHubRestAPIUsers
import OpenAPIRuntime
import OpenAPIURLSession
import HTTPTypes

/// 為每個請求注入 authorization header。
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

### 實戰範例：issue 留言的 upsert

<details>
<summary>有錨點就更新留言、沒有就新增 — CI 狀態留言常用的模式。</summary>

```swift
import Foundation
import GitHubRestAPIIssues
import OpenAPIRuntime
import OpenAPIURLSession
import HTTPTypes

struct GitHubRestAPIIssuesExtension {

    let owner: String
    let repo: String
    /// Issue 或 pull request 的編號。
    let number: Int

    /// 找得到錨點就更新該留言，否則建立新留言。
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

## 可用模組

每個 GitHub API 分類對應一個 library product，共 50 個。

<details>
<summary>完整模組清單</summary>

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

完整 API 介面請見
[DocC 文件](https://swiftpackageindex.com/wei18/github-rest-api-swift-openapi/documentation)。

## 運作原理

```
github/rest-api-description（git submodule，Dependabot 每週更新）
        │
        ▼  每個 OpenAPI tag 生成一個模組
swift-openapi-generator ──▶ Sources/<tag>/{Client,Types}.swift
        │
        ▼
Package.swift / .spi.yml（自動保持同步）
```

- Dependabot 每週更新 OpenAPI 描述文件；CI 重新生成所有模組、執行 smoke build 後自動合併。
- 每月自動發布 release。Release tag 來自移除 submodule 的分支，
  因此解析套件時不會下載龐大的 OpenAPI 描述 repository。

## 貢獻

`Sources/` 絕大多數是生成碼——請先閱讀 [CONTRIBUTING.md](CONTRIBUTING.md)
了解哪些檔案是手寫的、pipeline 如何運作，以及 API 不一致問題該回報到哪個上游。

## 授權

本專案採用 [MIT License](LICENSE) 授權。
