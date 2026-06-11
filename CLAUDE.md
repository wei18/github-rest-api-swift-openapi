# CLAUDE.md

Project architecture, the generated-vs-handwritten file split, and the make
pipeline are documented in the contributing guide — read it first:

@CONTRIBUTING.md

## Agent operational rules

- **Never hand-edit generated files**: `Sources/*/Client.swift`,
  `Sources/*/Types.swift`, and `.spi.yml`. In `Package.swift`, only the
  `sourceFolders` array between the `BEGIN/END GENERATED` markers is
  machine-written (by `Scripts/PackageBuilder.swift`); everything else in that
  file is hand-maintained Swift.
- **Regenerate, don't edit**:
  - `Package.swift` folder list: `swift Scripts/PackageBuilder.swift Package.swift`
  - `.spi.yml`: `swift package dump-package | swift Scripts/SPIManifestBuilder.swift`
- **Do not read generated sources whole** — `Sources/*/{Client,Types}.swift`
  are megabytes each. Use grep/targeted reads to inspect the generated API.
- **Verify manifest changes** with `swift package dump-package` (compare JSON
  before/after) plus a smoke build of one small module, e.g.
  `swift build --target GitHubRestAPIUsers`.
- **Commit convention for regenerated artifacts**:
  `Commit via running: make <file>` (see the `commit` helper in the Makefile).
- `swift test` hits the live GitHub API unauthenticated and can flake on rate
  limits; prefer targeted `swift build` for local verification.
- README ships in two languages: keep `README.md` and `README.zh-TW.md` in sync.
