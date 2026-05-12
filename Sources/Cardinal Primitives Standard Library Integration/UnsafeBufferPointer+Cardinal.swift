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

// MARK: - UnsafeBufferPointer + Cardinal.Protocol

extension UnsafeBufferPointer where Element: ~Copyable {
    /// Creates a buffer pointer from a start address and a cardinal count.
    ///
    /// This initializer accepts any `Cardinal.Protocol` conformer, enabling
    /// both bare `Cardinal` and phantom-typed `Tagged<Tag, Cardinal>` as counts.
    ///
    /// - Parameters:
    ///   - start: A pointer to the start of the buffer.
    ///   - count: The number of elements in the buffer.
    @inlinable
    public init(start: UnsafePointer<Element>?, count: some Carrier.`Protocol`<Cardinal>) {
        unsafe self.init(start: start, count: Int(bitPattern: count.underlying))
    }
}
