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

// MARK: - Dictionary + Cardinal.Protocol

extension Dictionary {
    /// Reserves enough space to store the specified number of key-value pairs.
    ///
    /// Typed-Cardinal overload mirroring stdlib's `Dictionary.reserveCapacity(_:Int)`.
    /// Accepts any `Carrier.`Protocol`<Cardinal>` conformer (bare `Cardinal` or
    /// phantom-typed `Tagged<Tag, Cardinal>`), removing the `Int(bitPattern:)`
    /// dance at the call site.
    ///
    /// `Dictionary` is not a `RangeReplaceableCollection` conformer, so a
    /// per-type overload here is the only path — the protocol-level RRC overload
    /// does not cover this type.
    ///
    /// - Parameter minimumCapacity: The requested minimum number of key-value pairs.
    @inlinable
    public mutating func reserveCapacity(_ minimumCapacity: some Carrier.`Protocol`<Cardinal>) {
        self.reserveCapacity(Int(bitPattern: minimumCapacity.underlying))
    }

    /// Creates an empty dictionary with preallocated space for at least the
    /// specified number of key-value pairs.
    ///
    /// Typed-Cardinal overload mirroring stdlib's `Dictionary.init(minimumCapacity:Int)`.
    ///
    /// - Parameter minimumCapacity: The requested minimum number of key-value pairs.
    @inlinable
    public init(minimumCapacity: some Carrier.`Protocol`<Cardinal>) {
        self.init(minimumCapacity: Int(bitPattern: minimumCapacity.underlying))
    }
}
