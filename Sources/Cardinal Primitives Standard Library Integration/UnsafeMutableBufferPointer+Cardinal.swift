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

// MARK: - UnsafeMutableBufferPointer + Cardinal.Protocol

extension UnsafeMutableBufferPointer where Element: ~Copyable {
    /// Creates a mutable buffer pointer from a start address and a cardinal count.
    ///
    /// This initializer accepts any `Cardinal.Protocol` conformer, enabling
    /// both bare `Cardinal` and phantom-typed `Tagged<Tag, Cardinal>` as counts.
    ///
    /// - Parameters:
    ///   - start: A pointer to the start of the buffer.
    ///   - count: The number of elements in the buffer.
    @inlinable
    public init<C: Cardinal.`Protocol`>(start: UnsafeMutablePointer<Element>?, count: C) {
        unsafe self.init(start: start, count: Int(bitPattern: count.cardinal))
    }

    /// Allocates a mutable buffer with the given cardinal capacity.
    ///
    /// This method accepts any `Cardinal.Protocol` conformer, enabling
    /// both bare `Cardinal` and phantom-typed `Tagged<Tag, Cardinal>` as capacities.
    ///
    /// - Parameter capacity: The number of elements to allocate.
    /// - Returns: A new mutable buffer pointer to uninitialized memory.
    @inlinable
    public static func allocate<C: Cardinal.`Protocol`>(capacity: C) -> Self {
        Self.allocate(capacity: Int(bitPattern: capacity.cardinal))
    }
}
