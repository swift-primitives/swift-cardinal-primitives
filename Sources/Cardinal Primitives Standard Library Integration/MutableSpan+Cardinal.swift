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

public import Carrier_Primitives

// MARK: - MutableSpan + Cardinal.Protocol

extension Swift.MutableSpan where Element: ~Copyable {
    /// Creates a mutable span from a start address and a cardinal count.
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
    public init(
        _unsafeStart start: UnsafeMutablePointer<Element>,
        count: some Carrier.`Protocol`<Cardinal>
    ) {
        let span = unsafe Swift.MutableSpan(
            _unsafeStart: start,
            count: Int(bitPattern: count.underlying)
        )
        unsafe (self = _overrideLifetime(span, borrowing: ()))
    }
}
