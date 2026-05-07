//
//  SPIManifestBuilder.swift
//  GitHubRestAPISwiftOpenAPI
//
//  Created by zwc on 2024/1/10.
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

struct SPIManifestBuilder {
    
    func getTemplate() throws -> String {
        let sources = try SourcesBuilder().sources
        let targetNamesString: String = sources.map(\.targetName)
            .map { "    - \($0)"}
            .joined(separator: "\n")
        return #"""
        version: 1
        builder:
          configs:
          - documentation_targets:
        \#(targetNamesString)
        
        """#
    }

    func write() throws {
        let fileURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
            .appendingPathComponent(".spi.yml")
        let fileContent = try getTemplate()
        guard let data = fileContent.data(using: .utf8) else {
            throw ErrorMessage(message: "Variable data not found.")
        }
        try data.write(to: fileURL)
    }

}

try SPIManifestBuilder().write()

