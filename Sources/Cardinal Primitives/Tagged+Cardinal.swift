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

public import Tagged_Primitives

// MARK: - Tagged<Tag, Cardinal> Construction
//
// `init(_ count: Cardinal)` is provided by Tagged's unconditional
// `Carrier.\`Protocol\`` conformance.

extension Tagged where Underlying == Cardinal, Tag: ~Copyable {
    /// Creates a tagged cardinal from an unsigned integer.
    @inlinable
    public init(_ uint: UInt) {
        self.init(Cardinal(uint))
    }

    /// Creates a tagged cardinal from a signed integer.
    ///
    /// - Parameter int: The count value. Must be non-negative.
    /// - Throws: `Cardinal.Error.negativeSource` if negative.
    @inlinable
    public init(_ int: Int) throws(Cardinal.Error) {
        self.init(try Cardinal(int))
    }
}

// MARK: - Int Conversions for Tagged<Tag, Cardinal>

extension Int {
    /// Creates an integer from a tagged cardinal, throwing if it exceeds `Int.max`.
    @inlinable
    public init<Tag: ~Copyable>(_ count: Tagged<Tag, Cardinal>) throws(Cardinal.Error) {
        self = try Int(count.underlying)
    }

    /// Creates an integer by reinterpreting the tagged cardinal's bit pattern.
    ///
    /// This is an unchecked conversion for low-level operations like pointer arithmetic.
    @inlinable
    public init<Tag: ~Copyable>(bitPattern count: Tagged<Tag, Cardinal>) {
        self = Int(bitPattern: count.underlying)
    }

    /// Creates an integer from a tagged cardinal, clamping to `Int.max` if too large.
    ///
    /// Use this for APIs like `Sequence.underestimatedCount` that return `Int`.
    @inlinable
    public init<Tag: ~Copyable>(clamping count: Tagged<Tag, Cardinal>) {
        self = Int(clamping: count.underlying)
    }
}
