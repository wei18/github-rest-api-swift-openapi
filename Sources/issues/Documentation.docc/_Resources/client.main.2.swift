import Foundation
import GitHubRestAPIIssues
import OpenAPIRuntime
import OpenAPIURLSession

let client = Client(
    serverURL: try Servers.Server1.url(),
    transport: URLSessionTransport()
)
