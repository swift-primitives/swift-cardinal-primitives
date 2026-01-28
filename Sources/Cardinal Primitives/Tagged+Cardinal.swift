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

public import Identity_Primitives

// MARK: - Tagged<Tag, Cardinal> Arithmetic

/// Phantom-typed cardinal arithmetic.
///
/// These operators work on `Tagged<Tag, Cardinal>` wrappers, ensuring that
/// only values with matching phantom types can be combined. This enables
/// type-safe count operations across different domains.
///
/// ## Example
///
/// ```swift
/// let byteCount: Tagged<Byte, Cardinal> = ...
/// let moreBytes: Tagged<Byte, Cardinal> = ...
/// let total = byteCount + moreBytes  // OK: same Tag
///
/// let bitCount: Tagged<Bit, Cardinal> = ...
/// // byteCount + bitCount  // Compile error: different Tags
/// ```

extension Tagged where RawValue == Cardinal, Tag: ~Copyable {
    /// Adds two tagged cardinals (trapping on overflow).
    @inlinable
    public static func + (lhs: Self, rhs: Self) -> Self {
        Self(__unchecked: (), lhs.rawValue + rhs.rawValue)
    }

    /// Increments a tagged cardinal by another (trapping on overflow).
    @inlinable
    public static func += (lhs: inout Self, rhs: Self) {
        lhs = lhs + rhs
    }
}

// MARK: - Tagged<Tag, Cardinal> Scalar Multiplication

extension Tagged where RawValue == Cardinal, Tag: ~Copyable {
    /// Multiplies a tagged cardinal by an unsigned integer.
    @inlinable
    public static func * (lhs: Self, rhs: UInt) -> Self {
        Self(__unchecked: (), Cardinal(lhs.rawValue.rawValue * rhs))
    }

    /// Multiplies an unsigned integer by a tagged cardinal.
    @inlinable
    public static func * (lhs: UInt, rhs: Self) -> Self {
        Self(__unchecked: (), Cardinal(lhs * rhs.rawValue.rawValue))
    }
}
