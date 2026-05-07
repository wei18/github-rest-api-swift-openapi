//
//  PackageBuilder.swift
//  github-rest-api-swift-openapi
//
//  Created by zwc on 2024/1/6.
//

import Foundation

struct ErrorMessage: LocalizedError {
    var message: String
    var errorDescription: String? { message }
    init(message: String, line: Int = #line) {
        self.message = "\(line): \(message)"
    }
}

/// The generator supports filtering the OpenAPI document prior to generation,
/// which can be useful when generating client code for a subset of a large API,
/// or splitting an implementation of a server across multiple modules.
struct SourcesBuilder {

    struct Source {
        let folderName: String
        let targetName: String
        var sourcePath: String { "Sources/\(folderName)" }
        var productString: String {
            #"""
                    .library(name: "\#(targetName)", targets: ["\#(targetName)"]),
            """#
        }
        var targetString: String {
            #"""
                    .target(
                        name: "\#(targetName)",
                        dependencies: [
                            .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                            .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
                        ],
                        path: "\#(sourcePath)"
                    ),
            """#
        }
    }

    private(set) var sources: [SourcesBuilder.Source] = []

    init() throws {
        let directoryURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
            .appendingPathComponent("Sources")
        let resourceKeys = Set<URLResourceKey>([.nameKey, .isDirectoryKey])

        guard let directoryEnumerator = FileManager.default.enumerator(
            at: directoryURL,
            includingPropertiesForKeys: Array(resourceKeys),
            options: .skipsHiddenFiles) else {
            throw ErrorMessage(message: "Variable directoryEnumerator not found.")
        }

        let sourceURLs = directoryEnumerator.compactMap { $0 as? URL }.filter { fileURL in
            guard let resourceValues = try? fileURL.resourceValues(forKeys: resourceKeys),
                  let isDirectory = resourceValues.isDirectory,
                  isDirectory,
                  fileURL.pathComponents.count == directoryURL.pathComponents.count + 1 // Check if it's a direct child
            else { return false }
            return true
        }

        sources = sourceURLs.map(\.lastPathComponent).sorted().map {
            let folderName = $0
            let targetName = folderName.split(separator: "-").map { $0.prefix(1).uppercased() + $0.dropFirst() }.joined()
            return Source(folderName: folderName, targetName: "GitHubRestAPI\(targetName)")
        }
    }
}

struct PackageBuilder {

    enum SwiftVersion: String {
        case v5_9 = "5.9"

        init?(rawValue: String) {
            switch rawValue {
            case SwiftVersion.v5_9.fileName: self = .v5_9
            default: return nil
            }
        }

        var fileName: String { "Package.swift" }

        var platformsString: String {
            #"""
                    .macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6), .visionOS(.v1),
            """#
        }
    }

    private let version: PackageBuilder.SwiftVersion

    init(version string: String) throws {
        if let version = PackageBuilder.SwiftVersion(rawValue: string) {
            self.version = version
        } else {
            throw ErrorMessage(message: "Convert string value `\(string)` to Type SwiftVersion failure.")
        }
    }

    private func getTemplate() throws -> String {
        let sources = try SourcesBuilder().sources
        let productsString: String = sources.map(\.productString).joined(separator: "\n")
        let targetsString: String = sources.map(\.targetString).joined(separator: "\n")
        return #"""
        // swift-tools-version: \#(version.rawValue)
        // The swift-tools-version declares the minimum version of Swift required to build this package.

        import Foundation
        import PackageDescription

        /// Generated via `$swift PackageBuilder.swift`
        let package = Package(
            name: "GitHubRestAPISwiftOpenAPI",
            platforms: [
        \#(version.platformsString)
            ],
            products: [
        \#(productsString)
            ],
            dependencies: [
                .package(url: "https://github.com/apple/swift-openapi-runtime", from: "1.0.0"),
                .package(url: "https://github.com/apple/swift-openapi-urlsession", from: "1.0.0"),
            ],
            targets: [
        \#(targetsString)
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

        """#
    }
    func write() throws {
        let fileURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
            .appendingPathComponent(version.fileName)
        let fileContent = try getTemplate()
        guard let data = fileContent.data(using: .utf8) else {
            throw ErrorMessage(message: "Variable data not found.")
        }
        try data.write(to: fileURL)
    }

}

if let argVersion = CommandLine.arguments[1]
    .split(whereSeparator: \.isNewline)
    .first {
    let version = String(argVersion)
    try PackageBuilder(version: version).write()
} else {
    throw ErrorMessage(message: "Tag not found.")
}














