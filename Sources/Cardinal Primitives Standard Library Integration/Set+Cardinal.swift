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

// MARK: - Set + Cardinal.Protocol

extension Set {
    /// Reserves enough space to store the specified number of elements.
    ///
    /// Typed-Cardinal overload mirroring stdlib's `Set.reserveCapacity(_:Int)`.
    /// Accepts any `Carrier.`Protocol`<Cardinal>` conformer (bare `Cardinal` or
    /// phantom-typed `Tagged<Tag, Cardinal>`), removing the `Int(bitPattern:)`
    /// dance at the call site.
    ///
    /// `Set` is not a `RangeReplaceableCollection` conformer, so a per-type
    /// overload here is the only path — the protocol-level RRC overload does
    /// not cover this type.
    ///
    /// - Parameter minimumCapacity: The requested minimum number of elements.
    @inlinable
    public mutating func reserveCapacity(_ minimumCapacity: some Carrier.`Protocol`<Cardinal>) {
        self.reserveCapacity(Int(bitPattern: minimumCapacity.underlying))
    }

    /// Creates an empty set with preallocated space for at least the specified
    /// number of elements.
    ///
    /// Typed-Cardinal overload mirroring stdlib's `Set.init(minimumCapacity:Int)`.
    ///
    /// - Parameter minimumCapacity: The requested minimum number of elements.
    @inlinable
    public init(minimumCapacity: some Carrier.`Protocol`<Cardinal>) {
        self.init(minimumCapacity: Int(bitPattern: minimumCapacity.underlying))
    }
}
