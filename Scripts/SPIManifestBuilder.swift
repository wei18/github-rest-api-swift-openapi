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

/// Writes .spi.yml from `swift package dump-package` JSON read on stdin,
/// so the documentation target list always matches the committed manifest.
///
/// Usage: swift package dump-package | swift Scripts/SPIManifestBuilder.swift
struct SPIManifestBuilder {

    struct Manifest: Decodable {
        struct Product: Decodable {
            let name: String
        }
        let products: [Product]
    }

    func getTemplate() throws -> String {
        let data = FileHandle.standardInput.readDataToEndOfFile()
        let manifest = try JSONDecoder().decode(Manifest.self, from: data)
        let targetNamesString: String = manifest.products.map(\.name)
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
