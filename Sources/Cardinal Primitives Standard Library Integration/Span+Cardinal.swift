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

// MARK: - Span + Cardinal.Protocol

extension Swift.Span where Element: ~Copyable {
    /// Creates a span from a start address and a cardinal count.
    ///
    /// This initializer accepts any `Cardinal.Protocol` conformer, enabling
    /// both bare `Cardinal` and phantom-typed `Tagged<Tag, Cardinal>` as counts.
    ///
    /// - Parameters:
    ///   - start: A pointer to the start of the span.
    ///   - count: The number of elements in the span.
    /// - Warning: The caller must ensure lifetime safety.
    @_lifetime(immortal)
    @inlinable
    public init<C: Cardinal.`Protocol`>(
        _unsafeStart start: UnsafePointer<Element>,
        count: C
    ) {
        let span = unsafe Swift.Span(
            _unsafeStart: start,
            count: Int(bitPattern: count.cardinal)
        )
        self = unsafe _overrideLifetime(span, borrowing: ())
    }
}
