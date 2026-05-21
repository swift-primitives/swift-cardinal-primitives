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
    public init(
        _unsafeStart start: UnsafePointer<Element>,
        count: some Carrier.`Protocol`<Cardinal>
    ) {
        let span = unsafe Swift.Span(
            _unsafeStart: start,
            count: Int(bitPattern: count.underlying)
        )
        unsafe (self = _overrideLifetime(span, borrowing: ()))
    }

    /// Returns a span over the first `maxLength` elements.
    ///
    /// Typed-Cardinal overload mirroring stdlib's
    /// `Span.extracting(first: Int) -> Self`. Accepts any
    /// `Carrier.`Protocol`<Cardinal>` conformer (bare `Cardinal` or
    /// phantom-typed `Tagged<Tag, Cardinal>` / `Index<Element>.Count`),
    /// removing the `Int(bitPattern:)` dance at the call site.
    ///
    /// - Parameter maxLength: The maximum number of elements to extract.
    /// - Returns: A span over the prefix.
    @inlinable
    @_lifetime(copy self)
    public func extracting(first maxLength: some Carrier.`Protocol`<Cardinal>) -> Self {
        self.extracting(first: Int(bitPattern: maxLength.underlying))
    }

    /// Returns a span with the first `k` elements removed.
    ///
    /// Typed-Cardinal overload mirroring stdlib's
    /// `Span.extracting(droppingFirst: Int) -> Self`.
    ///
    /// - Parameter k: The number of leading elements to drop.
    /// - Returns: A span over the elements after the dropped prefix.
    @inlinable
    @_lifetime(copy self)
    public func extracting(droppingFirst k: some Carrier.`Protocol`<Cardinal>) -> Self {
        self.extracting(droppingFirst: Int(bitPattern: k.underlying))
    }

    /// Returns a span over the last `maxLength` elements.
    ///
    /// Typed-Cardinal overload mirroring stdlib's
    /// `Span.extracting(last: Int) -> Self`.
    ///
    /// - Parameter maxLength: The maximum number of trailing elements to extract.
    /// - Returns: A span over the suffix.
    @inlinable
    @_lifetime(copy self)
    public func extracting(last maxLength: some Carrier.`Protocol`<Cardinal>) -> Self {
        self.extracting(last: Int(bitPattern: maxLength.underlying))
    }

    /// Returns a span with the last `k` elements removed.
    ///
    /// Typed-Cardinal overload mirroring stdlib's
    /// `Span.extracting(droppingLast: Int) -> Self`.
    ///
    /// - Parameter k: The number of trailing elements to drop.
    /// - Returns: A span over the elements before the dropped suffix.
    @inlinable
    @_lifetime(copy self)
    public func extracting(droppingLast k: some Carrier.`Protocol`<Cardinal>) -> Self {
        self.extracting(droppingLast: Int(bitPattern: k.underlying))
    }
}
