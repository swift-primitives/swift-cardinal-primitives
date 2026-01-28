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


// MARK: - Tagged<Tag, Cardinal>.Add

extension Tagged where RawValue == Cardinal, Tag: ~Copyable {
    /// Tag for addition operations on tagged cardinals.
    public enum Add {}
}

// MARK: - Tagged<Tag, Cardinal> Addition (Property-based)

extension Tagged where RawValue == Cardinal, Tag: ~Copyable {
    /// Access to policy-aware addition operations.
    ///
    /// Use this accessor when you need control over overflow behavior:
    /// - `.add.saturating(_:)` — clamps at `UInt.max`
    /// - `.add.exact(_:)` — throws on overflow
    ///
    /// For trapping addition (Swift integer semantics), use the `+` operator.
    ///
    /// ```swift
    /// let total = size.add.saturating(increment)
    /// let exact = try size.add.exact(increment)
    /// ```
    @inlinable
    public var add: Property<Add, Self> {
        Property(self)
    }
}

extension Property {
    /// Saturating addition: returns `min(UInt.max, self + other)`.
    @inlinable
    public func saturating<T: ~Copyable>(_ other: Base) -> Base
    where
    Tag == Tagged<T, Cardinal>.Add,
    Base == Tagged<T, Cardinal> {
        base.map { $0.add.saturating(other.rawValue) }
    }

    /// Exact addition: returns `self + other` or throws if overflow.
    @inlinable
    public func exact<T: ~Copyable>(_ other: Base) throws(Cardinal.Error) -> Base
    where
    Tag == Tagged<T, Cardinal>.Add,
    Base == Tagged<T, Cardinal> {
        try base.map { cardinal throws(Cardinal.Error) in try cardinal.add.exact(other.rawValue) }
    }

    /// Callable syntax for exact addition.
    @inlinable
    public func callAsFunction<T: ~Copyable>(_ other: Base) throws(Cardinal.Error) -> Base
    where
    Tag == Tagged<T, Cardinal>.Add,
    Base == Tagged<T, Cardinal> {
        try self.exact(other)
    }
}
