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

// MARK: - ContiguousArray + Cardinal.Protocol

extension ContiguousArray {
    /// Creates an array with the specified number of elements, each initialized to the given value.
    ///
    /// This initializer accepts any `Cardinal.Protocol` conformer, enabling
    /// both bare `Cardinal` and phantom-typed `Tagged<Tag, Cardinal>` as counts.
    ///
    /// - Parameters:
    ///   - repeatedValue: The value to repeat.
    ///   - count: The number of times to repeat the value.
    @inlinable
    public init(repeating repeatedValue: Element, count: some Carrier.`Protocol`<Cardinal>) {
        self.init(repeating: repeatedValue, count: Int(bitPattern: count.underlying))
    }

    /// Creates an array with the specified capacity, then calls the given
    /// closure with a buffer covering the array's uninitialized memory.
    ///
    /// Typed-Cardinal overload mirroring stdlib's
    /// `ContiguousArray.init<E>(unsafeUninitializedCapacity:Int, initializingWith:) throws(E)`.
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
