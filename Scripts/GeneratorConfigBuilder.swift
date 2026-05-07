//
//  GeneratorConfigBuilder.swift
//  GitHubRestAPISwiftOpenAPI
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

struct GeneratorConfigBuilder {

    let tagString: String

    func getTemplate() -> String {
        return #"""
        generate:
          - types
          - client

        filter:
          tags:
            - \#(tagString)

        accessModifier: public

        namingStrategy: idiomatic

        nameOverrides:
          'reactions-+1': reactionsThumbsUp
          'reactions--1': reactionsThumbsDown
        """#
    }

    init(tag: String) {
        self.tagString = tag
    }

    func write() throws {
        let fileURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
            .appendingPathComponent("Sources")
            .appendingPathComponent(tagString)
            .appendingPathComponent("openapi-generator-config.yml")
        let fileContent = getTemplate()
        guard let data = fileContent.data(using: .utf8) else {
            throw ErrorMessage(message: "Variable data not found.")
        }
        try data.write(to: fileURL)
    }

}

if let argTag = CommandLine.arguments[1]
    .split(whereSeparator: \.isNewline)
    .first {
    let tag = String(argTag)
    try GeneratorConfigBuilder(tag: tag).write()
} else {
    throw ErrorMessage(message: "Tag not found.")
}
