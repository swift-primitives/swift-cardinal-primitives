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
public import Property_Primitives

// MARK: - Tagged<Tag, Cardinal> Properties and Constants

extension Tagged where RawValue == Cardinal, Tag: ~Copyable {
    /// The underlying cardinal value.
    @inlinable
    public var count: Cardinal { rawValue }

    /// The zero count.
    @inlinable
    @_disfavoredOverload
    public static var zero: Self {
        Self(__unchecked: (), Cardinal.zero)
    }

    /// The count of one.
    @inlinable
    public static var one: Self {
        Self(__unchecked: (), Cardinal.one)
    }
}

// MARK: - Tagged<Tag, Cardinal> Construction

extension Tagged where RawValue == Cardinal, Tag: ~Copyable {
    /// Creates a tagged cardinal from a cardinal.
    @inlinable
    public init(_ count: Cardinal) {
        self.init(__unchecked: (), count)
    }

    /// Creates a tagged cardinal from an unsigned integer.
    @inlinable
    public init(_ rawValue: UInt) {
        self.init(__unchecked: (), Cardinal(rawValue))
    }

    /// Creates a tagged cardinal from a signed integer.
    ///
    /// - Parameter rawValue: The count value. Must be non-negative.
    /// - Throws: `Cardinal.Error.negativeSource` if negative.
    @inlinable
    public init(_ rawValue: Int) throws(Cardinal.Error) {
        self.init(__unchecked: (), try Cardinal(rawValue))
    }

    /// Creates a tagged cardinal without validation.
    ///
    /// - Parameter rawValue: Must be non-negative.
    /// - Warning: No validation is performed.
    @inlinable
    public init(__unchecked: Void, _ rawValue: Int) {
        self.init(__unchecked: (), Cardinal(UInt(rawValue)))
    }
}

// MARK: - Tagged<Tag, Cardinal> Arithmetic

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

