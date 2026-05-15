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
// `Cardinal` brand-newtype, so seven consumer-side recognizer rules fire
// on legitimate-by-construction same-package access at the brand's
// boundary:
//
//   - `raw value access` — `.rawValue` accessor on the brand surface
//   - `chained rawvalue access` — `.rawValue.<method>` patterns at the
//     same boundary
//   - `int public parameter` — `Int`-parameter integration overloads
//     bridging the brand to the stdlib boundary
//   - `pointer advanced by` — same-package pointer-arithmetic shapes
//   - `bitpattern rawvalue chain` — `Int(bitPattern: cardinal.rawValue)`
//     integration overload per [INFRA-002] ("Int(bitPattern:) lives in
//     one place, once, forever")
//   - `unchecked call site` — `Cardinal(__unchecked: ...)` canonical
//     typed-system bottom-out per [CONV-016] same-package use
//   - `zero or one literal` — `Cardinal(0)` / `Cardinal(1)` constructors
//     at brand-newtype-owner sites (the rule targets external consumers)
//
// Excluding these seven rules locally preserves cross-package strict-
// superset firing.
//
// See `swift-foundations/swift-linter-rules/Research/numerics-rule-recognizer-2026-05-12.md`
// for the architectural rationale (Option 7: rule decomposition via
// bundle composition). Typed-id form mirrors the cyclic precedent
// (swift-cyclic-primitives/Lint.swift). Per Swift 6.3+
// MemberImportVisibility (SE-0444), each rule's declaring module is
// directly imported below.

import Linter
import Linter_Primitives_Rules
import Institute_Linter_Rule_Memory
import Institute_Linter_Rule_Naming
import Institute_Linter_Rule_Structure
import Institute_Linter_Rule_Unchecked
import Primitives_Linter_Rule_Cardinal
import Primitives_Linter_Rule_RawValue

Lint.run(dependencies: [
    .package(
        path: "../swift-primitives-linter-rules",
        products: [
            "Linter Primitives Rules",
            "Primitives Linter Rule Cardinal",
            "Primitives Linter Rule RawValue",
        ]
    ),
    .package(
        path: "../../swift-foundations/swift-institute-linter-rules",
        products: [
            "Institute Linter Rule Memory",
            "Institute Linter Rule Naming",
            "Institute Linter Rule Structure",
            "Institute Linter Rule Unchecked",
        ]
    ),
]) {
    Lint.Rule.Bundle.primitives.excluding(rules: [
        Lint.Rule.`raw value access`.id,
        Lint.Rule.`chained rawvalue access`.id,
        Lint.Rule.`int public parameter`.id,
        Lint.Rule.`pointer advanced by`.id,
        Lint.Rule.`bitpattern rawvalue chain`.id,
        Lint.Rule.`unchecked call site`.id,
        Lint.Rule.`zero or one literal`.id,
    ])
}
