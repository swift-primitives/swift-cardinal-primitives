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


// MARK: - Tagged<Tag, Cardinal>.Subtract

extension Tagged where RawValue == Cardinal, Tag: ~Copyable {
    /// Tag for subtraction operations on tagged cardinals.
    public enum Subtract {}
}

// MARK: - Tagged<Tag, Cardinal> Subtraction (Property-based)

extension Tagged where RawValue == Cardinal, Tag: ~Copyable {
    /// Access to subtraction operations.
    ///
    /// ```swift
    /// let remaining = size.subtract.saturating(dropCount)
    /// let exact = try size.subtract.exact(dropCount)
    /// ```
    @inlinable
    public var subtract: Property<Subtract, Self> {
        Property(self)
    }
}

extension Property {
    /// Saturating subtraction: returns `max(0, self - other)`.
    @inlinable
    public func saturating<T: ~Copyable>(_ other: Base) -> Base
    where
    Tag == Tagged<T, Cardinal>.Subtract,
    Base == Tagged<T, Cardinal> {
        base.map { $0.subtract.saturating(other.rawValue) }
    }

    /// Exact subtraction: returns `self - other` or throws if negative.
    @inlinable
    public func exact<T: ~Copyable>(_ other: Base) throws(Cardinal.Error) -> Base
    where
    Tag == Tagged<T, Cardinal>.Subtract,
    Base == Tagged<T, Cardinal> {
        try base.map { cardinal throws(Cardinal.Error) in try cardinal.subtract.exact(other.rawValue) }
    }

    /// Callable syntax for exact subtraction.
    @inlinable
    public func callAsFunction<T: ~Copyable>(_ other: Base) throws(Cardinal.Error) -> Base
    where
    Tag == Tagged<T, Cardinal>.Subtract,
    Base == Tagged<T, Cardinal> {
        try self.exact(other)
    }
}
