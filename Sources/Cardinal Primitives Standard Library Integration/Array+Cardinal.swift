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

// MARK: - Swift.Array + Cardinal.Protocol
//
// `extension Swift.Array` is mandatory here — the bare `extension Array` form
// can bind to the institute `Array_Primitives.Array` (`~Copyable` array) if
// `Array_Primitives_Core` is transitively reachable in the consumer's import
// graph. Defensive qualification ensures the extension lands on Swift's
// stdlib `Array<Element>` regardless of import order.

extension Swift.Array {
    /// Creates an array containing the specified number of a single, repeated value.
    ///
    /// Typed-Cardinal overload mirroring stdlib's `Array.init(repeating:count:Int)`.
    /// Accepts any `Carrier.`Protocol`<Cardinal>` conformer (bare `Cardinal` or
    /// phantom-typed `Tagged<Tag, Cardinal>`), removing the `Int(bitPattern:)`
    /// dance at the call site.
    ///
    /// Per-type overload — `init(repeating:count:)` exists as concrete on
    /// `Array`, `ContiguousArray`, and `ArraySlice` individually, not as a
    /// `RangeReplaceableCollection` protocol method.
    ///
    /// - Parameters:
    ///   - repeatedValue: The element to repeat.
    ///   - count: The number of times to repeat the value passed in the
    ///     `repeating` parameter.
    @inlinable
    public init(repeating repeatedValue: Element, count: some Carrier.`Protocol`<Cardinal>) {
        self.init(repeating: repeatedValue, count: Int(bitPattern: count.underlying))
    }

    /// Creates an array with the specified capacity, then calls the given
    /// closure with a buffer covering the array's uninitialized memory.
    ///
    /// Typed-Cardinal overload mirroring stdlib's `Array.init<E>(unsafeUninitializedCapacity:Int, initializingWith:) throws(E)`.
    /// Accepts any `Carrier.`Protocol`<Cardinal>` conformer for the capacity
    /// parameter.
    ///
    /// - Parameters:
    ///   - unsafeUninitializedCapacity: The number of elements to allocate space for.
    ///   - initializer: A closure that initializes elements and sets the count
    ///     of the array.
    /// - Throws: Whatever `initializer` throws.
    @inlinable
    public init<C: Carrier.`Protocol`<Cardinal>, E: Swift.Error>(
        unsafeUninitializedCapacity: C,
        initializingWith initializer: (
            _ buffer: inout UnsafeMutableBufferPointer<Element>,
            _ initializedCount: inout C
        ) throws(E) -> Void
    ) throws(E) {
        try unsafe self.init(
            unsafeUninitializedCapacity: Int(bitPattern: unsafeUninitializedCapacity.underlying),
            initializingWith: { buffer, count throws(E) in
                var typedCount = C(Cardinal(UInt(bitPattern: count)))
                try unsafe initializer(&buffer, &typedCount)
                count = Int(bitPattern: typedCount.underlying)
            }
        )
    }
}
