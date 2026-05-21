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

// MARK: - Array + Cardinal.Protocol

extension Array {
    /// Reserves enough space to store the specified number of elements.
    ///
    /// Typed-Cardinal overload accepting any `Carrier.`Protocol`<Cardinal>`
    /// conformer (bare `Cardinal` or phantom-typed `Tagged<Tag, Cardinal>`),
    /// removing the `Int(bitPattern:)` dance at the call site.
    ///
    /// - Parameter minimumCapacity: The requested minimum number of elements.
    @inlinable
    public mutating func reserveCapacity(_ minimumCapacity: some Carrier.`Protocol`<Cardinal>) {
        self.reserveCapacity(Int(bitPattern: minimumCapacity.underlying))
    }
}
