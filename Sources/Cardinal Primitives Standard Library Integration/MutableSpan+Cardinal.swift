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

    /// Returns a mutable span over the first `maxLength` elements.
    ///
    /// Typed-Cardinal overload mirroring stdlib's
    /// `MutableSpan._mutatingExtracting(first: Int) -> Self`. Accepts any
    /// `Carrier.`Protocol`<Cardinal>` conformer (bare `Cardinal` or
    /// phantom-typed `Tagged<Tag, Cardinal>` / `Index<Element>.Count`),
    /// removing the `Int(bitPattern:)` dance at the call site.
    ///
    /// Internal delegation goes to stdlib's `_mutatingExtracting(first:Int)`
    /// (the non-deprecated name in macOS 26.x stdlib; the
    /// `extracting(first:Int)` form was renamed to disambiguate from the
    /// non-mutating `Span.extracting` shape).
    ///
    /// - Parameter maxLength: The maximum number of elements to extract.
    /// - Returns: A mutable span over the prefix.
    @inlinable
    @_lifetime(&self)
    public mutating func extracting(first maxLength: some Carrier.`Protocol`<Cardinal>) -> Self {
        self._mutatingExtracting(first: Int(bitPattern: maxLength.underlying))
    }

    /// Returns a mutable span with the first `k` elements removed.
    ///
    /// Typed-Cardinal overload mirroring stdlib's
    /// `MutableSpan._mutatingExtracting(droppingFirst: Int) -> Self`.
    ///
    /// - Parameter k: The number of leading elements to drop.
    /// - Returns: A mutable span over the elements after the dropped prefix.
    @inlinable
    @_lifetime(&self)
    public mutating func extracting(droppingFirst k: some Carrier.`Protocol`<Cardinal>) -> Self {
        self._mutatingExtracting(droppingFirst: Int(bitPattern: k.underlying))
    }

    /// Returns a mutable span over the last `maxLength` elements.
    ///
    /// Typed-Cardinal overload mirroring stdlib's
    /// `MutableSpan._mutatingExtracting(last: Int) -> Self`.
    ///
    /// - Parameter maxLength: The maximum number of trailing elements to extract.
    /// - Returns: A mutable span over the suffix.
    @inlinable
    @_lifetime(&self)
    public mutating func extracting(last maxLength: some Carrier.`Protocol`<Cardinal>) -> Self {
        self._mutatingExtracting(last: Int(bitPattern: maxLength.underlying))
    }

    /// Returns a mutable span with the last `k` elements removed.
    ///
    /// Typed-Cardinal overload mirroring stdlib's
    /// `MutableSpan._mutatingExtracting(droppingLast: Int) -> Self`.
    ///
    /// - Parameter k: The number of trailing elements to drop.
    /// - Returns: A mutable span over the elements before the dropped suffix.
    @inlinable
    @_lifetime(&self)
    public mutating func extracting(droppingLast k: some Carrier.`Protocol`<Cardinal>) -> Self {
        self._mutatingExtracting(droppingLast: Int(bitPattern: k.underlying))
    }
}
