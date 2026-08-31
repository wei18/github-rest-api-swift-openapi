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
        // Swift Package Index rejects documentation archives over 500 MB and
        // the full 50-target archive is ~2.2 GB, so only the tutorial-bearing
        // module is documented (SwiftPackageIndex-Server#4088).
        let documentedProducts = ["GitHubRestAPIIssues"]
        let productNames = Set(manifest.products.map(\.name))
        if let missing = documentedProducts.first(where: { !productNames.contains($0) }) {
            throw ErrorMessage(message: "Documented product \(missing) not found in package manifest.")
        }
        let targetNamesString: String = documentedProducts.joined(separator: ",")
        return #"""
        version: 1
        builder:
          configs:
          - documentation_targets: [\#(targetNamesString)]

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
