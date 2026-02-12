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

// MARK: - UnsafeMutablePointer + Cardinal.Protocol

extension UnsafeMutablePointer {
    /// Initializes memory starting at this pointer from `source`, copying `count` elements.
    ///
    /// This overload accepts any `Cardinal.Protocol` conformer, enabling
    /// both bare `Cardinal` and phantom-typed `Tagged<Tag, Cardinal>` as counts.
    ///
    /// - Parameters:
    ///   - source: A pointer to the values to copy.
    ///   - count: The number of elements to copy.
    @inlinable
    public func initialize<C: Cardinal.`Protocol`>(
        from source: UnsafePointer<Pointee>,
        count: C
    ) {
        unsafe self.initialize(from: source, count: Int(bitPattern: count.cardinal))
    }
}

extension UnsafeMutablePointer where Pointee: ~Copyable {
    /// Moves `count` elements from `source` into uninitialized memory at this pointer.
    ///
    /// The source memory is left uninitialized after the move. Handles
    /// overlapping regions correctly (memmove semantics).
    ///
    /// This overload accepts any `Cardinal.Protocol` conformer, enabling
    /// both bare `Cardinal` and phantom-typed `Tagged<Tag, Cardinal>` as counts.
    ///
    /// - Parameters:
    ///   - source: A pointer to the values to move.
    ///   - count: The number of elements to move.
    @inlinable
    public func moveInitialize<C: Cardinal.`Protocol`>(
        from source: UnsafeMutablePointer,
        count: C
    ) {
        unsafe self.moveInitialize(from: source, count: Int(bitPattern: count.cardinal))
    }
}
