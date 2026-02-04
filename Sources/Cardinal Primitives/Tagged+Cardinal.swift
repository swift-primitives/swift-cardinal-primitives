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

extension Cardinal.`Protocol` {
    /// The underlying cardinal value.
    @inlinable
    public var count: Cardinal { self.cardinal }
}

// MARK: - Tagged<Tag, Cardinal> Construction

extension Tagged where RawValue == Cardinal, Tag: ~Copyable {
    /// Creates a tagged cardinal from a cardinal.
    @inlinable
    public init(_ count: Cardinal) {
        // VALIDATED SOLE __unchecked lift to Tagged
        self.init(__unchecked: (), count)
    }

    /// Creates a tagged cardinal from an unsigned integer.
    @inlinable
    public init(_ uint: UInt) {
        self.init(Cardinal(uint))
    }

    /// Creates a tagged cardinal from a signed integer.
    ///
    /// - Parameter rawValue: The count value. Must be non-negative.
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
        self = try Int(count.rawValue)
    }

    /// Creates an integer by reinterpreting the tagged cardinal's bit pattern.
    ///
    /// This is an unchecked conversion for low-level operations like pointer arithmetic.
    @inlinable
    public init<Tag: ~Copyable>(bitPattern count: Tagged<Tag, Cardinal>) {
        self = Int(bitPattern: count.rawValue)
    }

    /// Creates an integer from a tagged cardinal, clamping to `Int.max` if too large.
    ///
    /// Use this for APIs like `Sequence.underestimatedCount` that return `Int`.
    @inlinable
    public init<Tag: ~Copyable>(clamping count: Tagged<Tag, Cardinal>) {
        self = Int(clamping: count.rawValue)
    }
}

