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

// MARK: - String + Cardinal.Protocol

extension String {
    /// Creates a new string representing the given string repeated the
    /// specified number of times.
    ///
    /// Typed-Cardinal overload mirroring stdlib's
    /// `String.init(repeating: String, count: Int)`. Accepts any
    /// `Carrier.`Protocol`<Cardinal>` conformer for the count, removing the
    /// `Int(bitPattern:)` dance at the call site.
    ///
    /// `String.reserveCapacity` is already covered by the Tier 1
    /// `RangeReplaceableCollection` protocol-level overload (String conforms
    /// to RRC). This per-type overload covers `init(repeating:count:)` which
    /// does not have a protocol-level home.
    ///
    /// - Parameters:
    ///   - repeatedValue: The string to repeat.
    ///   - count: The number of times to repeat `repeatedValue`.
    @inlinable
    public init(repeating repeatedValue: String, count: some Carrier.`Protocol`<Cardinal>) {
        self.init(repeating: repeatedValue, count: Int(bitPattern: count.underlying))
    }
}
