// ===----------------------------------------------------------------------===//
//
// This source file is part of the swift-primitives open source project
//
// Copyright (c) 2024-2026 Coen ten Thije Boonkkamp and the swift-primitives project authors
// Licensed under Apache License v2.0
//
// See LICENSE for license information
//
// ===----------------------------------------------------------------------===//

import Testing

@testable import Cardinal_Primitives

// MARK: - Test Suite Structure
//
// `Swift.Span` and `Swift.MutableSpan` are stdlib generic types the package
// does not own, so the canonical [INST-TEST-013] extension-pattern suite
// (`extension Span { @Suite struct Tests {} }`) cannot apply — Swift Testing
// rejects `@Suite`/`@Test` members in a generic context (the macro emits a
// static stored property, illegal inside a generic type). This is the
// documented generic-namespace carve-out: a top-level, non-compound
// `@Suite("Name") struct Tests`. Both `Span+Cardinal.swift` and
// `MutableSpan+Cardinal.swift` are covered by the same finding (F-001) and
// the same carve-out suite, since a second top-level `struct Tests` in this
// module would collide with this one.
@Suite("Span+Cardinal / MutableSpan+Cardinal")
struct Tests {
    @Suite struct Unit {}
    @Suite struct `Edge Case` {}
}

// MARK: - Unit
//
// F-001 regression coverage: `Span.init(_unsafeStart:count:)` and
// `MutableSpan.init(_unsafeStart:count:)` used to declare `@_lifetime(immortal)`
// and manually override the result's lifetime to borrow `()` — erasing the
// borrow dependence on `start` entirely. The fix delegates directly to the
// stdlib initializer under `@_lifetime(borrow start)`, mirroring the
// package's own `RawSpan`/`MutableRawSpan` wrappers.
//
// The erasure itself is a compile-time soundness hole (it wrongly allows the
// resulting span to be treated as unconditionally escaping), not something
// that produces a wrong runtime value — a wrapper function that falsely
// re-declares `@_lifetime(immortal)` while its body actually depends on
// `start` type-checked cleanly against the pre-fix initializer and is
// rejected (`error: lifetime-dependent value escapes its scope`) against the
// post-fix initializer. That SIL-level compile-diagnostic comparison is
// captured verbatim in REPORT.md, since `@Test`/`#expect` cannot itself
// assert "this must fail to compile" without permanently breaking the test
// target's own build. These `@Test`s instead cover the functional contract
// that the delegation rewrite must preserve: the initializers still produce
// spans with the correct pointer target, count, and (for the mutable case)
// observable mutation.

extension Tests.Unit {
    @Test
    func `Span typed-Cardinal init reads the underlying buffer`() {
        let values: [Int] = [10, 20, 30]
        unsafe values.withUnsafeBufferPointer { buffer in
            let span = unsafe Swift.Span(
                _unsafeStart: buffer.baseAddress!,
                count: Cardinal(3)
            )
            #expect(span.count == 3)
            #expect(span[0] == 10)
            #expect(span[1] == 20)
            #expect(span[2] == 30)
        }
    }

    @Test
    func `MutableSpan typed-Cardinal init reads and mutates the underlying buffer`() {
        var values: [Int] = [1, 2, 3]
        unsafe values.withUnsafeMutableBufferPointer { buffer in
            var span = unsafe Swift.MutableSpan(
                _unsafeStart: buffer.baseAddress!,
                count: Cardinal(3)
            )
            #expect(span.count == 3)
            span[0] = 99
        }
        #expect(values[0] == 99)
        #expect(values[1] == 2)
        #expect(values[2] == 3)
    }
}

// MARK: - Edge Case

extension Tests.`Edge Case` {
    @Test
    func `Span typed-Cardinal init with zero count is empty`() {
        let values: [Int] = [7]
        unsafe values.withUnsafeBufferPointer { buffer in
            let span = unsafe Swift.Span(
                _unsafeStart: buffer.baseAddress!,
                count: Cardinal(0)
            )
            // Extract to plain values first: `#expect`'s property-access path
            // requires its receiver to be Escapable, and Swift.Span is not.
            let count = span.count
            let isEmpty = span.isEmpty
            #expect(count == 0)
            #expect(isEmpty)
        }
    }

    @Test
    func `MutableSpan typed-Cardinal init with zero count is empty`() {
        var values: [Int] = [7]
        unsafe values.withUnsafeMutableBufferPointer { buffer in
            let span = unsafe Swift.MutableSpan(
                _unsafeStart: buffer.baseAddress!,
                count: Cardinal(0)
            )
            // Extract to plain values first: `#expect`'s property-access path
            // requires its receiver to be Escapable/Copyable, and
            // Swift.MutableSpan is neither.
            let count = span.count
            let isEmpty = span.isEmpty
            #expect(count == 0)
            #expect(isEmpty)
        }
    }
}
