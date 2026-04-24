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

// MARK: - OutputSpan + Cardinal.Protocol

extension Swift.OutputSpan where Element: ~Copyable {

    /// Creates an OutputSpan over partly-initialized memory with a cardinal
    /// initialized count.
    ///
    /// Bridges the typed `Cardinal.Protocol` count (including bare `Cardinal`
    /// and phantom-typed `Tagged<Tag, Cardinal>` via `Index<Element>.Count`)
    /// to the stdlib `Int`-based initializer.
    ///
    /// The memory in `buffer` must remain valid throughout the lifetime
    /// of the newly-created `OutputSpan`. Its prefix must contain
    /// `initializedCount` initialized instances, followed by uninitialized
    /// memory.
    ///
    /// - Parameters:
    ///   - buffer: an `UnsafeMutableBufferPointer` to be initialized.
    ///   - initializedCount: the number of initialized elements at the
    ///       beginning of `buffer`, as any `Cardinal.Protocol` conformer.
    /// - Warning: The caller must ensure lifetime safety.
    @unsafe
    @inlinable
    @_lifetime(borrow buffer)
    public init<C: Cardinal.`Protocol`>(
        buffer: UnsafeMutableBufferPointer<Element>,
        initializedCount: C
    ) {
        unsafe self.init(
            buffer: buffer,
            initializedCount: Int(bitPattern: initializedCount.cardinal)
        )
    }

    /// Removes the last `k` elements, returning their memory to the
    /// uninitialized state.
    ///
    /// Bridges the typed `Cardinal.Protocol` count to the stdlib `Int`-based
    /// `removeLast(_:)`.
    ///
    /// - Parameter k: the number of elements to remove, as any
    ///     `Cardinal.Protocol` conformer.
    @inlinable
    @_lifetime(self: copy self)
    public mutating func removeLast<C: Cardinal.`Protocol`>(_ k: C) {
        removeLast(Int(bitPattern: k.cardinal))
    }
}

// MARK: - OutputSpan (Copyable) + Cardinal.Protocol

extension Swift.OutputSpan {

    /// Repeatedly appends an element a given number of times.
    ///
    /// Bridges the typed `Cardinal.Protocol` count to the stdlib `Int`-based
    /// `append(repeating:count:)`.
    ///
    /// - Parameters:
    ///   - repeatedValue: the element to append.
    ///   - count: the number of times to append, as any
    ///       `Cardinal.Protocol` conformer.
    @inlinable
    @_lifetime(self: copy self)
    public mutating func append<C: Cardinal.`Protocol`>(
        repeating repeatedValue: Element,
        count: C
    ) {
        append(repeating: repeatedValue, count: Int(bitPattern: count.cardinal))
    }
}
