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

// MARK: - BidirectionalCollection + Cardinal.Protocol

extension BidirectionalCollection where Self: RangeReplaceableCollection {
    /// Removes the specified number of elements from the end of the collection.
    ///
    /// Typed-Cardinal overload mirroring stdlib's
    /// `extension RangeReplaceableCollection where Self: BidirectionalCollection`
    /// host of `removeLast(_:Int)`. Accepts any `Carrier.`Protocol`<Cardinal>`
    /// conformer (bare `Cardinal` or phantom-typed `Tagged<Tag, Cardinal>`),
    /// removing the `Int(bitPattern:)` dance at the call site.
    ///
    /// - Parameter k: The number of elements to remove.
    @inlinable
    public mutating func removeLast(_ k: some Carrier.`Protocol`<Cardinal>) {
        self.removeLast(Int(bitPattern: k.underlying))
    }
}
