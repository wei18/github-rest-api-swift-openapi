// Generated by swift-openapi-generator, do not modify.
@_spi(Generated) import OpenAPIRuntime
#if os(Linux)
@preconcurrency import struct Foundation.URL
@preconcurrency import struct Foundation.Data
@preconcurrency import struct Foundation.Date
#else
import struct Foundation.URL
import struct Foundation.Data
import struct Foundation.Date
#endif
import HTTPTypes
/// GitHub's v3 REST API.
public struct Client: APIProtocol {
    /// The underlying HTTP client.
    private let client: UniversalClient
    /// Creates a new client.
    /// - Parameters:
    ///   - serverURL: The server URL that the client connects to. Any server
    ///   URLs defined in the OpenAPI document are available as static methods
    ///   on the ``Servers`` type.
    ///   - configuration: A set of configuration values for the client.
    ///   - transport: A transport that performs HTTP operations.
    ///   - middlewares: A list of middlewares to call before the transport.
    public init(
        serverURL: Foundation.URL,
        configuration: Configuration = .init(),
        transport: any ClientTransport,
        middlewares: [any ClientMiddleware] = []
    ) {
        self.client = .init(
            serverURL: serverURL,
            configuration: configuration,
            transport: transport,
            middlewares: middlewares
        )
    }
    private var converter: Converter {
        client.converter
    }
    /// Get billing usage report for an organization
    ///
    /// Gets a report of the total usage for an organization. To use this endpoint, you must be an administrator of an organization within an enterprise or an organization account.
    ///
    /// **Note:** This endpoint is only available to organizations with access to the enhanced billing platform. For more information, see "[About the enhanced billing platform](https://docs.github.com/billing/using-the-new-billing-platform)."
    ///
    /// - Remark: HTTP `GET /organizations/{org}/settings/billing/usage`.
    /// - Remark: Generated from `#/paths//organizations/{org}/settings/billing/usage/get(billing/get-github-billing-usage-report-org)`.
    public func billingGetGithubBillingUsageReportOrg(_ input: Operations.BillingGetGithubBillingUsageReportOrg.Input) async throws -> Operations.BillingGetGithubBillingUsageReportOrg.Output {
        try await client.send(
            input: input,
            forOperation: Operations.BillingGetGithubBillingUsageReportOrg.id,
            serializer: { input in
                let path = try converter.renderedPath(
                    template: "/organizations/{}/settings/billing/usage",
                    parameters: [
                        input.path.org
                    ]
                )
                var request: HTTPTypes.HTTPRequest = .init(
                    soar_path: path,
                    method: .get
                )
                suppressMutabilityWarning(&request)
                try converter.setQueryItemAsURI(
                    in: &request,
                    style: .form,
                    explode: true,
                    name: "year",
                    value: input.query.year
                )
                try converter.setQueryItemAsURI(
                    in: &request,
                    style: .form,
                    explode: true,
                    name: "month",
                    value: input.query.month
                )
                try converter.setQueryItemAsURI(
                    in: &request,
                    style: .form,
                    explode: true,
                    name: "day",
                    value: input.query.day
                )
                try converter.setQueryItemAsURI(
                    in: &request,
                    style: .form,
                    explode: true,
                    name: "hour",
                    value: input.query.hour
                )
                converter.setAcceptHeader(
                    in: &request.headerFields,
                    contentTypes: input.headers.accept
                )
                return (request, nil)
            },
            deserializer: { response, responseBody in
                switch response.status.code {
                case 200:
                    let contentType = converter.extractContentTypeIfPresent(in: response.headerFields)
                    let body: Components.Responses.BillingUsageReportOrg.Body
                    let chosenContentType = try converter.bestContentType(
                        received: contentType,
                        options: [
                            "application/json"
                        ]
                    )
                    switch chosenContentType {
                    case "application/json":
                        body = try await converter.getResponseBodyAsJSON(
                            Components.Schemas.BillingUsageReport.self,
                            from: responseBody,
                            transforming: { value in
                                .json(value)
                            }
                        )
                    default:
                        preconditionFailure("bestContentType chose an invalid content type.")
                    }
                    return .ok(.init(body: body))
                case 400:
                    let contentType = converter.extractContentTypeIfPresent(in: response.headerFields)
                    let body: Components.Responses.BadRequest.Body
                    let chosenContentType = try converter.bestContentType(
                        received: contentType,
                        options: [
                            "application/json",
                            "application/scim+json"
                        ]
                    )
                    switch chosenContentType {
                    case "application/json":
                        body = try await converter.getResponseBodyAsJSON(
                            Components.Schemas.BasicError.self,
                            from: responseBody,
                            transforming: { value in
                                .json(value)
                            }
                        )
                    case "application/scim+json":
                        body = try await converter.getResponseBodyAsJSON(
                            Components.Schemas.ScimError.self,
                            from: responseBody,
                            transforming: { value in
                                .applicationScimJson(value)
                            }
                        )
                    default:
                        preconditionFailure("bestContentType chose an invalid content type.")
                    }
                    return .badRequest(.init(body: body))
                case 403:
                    let contentType = converter.extractContentTypeIfPresent(in: response.headerFields)
                    let body: Components.Responses.Forbidden.Body
                    let chosenContentType = try converter.bestContentType(
                        received: contentType,
                        options: [
                            "application/json"
                        ]
                    )
                    switch chosenContentType {
                    case "application/json":
                        body = try await converter.getResponseBodyAsJSON(
                            Components.Schemas.BasicError.self,
                            from: responseBody,
                            transforming: { value in
                                .json(value)
                            }
                        )
                    default:
                        preconditionFailure("bestContentType chose an invalid content type.")
                    }
                    return .forbidden(.init(body: body))
                case 500:
                    let contentType = converter.extractContentTypeIfPresent(in: response.headerFields)
                    let body: Components.Responses.InternalError.Body
                    let chosenContentType = try converter.bestContentType(
                        received: contentType,
                        options: [
                            "application/json"
                        ]
                    )
                    switch chosenContentType {
                    case "application/json":
                        body = try await converter.getResponseBodyAsJSON(
                            Components.Schemas.BasicError.self,
                            from: responseBody,
                            transforming: { value in
                                .json(value)
                            }
                        )
                    default:
                        preconditionFailure("bestContentType chose an invalid content type.")
                    }
                    return .internalServerError(.init(body: body))
                case 503:
                    let contentType = converter.extractContentTypeIfPresent(in: response.headerFields)
                    let body: Components.Responses.ServiceUnavailable.Body
                    let chosenContentType = try converter.bestContentType(
                        received: contentType,
                        options: [
                            "application/json"
                        ]
                    )
                    switch chosenContentType {
                    case "application/json":
                        body = try await converter.getResponseBodyAsJSON(
                            Components.Responses.ServiceUnavailable.Body.JsonPayload.self,
                            from: responseBody,
                            transforming: { value in
                                .json(value)
                            }
                        )
                    default:
                        preconditionFailure("bestContentType chose an invalid content type.")
                    }
                    return .serviceUnavailable(.init(body: body))
                default:
                    return .undocumented(
                        statusCode: response.status.code,
                        .init(
                            headerFields: response.headerFields,
                            body: responseBody
                        )
                    )
                }
            }
        )
    }
    /// Get GitHub Actions billing for an organization
    ///
    /// Gets the summary of the free and paid GitHub Actions minutes used.
    ///
    /// Paid minutes only apply to workflows in private repositories that use GitHub-hosted runners. Minutes used is listed for each GitHub-hosted runner operating system. Any job re-runs are also included in the usage. The usage returned includes any minute multipliers for macOS and Windows runners, and is rounded up to the nearest whole minute. For more information, see "[Managing billing for GitHub Actions](https://docs.github.com/github/setting-up-and-managing-billing-and-payments-on-github/managing-billing-for-github-actions)".
    ///
    /// OAuth app tokens and personal access tokens (classic) need the `repo` or `admin:org` scope to use this endpoint.
    ///
    /// - Remark: HTTP `GET /orgs/{org}/settings/billing/actions`.
    /// - Remark: Generated from `#/paths//orgs/{org}/settings/billing/actions/get(billing/get-github-actions-billing-org)`.
    public func billingGetGithubActionsBillingOrg(_ input: Operations.BillingGetGithubActionsBillingOrg.Input) async throws -> Operations.BillingGetGithubActionsBillingOrg.Output {
        try await client.send(
            input: input,
            forOperation: Operations.BillingGetGithubActionsBillingOrg.id,
            serializer: { input in
                let path = try converter.renderedPath(
                    template: "/orgs/{}/settings/billing/actions",
                    parameters: [
                        input.path.org
                    ]
                )
                var request: HTTPTypes.HTTPRequest = .init(
                    soar_path: path,
                    method: .get
                )
                suppressMutabilityWarning(&request)
                converter.setAcceptHeader(
                    in: &request.headerFields,
                    contentTypes: input.headers.accept
                )
                return (request, nil)
            },
            deserializer: { response, responseBody in
                switch response.status.code {
                case 200:
                    let contentType = converter.extractContentTypeIfPresent(in: response.headerFields)
                    let body: Operations.BillingGetGithubActionsBillingOrg.Output.Ok.Body
                    let chosenContentType = try converter.bestContentType(
                        received: contentType,
                        options: [
                            "application/json"
                        ]
                    )
                    switch chosenContentType {
                    case "application/json":
                        body = try await converter.getResponseBodyAsJSON(
                            Components.Schemas.ActionsBillingUsage.self,
                            from: responseBody,
                            transforming: { value in
                                .json(value)
                            }
                        )
                    default:
                        preconditionFailure("bestContentType chose an invalid content type.")
                    }
                    return .ok(.init(body: body))
                default:
                    return .undocumented(
                        statusCode: response.status.code,
                        .init(
                            headerFields: response.headerFields,
                            body: responseBody
                        )
                    )
                }
            }
        )
    }
    /// Get GitHub Packages billing for an organization
    ///
    /// Gets the free and paid storage used for GitHub Packages in gigabytes.
    ///
    /// Paid minutes only apply to packages stored for private repositories. For more information, see "[Managing billing for GitHub Packages](https://docs.github.com/github/setting-up-and-managing-billing-and-payments-on-github/managing-billing-for-github-packages)."
    ///
    /// OAuth app tokens and personal access tokens (classic) need the `repo` or `admin:org` scope to use this endpoint.
    ///
    /// - Remark: HTTP `GET /orgs/{org}/settings/billing/packages`.
    /// - Remark: Generated from `#/paths//orgs/{org}/settings/billing/packages/get(billing/get-github-packages-billing-org)`.
    public func billingGetGithubPackagesBillingOrg(_ input: Operations.BillingGetGithubPackagesBillingOrg.Input) async throws -> Operations.BillingGetGithubPackagesBillingOrg.Output {
        try await client.send(
            input: input,
            forOperation: Operations.BillingGetGithubPackagesBillingOrg.id,
            serializer: { input in
                let path = try converter.renderedPath(
                    template: "/orgs/{}/settings/billing/packages",
                    parameters: [
                        input.path.org
                    ]
                )
                var request: HTTPTypes.HTTPRequest = .init(
                    soar_path: path,
                    method: .get
                )
                suppressMutabilityWarning(&request)
                converter.setAcceptHeader(
                    in: &request.headerFields,
                    contentTypes: input.headers.accept
                )
                return (request, nil)
            },
            deserializer: { response, responseBody in
                switch response.status.code {
                case 200:
                    let contentType = converter.extractContentTypeIfPresent(in: response.headerFields)
                    let body: Operations.BillingGetGithubPackagesBillingOrg.Output.Ok.Body
                    let chosenContentType = try converter.bestContentType(
                        received: contentType,
                        options: [
                            "application/json"
                        ]
                    )
                    switch chosenContentType {
                    case "application/json":
                        body = try await converter.getResponseBodyAsJSON(
                            Components.Schemas.PackagesBillingUsage.self,
                            from: responseBody,
                            transforming: { value in
                                .json(value)
                            }
                        )
                    default:
                        preconditionFailure("bestContentType chose an invalid content type.")
                    }
                    return .ok(.init(body: body))
                default:
                    return .undocumented(
                        statusCode: response.status.code,
                        .init(
                            headerFields: response.headerFields,
                            body: responseBody
                        )
                    )
                }
            }
        )
    }
    /// Get shared storage billing for an organization
    ///
    /// Gets the estimated paid and estimated total storage used for GitHub Actions and GitHub Packages.
    ///
    /// Paid minutes only apply to packages stored for private repositories. For more information, see "[Managing billing for GitHub Packages](https://docs.github.com/github/setting-up-and-managing-billing-and-payments-on-github/managing-billing-for-github-packages)."
    ///
    /// OAuth app tokens and personal access tokens (classic) need the `repo` or `admin:org` scope to use this endpoint.
    ///
    /// - Remark: HTTP `GET /orgs/{org}/settings/billing/shared-storage`.
    /// - Remark: Generated from `#/paths//orgs/{org}/settings/billing/shared-storage/get(billing/get-shared-storage-billing-org)`.
    public func billingGetSharedStorageBillingOrg(_ input: Operations.BillingGetSharedStorageBillingOrg.Input) async throws -> Operations.BillingGetSharedStorageBillingOrg.Output {
        try await client.send(
            input: input,
            forOperation: Operations.BillingGetSharedStorageBillingOrg.id,
            serializer: { input in
                let path = try converter.renderedPath(
                    template: "/orgs/{}/settings/billing/shared-storage",
                    parameters: [
                        input.path.org
                    ]
                )
                var request: HTTPTypes.HTTPRequest = .init(
                    soar_path: path,
                    method: .get
                )
                suppressMutabilityWarning(&request)
                converter.setAcceptHeader(
                    in: &request.headerFields,
                    contentTypes: input.headers.accept
                )
                return (request, nil)
            },
            deserializer: { response, responseBody in
                switch response.status.code {
                case 200:
                    let contentType = converter.extractContentTypeIfPresent(in: response.headerFields)
                    let body: Operations.BillingGetSharedStorageBillingOrg.Output.Ok.Body
                    let chosenContentType = try converter.bestContentType(
                        received: contentType,
                        options: [
                            "application/json"
                        ]
                    )
                    switch chosenContentType {
                    case "application/json":
                        body = try await converter.getResponseBodyAsJSON(
                            Components.Schemas.CombinedBillingUsage.self,
                            from: responseBody,
                            transforming: { value in
                                .json(value)
                            }
                        )
                    default:
                        preconditionFailure("bestContentType chose an invalid content type.")
                    }
                    return .ok(.init(body: body))
                default:
                    return .undocumented(
                        statusCode: response.status.code,
                        .init(
                            headerFields: response.headerFields,
                            body: responseBody
                        )
                    )
                }
            }
        )
    }
    /// Get GitHub Actions billing for a user
    ///
    /// Gets the summary of the free and paid GitHub Actions minutes used.
    ///
    /// Paid minutes only apply to workflows in private repositories that use GitHub-hosted runners. Minutes used is listed for each GitHub-hosted runner operating system. Any job re-runs are also included in the usage. The usage returned includes any minute multipliers for macOS and Windows runners, and is rounded up to the nearest whole minute. For more information, see "[Managing billing for GitHub Actions](https://docs.github.com/github/setting-up-and-managing-billing-and-payments-on-github/managing-billing-for-github-actions)".
    ///
    /// OAuth app tokens and personal access tokens (classic) need the `user` scope to use this endpoint.
    ///
    /// - Remark: HTTP `GET /users/{username}/settings/billing/actions`.
    /// - Remark: Generated from `#/paths//users/{username}/settings/billing/actions/get(billing/get-github-actions-billing-user)`.
    public func billingGetGithubActionsBillingUser(_ input: Operations.BillingGetGithubActionsBillingUser.Input) async throws -> Operations.BillingGetGithubActionsBillingUser.Output {
        try await client.send(
            input: input,
            forOperation: Operations.BillingGetGithubActionsBillingUser.id,
            serializer: { input in
                let path = try converter.renderedPath(
                    template: "/users/{}/settings/billing/actions",
                    parameters: [
                        input.path.username
                    ]
                )
                var request: HTTPTypes.HTTPRequest = .init(
                    soar_path: path,
                    method: .get
                )
                suppressMutabilityWarning(&request)
                converter.setAcceptHeader(
                    in: &request.headerFields,
                    contentTypes: input.headers.accept
                )
                return (request, nil)
            },
            deserializer: { response, responseBody in
                switch response.status.code {
                case 200:
                    let contentType = converter.extractContentTypeIfPresent(in: response.headerFields)
                    let body: Operations.BillingGetGithubActionsBillingUser.Output.Ok.Body
                    let chosenContentType = try converter.bestContentType(
                        received: contentType,
                        options: [
                            "application/json"
                        ]
                    )
                    switch chosenContentType {
                    case "application/json":
                        body = try await converter.getResponseBodyAsJSON(
                            Components.Schemas.ActionsBillingUsage.self,
                            from: responseBody,
                            transforming: { value in
                                .json(value)
                            }
                        )
                    default:
                        preconditionFailure("bestContentType chose an invalid content type.")
                    }
                    return .ok(.init(body: body))
                default:
                    return .undocumented(
                        statusCode: response.status.code,
                        .init(
                            headerFields: response.headerFields,
                            body: responseBody
                        )
                    )
                }
            }
        )
    }
    /// Get GitHub Packages billing for a user
    ///
    /// Gets the free and paid storage used for GitHub Packages in gigabytes.
    ///
    /// Paid minutes only apply to packages stored for private repositories. For more information, see "[Managing billing for GitHub Packages](https://docs.github.com/github/setting-up-and-managing-billing-and-payments-on-github/managing-billing-for-github-packages)."
    ///
    /// OAuth app tokens and personal access tokens (classic) need the `user` scope to use this endpoint.
    ///
    /// - Remark: HTTP `GET /users/{username}/settings/billing/packages`.
    /// - Remark: Generated from `#/paths//users/{username}/settings/billing/packages/get(billing/get-github-packages-billing-user)`.
    public func billingGetGithubPackagesBillingUser(_ input: Operations.BillingGetGithubPackagesBillingUser.Input) async throws -> Operations.BillingGetGithubPackagesBillingUser.Output {
        try await client.send(
            input: input,
            forOperation: Operations.BillingGetGithubPackagesBillingUser.id,
            serializer: { input in
                let path = try converter.renderedPath(
                    template: "/users/{}/settings/billing/packages",
                    parameters: [
                        input.path.username
                    ]
                )
                var request: HTTPTypes.HTTPRequest = .init(
                    soar_path: path,
                    method: .get
                )
                suppressMutabilityWarning(&request)
                converter.setAcceptHeader(
                    in: &request.headerFields,
                    contentTypes: input.headers.accept
                )
                return (request, nil)
            },
            deserializer: { response, responseBody in
                switch response.status.code {
                case 200:
                    let contentType = converter.extractContentTypeIfPresent(in: response.headerFields)
                    let body: Operations.BillingGetGithubPackagesBillingUser.Output.Ok.Body
                    let chosenContentType = try converter.bestContentType(
                        received: contentType,
                        options: [
                            "application/json"
                        ]
                    )
                    switch chosenContentType {
                    case "application/json":
                        body = try await converter.getResponseBodyAsJSON(
                            Components.Schemas.PackagesBillingUsage.self,
                            from: responseBody,
                            transforming: { value in
                                .json(value)
                            }
                        )
                    default:
                        preconditionFailure("bestContentType chose an invalid content type.")
                    }
                    return .ok(.init(body: body))
                default:
                    return .undocumented(
                        statusCode: response.status.code,
                        .init(
                            headerFields: response.headerFields,
                            body: responseBody
                        )
                    )
                }
            }
        )
    }
    /// Get shared storage billing for a user
    ///
    /// Gets the estimated paid and estimated total storage used for GitHub Actions and GitHub Packages.
    ///
    /// Paid minutes only apply to packages stored for private repositories. For more information, see "[Managing billing for GitHub Packages](https://docs.github.com/github/setting-up-and-managing-billing-and-payments-on-github/managing-billing-for-github-packages)."
    ///
    /// OAuth app tokens and personal access tokens (classic) need the `user` scope to use this endpoint.
    ///
    /// - Remark: HTTP `GET /users/{username}/settings/billing/shared-storage`.
    /// - Remark: Generated from `#/paths//users/{username}/settings/billing/shared-storage/get(billing/get-shared-storage-billing-user)`.
    public func billingGetSharedStorageBillingUser(_ input: Operations.BillingGetSharedStorageBillingUser.Input) async throws -> Operations.BillingGetSharedStorageBillingUser.Output {
        try await client.send(
            input: input,
            forOperation: Operations.BillingGetSharedStorageBillingUser.id,
            serializer: { input in
                let path = try converter.renderedPath(
                    template: "/users/{}/settings/billing/shared-storage",
                    parameters: [
                        input.path.username
                    ]
                )
                var request: HTTPTypes.HTTPRequest = .init(
                    soar_path: path,
                    method: .get
                )
                suppressMutabilityWarning(&request)
                converter.setAcceptHeader(
                    in: &request.headerFields,
                    contentTypes: input.headers.accept
                )
                return (request, nil)
            },
            deserializer: { response, responseBody in
                switch response.status.code {
                case 200:
                    let contentType = converter.extractContentTypeIfPresent(in: response.headerFields)
                    let body: Operations.BillingGetSharedStorageBillingUser.Output.Ok.Body
                    let chosenContentType = try converter.bestContentType(
                        received: contentType,
                        options: [
                            "application/json"
                        ]
                    )
                    switch chosenContentType {
                    case "application/json":
                        body = try await converter.getResponseBodyAsJSON(
                            Components.Schemas.CombinedBillingUsage.self,
                            from: responseBody,
                            transforming: { value in
                                .json(value)
                            }
                        )
                    default:
                        preconditionFailure("bestContentType chose an invalid content type.")
                    }
                    return .ok(.init(body: body))
                default:
                    return .undocumented(
                        statusCode: response.status.code,
                        .init(
                            headerFields: response.headerFields,
                            body: responseBody
                        )
                    )
                }
            }
        )
    }
    /// Get billing usage report for a user
    ///
    /// Gets a report of the total usage for a user.
    ///
    /// **Note:** This endpoint is only available to users with access to the enhanced billing platform.
    ///
    /// - Remark: HTTP `GET /users/{username}/settings/billing/usage`.
    /// - Remark: Generated from `#/paths//users/{username}/settings/billing/usage/get(billing/get-github-billing-usage-report-user)`.
    public func billingGetGithubBillingUsageReportUser(_ input: Operations.BillingGetGithubBillingUsageReportUser.Input) async throws -> Operations.BillingGetGithubBillingUsageReportUser.Output {
        try await client.send(
            input: input,
            forOperation: Operations.BillingGetGithubBillingUsageReportUser.id,
            serializer: { input in
                let path = try converter.renderedPath(
                    template: "/users/{}/settings/billing/usage",
                    parameters: [
                        input.path.username
                    ]
                )
                var request: HTTPTypes.HTTPRequest = .init(
                    soar_path: path,
                    method: .get
                )
                suppressMutabilityWarning(&request)
                try converter.setQueryItemAsURI(
                    in: &request,
                    style: .form,
                    explode: true,
                    name: "year",
                    value: input.query.year
                )
                try converter.setQueryItemAsURI(
                    in: &request,
                    style: .form,
                    explode: true,
                    name: "month",
                    value: input.query.month
                )
                try converter.setQueryItemAsURI(
                    in: &request,
                    style: .form,
                    explode: true,
                    name: "day",
                    value: input.query.day
                )
                try converter.setQueryItemAsURI(
                    in: &request,
                    style: .form,
                    explode: true,
                    name: "hour",
                    value: input.query.hour
                )
                converter.setAcceptHeader(
                    in: &request.headerFields,
                    contentTypes: input.headers.accept
                )
                return (request, nil)
            },
            deserializer: { response, responseBody in
                switch response.status.code {
                case 200:
                    let contentType = converter.extractContentTypeIfPresent(in: response.headerFields)
                    let body: Components.Responses.BillingUsageReportUser.Body
                    let chosenContentType = try converter.bestContentType(
                        received: contentType,
                        options: [
                            "application/json"
                        ]
                    )
                    switch chosenContentType {
                    case "application/json":
                        body = try await converter.getResponseBodyAsJSON(
                            Components.Schemas.BillingUsageReportUser.self,
                            from: responseBody,
                            transforming: { value in
                                .json(value)
                            }
                        )
                    default:
                        preconditionFailure("bestContentType chose an invalid content type.")
                    }
                    return .ok(.init(body: body))
                case 400:
                    let contentType = converter.extractContentTypeIfPresent(in: response.headerFields)
                    let body: Components.Responses.BadRequest.Body
                    let chosenContentType = try converter.bestContentType(
                        received: contentType,
                        options: [
                            "application/json",
                            "application/scim+json"
                        ]
                    )
                    switch chosenContentType {
                    case "application/json":
                        body = try await converter.getResponseBodyAsJSON(
                            Components.Schemas.BasicError.self,
                            from: responseBody,
                            transforming: { value in
                                .json(value)
                            }
                        )
                    case "application/scim+json":
                        body = try await converter.getResponseBodyAsJSON(
                            Components.Schemas.ScimError.self,
                            from: responseBody,
                            transforming: { value in
                                .applicationScimJson(value)
                            }
                        )
                    default:
                        preconditionFailure("bestContentType chose an invalid content type.")
                    }
                    return .badRequest(.init(body: body))
                case 403:
                    let contentType = converter.extractContentTypeIfPresent(in: response.headerFields)
                    let body: Components.Responses.Forbidden.Body
                    let chosenContentType = try converter.bestContentType(
                        received: contentType,
                        options: [
                            "application/json"
                        ]
                    )
                    switch chosenContentType {
                    case "application/json":
                        body = try await converter.getResponseBodyAsJSON(
                            Components.Schemas.BasicError.self,
                            from: responseBody,
                            transforming: { value in
                                .json(value)
                            }
                        )
                    default:
                        preconditionFailure("bestContentType chose an invalid content type.")
                    }
                    return .forbidden(.init(body: body))
                case 500:
                    let contentType = converter.extractContentTypeIfPresent(in: response.headerFields)
                    let body: Components.Responses.InternalError.Body
                    let chosenContentType = try converter.bestContentType(
                        received: contentType,
                        options: [
                            "application/json"
                        ]
                    )
                    switch chosenContentType {
                    case "application/json":
                        body = try await converter.getResponseBodyAsJSON(
                            Components.Schemas.BasicError.self,
                            from: responseBody,
                            transforming: { value in
                                .json(value)
                            }
                        )
                    default:
                        preconditionFailure("bestContentType chose an invalid content type.")
                    }
                    return .internalServerError(.init(body: body))
                case 503:
                    let contentType = converter.extractContentTypeIfPresent(in: response.headerFields)
                    let body: Components.Responses.ServiceUnavailable.Body
                    let chosenContentType = try converter.bestContentType(
                        received: contentType,
                        options: [
                            "application/json"
                        ]
                    )
                    switch chosenContentType {
                    case "application/json":
                        body = try await converter.getResponseBodyAsJSON(
                            Components.Responses.ServiceUnavailable.Body.JsonPayload.self,
                            from: responseBody,
                            transforming: { value in
                                .json(value)
                            }
                        )
                    default:
                        preconditionFailure("bestContentType chose an invalid content type.")
                    }
                    return .serviceUnavailable(.init(body: body))
                default:
                    return .undocumented(
                        statusCode: response.status.code,
                        .init(
                            headerFields: response.headerFields,
                            body: responseBody
                        )
                    )
                }
            }
        )
    }
}
