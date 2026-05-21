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

// MARK: - RangeReplaceableCollection + Cardinal.Protocol

extension RangeReplaceableCollection {
    /// Reserves enough space to store the specified number of elements.
    ///
    /// Typed-Cardinal overload accepting any `Carrier.`Protocol`<Cardinal>`
    /// conformer (bare `Cardinal` or phantom-typed `Tagged<Tag, Cardinal>`),
    /// removing the `Int(bitPattern:)` dance at the call site.
    ///
    /// Placed on `RangeReplaceableCollection` (the protocol-level home for
    /// `reserveCapacity`) so the overload covers `Array`, `ContiguousArray`,
    /// `ArraySlice`, `String`, `Substring`, and any custom RRC conformer
    /// uniformly — one overload, broadest reach.
    ///
    /// - Parameter minimumCapacity: The requested minimum number of elements.
    @inlinable
    public mutating func reserveCapacity(_ minimumCapacity: some Carrier.`Protocol`<Cardinal>) {
        self.reserveCapacity(Int(bitPattern: minimumCapacity.underlying))
    }

    /// Removes the specified number of elements from the beginning of the collection.
    ///
    /// Typed-Cardinal overload mirroring stdlib's
    /// `RangeReplaceableCollection.removeFirst(_:Int)`. Accepts any
    /// `Carrier.`Protocol`<Cardinal>` conformer (bare `Cardinal` or phantom-typed
    /// `Tagged<Tag, Cardinal>`), removing the `Int(bitPattern:)` dance at the call site.
    ///
    /// - Parameter k: The number of elements to remove.
    @inlinable
    public mutating func removeFirst(_ k: some Carrier.`Protocol`<Cardinal>) {
        self.removeFirst(Int(bitPattern: k.underlying))
    }
}
