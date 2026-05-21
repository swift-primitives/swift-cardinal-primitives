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

// MARK: - Collection + Cardinal.Protocol

extension Collection {
    /// Returns a subsequence containing the initial elements until the count reaches
    /// the specified maximum length.
    ///
    /// Typed-Cardinal overload mirroring stdlib's `Collection.prefix(_:Int) -> SubSequence`.
    /// Accepts any `Carrier.`Protocol`<Cardinal>` conformer (bare `Cardinal` or
    /// phantom-typed `Tagged<Tag, Cardinal>`), removing the `Int(bitPattern:)` dance
    /// at the call site.
    ///
    /// - Parameter maxLength: The maximum number of elements to return.
    /// - Returns: A subsequence starting at the beginning of this collection
    ///   with at most `maxLength` elements.
    @inlinable
    public __consuming func prefix(_ maxLength: some Carrier.`Protocol`<Cardinal>) -> SubSequence {
        self.prefix(Int(bitPattern: maxLength.underlying))
    }

    /// Returns a subsequence containing the final elements of the collection.
    ///
    /// Typed-Cardinal overload mirroring stdlib's `Collection.suffix(_:Int) -> SubSequence`.
    /// Accepts any `Carrier.`Protocol`<Cardinal>` conformer (bare `Cardinal` or
    /// phantom-typed `Tagged<Tag, Cardinal>`), removing the `Int(bitPattern:)` dance
    /// at the call site.
    ///
    /// On `BidirectionalCollection` conformers (Array, String, etc.) the inner
    /// delegation resolves to the stdlib's optimized `BidirectionalCollection.suffix`
    /// override.
    ///
    /// - Parameter maxLength: The maximum number of elements to return.
    /// - Returns: A subsequence terminating at the end of the collection
    ///   with at most `maxLength` elements.
    @inlinable
    public __consuming func suffix(_ maxLength: some Carrier.`Protocol`<Cardinal>) -> SubSequence {
        self.suffix(Int(bitPattern: maxLength.underlying))
    }

    /// Returns a subsequence containing all but the given number of initial elements.
    ///
    /// Typed-Cardinal overload mirroring stdlib's `Collection.dropFirst(_:Int) -> SubSequence`.
    /// Accepts any `Carrier.`Protocol`<Cardinal>` conformer (bare `Cardinal` or
    /// phantom-typed `Tagged<Tag, Cardinal>`), removing the `Int(bitPattern:)` dance
    /// at the call site.
    ///
    /// - Parameter k: The number of elements to drop from the beginning.
    /// - Returns: A subsequence starting after the specified number of elements.
    @inlinable
    public __consuming func dropFirst(_ k: some Carrier.`Protocol`<Cardinal>) -> SubSequence {
        self.dropFirst(Int(bitPattern: k.underlying))
    }

    /// Returns a subsequence containing all but the specified number of final elements.
    ///
    /// Typed-Cardinal overload mirroring stdlib's `Collection.dropLast(_:Int) -> SubSequence`.
    /// Accepts any `Carrier.`Protocol`<Cardinal>` conformer (bare `Cardinal` or
    /// phantom-typed `Tagged<Tag, Cardinal>`), removing the `Int(bitPattern:)` dance
    /// at the call site.
    ///
    /// On `BidirectionalCollection` conformers (Array, String, etc.) the inner
    /// delegation resolves to the stdlib's optimized `BidirectionalCollection.dropLast`
    /// override.
    ///
    /// - Parameter k: The number of elements to drop from the end.
    /// - Returns: A subsequence leaving off the specified number of elements at the end.
    @inlinable
    public __consuming func dropLast(_ k: some Carrier.`Protocol`<Cardinal>) -> SubSequence {
        self.dropLast(Int(bitPattern: k.underlying))
    }
}
