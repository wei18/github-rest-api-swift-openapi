import Foundation
import GitHubRestAPIIssues
import OpenAPIRuntime
import OpenAPIURLSession

let client = Client(
    serverURL: try Servers.Server1.url(),
    transport: URLSessionTransport()
)

let response = try await client.issuesListComments(
    path: .init(owner: "Wei18", repo: "github-rest-api-swift-openapi", issueNumber: 4)
)

switch response {
case .ok(let okResponse):
    let comments = try okResponse.body.json
    for comment in comments {
        print(comment.body ?? "(no content)")
    }
case .undocumented(statusCode: let statusCode, _):
    print("🥺 undocumented response: \(statusCode)")
}
