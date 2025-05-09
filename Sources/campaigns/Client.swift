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
    /// List campaigns for an organization
    ///
    /// Lists campaigns in an organization.
    ///
    /// The authenticated user must be an owner or security manager for the organization to use this endpoint.
    ///
    /// OAuth app tokens and personal access tokens (classic) need the `security_events` scope to use this endpoint.
    ///
    /// - Remark: HTTP `GET /orgs/{org}/campaigns`.
    /// - Remark: Generated from `#/paths//orgs/{org}/campaigns/get(campaigns/list-org-campaigns)`.
    public func campaignsListOrgCampaigns(_ input: Operations.CampaignsListOrgCampaigns.Input) async throws -> Operations.CampaignsListOrgCampaigns.Output {
        try await client.send(
            input: input,
            forOperation: Operations.CampaignsListOrgCampaigns.id,
            serializer: { input in
                let path = try converter.renderedPath(
                    template: "/orgs/{}/campaigns",
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
                    name: "page",
                    value: input.query.page
                )
                try converter.setQueryItemAsURI(
                    in: &request,
                    style: .form,
                    explode: true,
                    name: "per_page",
                    value: input.query.perPage
                )
                try converter.setQueryItemAsURI(
                    in: &request,
                    style: .form,
                    explode: true,
                    name: "direction",
                    value: input.query.direction
                )
                try converter.setQueryItemAsURI(
                    in: &request,
                    style: .form,
                    explode: true,
                    name: "state",
                    value: input.query.state
                )
                try converter.setQueryItemAsURI(
                    in: &request,
                    style: .form,
                    explode: true,
                    name: "sort",
                    value: input.query.sort
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
                    let headers: Operations.CampaignsListOrgCampaigns.Output.Ok.Headers = .init(link: try converter.getOptionalHeaderFieldAsURI(
                        in: response.headerFields,
                        name: "Link",
                        as: Components.Headers.Link.self
                    ))
                    let contentType = converter.extractContentTypeIfPresent(in: response.headerFields)
                    let body: Operations.CampaignsListOrgCampaigns.Output.Ok.Body
                    let chosenContentType = try converter.bestContentType(
                        received: contentType,
                        options: [
                            "application/json"
                        ]
                    )
                    switch chosenContentType {
                    case "application/json":
                        body = try await converter.getResponseBodyAsJSON(
                            [Components.Schemas.CampaignSummary].self,
                            from: responseBody,
                            transforming: { value in
                                .json(value)
                            }
                        )
                    default:
                        preconditionFailure("bestContentType chose an invalid content type.")
                    }
                    return .ok(.init(
                        headers: headers,
                        body: body
                    ))
                case 404:
                    let contentType = converter.extractContentTypeIfPresent(in: response.headerFields)
                    let body: Components.Responses.NotFound.Body
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
                    return .notFound(.init(body: body))
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
    /// Create a campaign for an organization
    ///
    /// Create a campaign for an organization.
    ///
    /// The authenticated user must be an owner or security manager for the organization to use this endpoint.
    ///
    /// OAuth app tokens and personal access tokens (classic) need the `security_events` scope to use this endpoint.
    ///
    /// Fine-grained tokens must have the "Code scanning alerts" repository permissions (read) on all repositories included
    /// in the campaign.
    ///
    /// - Remark: HTTP `POST /orgs/{org}/campaigns`.
    /// - Remark: Generated from `#/paths//orgs/{org}/campaigns/post(campaigns/create-campaign)`.
    public func campaignsCreateCampaign(_ input: Operations.CampaignsCreateCampaign.Input) async throws -> Operations.CampaignsCreateCampaign.Output {
        try await client.send(
            input: input,
            forOperation: Operations.CampaignsCreateCampaign.id,
            serializer: { input in
                let path = try converter.renderedPath(
                    template: "/orgs/{}/campaigns",
                    parameters: [
                        input.path.org
                    ]
                )
                var request: HTTPTypes.HTTPRequest = .init(
                    soar_path: path,
                    method: .post
                )
                suppressMutabilityWarning(&request)
                converter.setAcceptHeader(
                    in: &request.headerFields,
                    contentTypes: input.headers.accept
                )
                let body: OpenAPIRuntime.HTTPBody?
                switch input.body {
                case let .json(value):
                    body = try converter.setRequiredRequestBodyAsJSON(
                        value,
                        headerFields: &request.headerFields,
                        contentType: "application/json; charset=utf-8"
                    )
                }
                return (request, body)
            },
            deserializer: { response, responseBody in
                switch response.status.code {
                case 200:
                    let contentType = converter.extractContentTypeIfPresent(in: response.headerFields)
                    let body: Operations.CampaignsCreateCampaign.Output.Ok.Body
                    let chosenContentType = try converter.bestContentType(
                        received: contentType,
                        options: [
                            "application/json"
                        ]
                    )
                    switch chosenContentType {
                    case "application/json":
                        body = try await converter.getResponseBodyAsJSON(
                            Components.Schemas.CampaignSummary.self,
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
                    let body: Operations.CampaignsCreateCampaign.Output.BadRequest.Body
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
                    return .badRequest(.init(body: body))
                case 404:
                    let contentType = converter.extractContentTypeIfPresent(in: response.headerFields)
                    let body: Components.Responses.NotFound.Body
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
                    return .notFound(.init(body: body))
                case 422:
                    let contentType = converter.extractContentTypeIfPresent(in: response.headerFields)
                    let body: Operations.CampaignsCreateCampaign.Output.UnprocessableContent.Body
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
                    return .unprocessableContent(.init(body: body))
                case 429:
                    return .tooManyRequests(.init())
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
    /// Get a campaign for an organization
    ///
    /// Gets a campaign for an organization.
    ///
    /// The authenticated user must be an owner or security manager for the organization to use this endpoint.
    ///
    /// OAuth app tokens and personal access tokens (classic) need the `security_events` scope to use this endpoint.
    ///
    /// - Remark: HTTP `GET /orgs/{org}/campaigns/{campaign_number}`.
    /// - Remark: Generated from `#/paths//orgs/{org}/campaigns/{campaign_number}/get(campaigns/get-campaign-summary)`.
    public func campaignsGetCampaignSummary(_ input: Operations.CampaignsGetCampaignSummary.Input) async throws -> Operations.CampaignsGetCampaignSummary.Output {
        try await client.send(
            input: input,
            forOperation: Operations.CampaignsGetCampaignSummary.id,
            serializer: { input in
                let path = try converter.renderedPath(
                    template: "/orgs/{}/campaigns/{}",
                    parameters: [
                        input.path.org,
                        input.path.campaignNumber
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
                    let body: Operations.CampaignsGetCampaignSummary.Output.Ok.Body
                    let chosenContentType = try converter.bestContentType(
                        received: contentType,
                        options: [
                            "application/json"
                        ]
                    )
                    switch chosenContentType {
                    case "application/json":
                        body = try await converter.getResponseBodyAsJSON(
                            Components.Schemas.CampaignSummary.self,
                            from: responseBody,
                            transforming: { value in
                                .json(value)
                            }
                        )
                    default:
                        preconditionFailure("bestContentType chose an invalid content type.")
                    }
                    return .ok(.init(body: body))
                case 404:
                    let contentType = converter.extractContentTypeIfPresent(in: response.headerFields)
                    let body: Components.Responses.NotFound.Body
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
                    return .notFound(.init(body: body))
                case 422:
                    let contentType = converter.extractContentTypeIfPresent(in: response.headerFields)
                    let body: Operations.CampaignsGetCampaignSummary.Output.UnprocessableContent.Body
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
                    return .unprocessableContent(.init(body: body))
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
    /// Update a campaign
    ///
    /// Updates a campaign in an organization.
    ///
    /// The authenticated user must be an owner or security manager for the organization to use this endpoint.
    ///
    /// OAuth app tokens and personal access tokens (classic) need the `security_events` scope to use this endpoint.
    ///
    /// - Remark: HTTP `PATCH /orgs/{org}/campaigns/{campaign_number}`.
    /// - Remark: Generated from `#/paths//orgs/{org}/campaigns/{campaign_number}/patch(campaigns/update-campaign)`.
    public func campaignsUpdateCampaign(_ input: Operations.CampaignsUpdateCampaign.Input) async throws -> Operations.CampaignsUpdateCampaign.Output {
        try await client.send(
            input: input,
            forOperation: Operations.CampaignsUpdateCampaign.id,
            serializer: { input in
                let path = try converter.renderedPath(
                    template: "/orgs/{}/campaigns/{}",
                    parameters: [
                        input.path.org,
                        input.path.campaignNumber
                    ]
                )
                var request: HTTPTypes.HTTPRequest = .init(
                    soar_path: path,
                    method: .patch
                )
                suppressMutabilityWarning(&request)
                converter.setAcceptHeader(
                    in: &request.headerFields,
                    contentTypes: input.headers.accept
                )
                let body: OpenAPIRuntime.HTTPBody?
                switch input.body {
                case let .json(value):
                    body = try converter.setRequiredRequestBodyAsJSON(
                        value,
                        headerFields: &request.headerFields,
                        contentType: "application/json; charset=utf-8"
                    )
                }
                return (request, body)
            },
            deserializer: { response, responseBody in
                switch response.status.code {
                case 200:
                    let contentType = converter.extractContentTypeIfPresent(in: response.headerFields)
                    let body: Operations.CampaignsUpdateCampaign.Output.Ok.Body
                    let chosenContentType = try converter.bestContentType(
                        received: contentType,
                        options: [
                            "application/json"
                        ]
                    )
                    switch chosenContentType {
                    case "application/json":
                        body = try await converter.getResponseBodyAsJSON(
                            Components.Schemas.CampaignSummary.self,
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
                    let body: Operations.CampaignsUpdateCampaign.Output.BadRequest.Body
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
                    return .badRequest(.init(body: body))
                case 404:
                    let contentType = converter.extractContentTypeIfPresent(in: response.headerFields)
                    let body: Components.Responses.NotFound.Body
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
                    return .notFound(.init(body: body))
                case 422:
                    let contentType = converter.extractContentTypeIfPresent(in: response.headerFields)
                    let body: Operations.CampaignsUpdateCampaign.Output.UnprocessableContent.Body
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
                    return .unprocessableContent(.init(body: body))
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
    /// Delete a campaign for an organization
    ///
    /// Deletes a campaign in an organization.
    ///
    /// The authenticated user must be an owner or security manager for the organization to use this endpoint.
    ///
    /// OAuth app tokens and personal access tokens (classic) need the `security_events` scope to use this endpoint.
    ///
    /// - Remark: HTTP `DELETE /orgs/{org}/campaigns/{campaign_number}`.
    /// - Remark: Generated from `#/paths//orgs/{org}/campaigns/{campaign_number}/delete(campaigns/delete-campaign)`.
    public func campaignsDeleteCampaign(_ input: Operations.CampaignsDeleteCampaign.Input) async throws -> Operations.CampaignsDeleteCampaign.Output {
        try await client.send(
            input: input,
            forOperation: Operations.CampaignsDeleteCampaign.id,
            serializer: { input in
                let path = try converter.renderedPath(
                    template: "/orgs/{}/campaigns/{}",
                    parameters: [
                        input.path.org,
                        input.path.campaignNumber
                    ]
                )
                var request: HTTPTypes.HTTPRequest = .init(
                    soar_path: path,
                    method: .delete
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
                case 204:
                    return .noContent(.init())
                case 404:
                    let contentType = converter.extractContentTypeIfPresent(in: response.headerFields)
                    let body: Components.Responses.NotFound.Body
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
                    return .notFound(.init(body: body))
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
