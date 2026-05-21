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

// MARK: - Swift.Array + Cardinal.Protocol

extension Swift.Array {
    /// Reserves enough space to store the specified number of elements.
    ///
    /// Typed-Cardinal overload accepting any `Carrier.`Protocol`<Cardinal>`
    /// conformer (bare `Cardinal` or phantom-typed `Tagged<Tag, Cardinal>`),
    /// removing the `Int(bitPattern:)` dance at the call site.
    ///
    /// Qualified as `Swift.Array` (not bare `Array`) because Array_Primitives
    /// shadows the stdlib symbol when reachable transitively — this overload
    /// MUST attach to stdlib's `Swift.Array`, not the institute's `~Copyable`
    /// `Array<Element>`.
    ///
    /// - Parameter minimumCapacity: The requested minimum number of elements.
    @inlinable
    public mutating func reserveCapacity(_ minimumCapacity: some Carrier.`Protocol`<Cardinal>) {
        self.reserveCapacity(Int(bitPattern: minimumCapacity.underlying))
    }
}
