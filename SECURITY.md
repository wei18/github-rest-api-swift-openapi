# Security Policy

## Supported Versions

Only the latest release receives updates. This package is regenerated
automatically from [github/rest-api-description](https://github.com/github/rest-api-description),
so upstream fixes land in the next scheduled monthly release.

| Version        | Supported          |
| -------------- | ------------------ |
| Latest release | :white_check_mark: |
| Older releases | :x:                |

Dependencies are monitored by Dependabot:

- Swift packages (`Package.swift`)
- GitHub Actions workflows
- Git submodule ([github/rest-api-description](https://github.com/github/rest-api-description))

## Reporting a Vulnerability

- For vulnerabilities in this package's build scripts or release pipeline,
  please [open a new issue](https://github.com/Wei18/github-rest-api-swift-openapi/issues).
- For issues in the generated client code itself, report to
  [apple/swift-openapi-generator](https://github.com/apple/swift-openapi-generator/issues).
- For inaccuracies in GitHub's OpenAPI description, report to
  [github/rest-api-description](https://github.com/github/rest-api-description/issues/new?template=schema-inaccuracy.md).

We appreciate your responsible disclosure and will strive to respond promptly.
