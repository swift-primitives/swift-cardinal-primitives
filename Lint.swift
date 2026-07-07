// swift-linter-tools-version: 0.1
// ===----------------------------------------------------------------------===//
//
// This source file is part of the swift-cardinal-primitives open source project
//
// Copyright (c) 2026 Coen ten Thije Boonkkamp and the swift-cardinal-primitives project authors
// Licensed under Apache License v2.0
//
// See LICENSE for license information
//
// ===----------------------------------------------------------------------===//

// Shape-γ unified consumer manifest. swift-cardinal-primitives owns the
// `Cardinal` brand-newtype. The numeric-boundary recognizer rules (`raw
// value access`, `chained rawvalue access`, `int public parameter`,
// `pointer advanced by`, `bitpattern rawvalue chain`, `unchecked call
// site`, `zero or one literal`) self-suppress on the brand owner's own
// surface via the engine's §A brand pre-pass (`Lint.Brand.owned`), so no
// per-package `.excluding(rules:)` stopgap is needed — the run declares
// `Cardinal` at namespace root, so the recognizer treats same-package
// boundary access as legitimate-by-construction while preserving cross-
// package strict-superset firing on external consumers.

import Linter
import Linter_Primitives_Rules

Lint.run(dependencies: [
    .package(
        url: "https://github.com/swift-primitives/swift-primitives-linter-rules.git",
        branch: "main",
        products: ["Linter Primitives Rules"]
    ),
]) {
    Lint.Rule.Bundle.primitives
}
