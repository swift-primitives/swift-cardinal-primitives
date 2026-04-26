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
    public init(repeating repeatedValue: Element, count: some Carrier<Cardinal>) {
        self.init(repeating: repeatedValue, count: Int(bitPattern: count.cardinal))
    }
}
