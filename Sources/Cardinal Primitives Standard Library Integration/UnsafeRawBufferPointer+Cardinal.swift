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

// MARK: - UnsafeRawBufferPointer + Cardinal.Protocol

extension UnsafeRawBufferPointer {
    /// Creates a raw buffer pointer from a start address and a cardinal byte count.
    ///
    /// Typed-Cardinal overload mirroring stdlib's
    /// `UnsafeRawBufferPointer.init(start: UnsafeRawPointer?, count: Int)`.
    /// Accepts any `Carrier.`Protocol`<Cardinal>` conformer (bare `Cardinal`,
    /// phantom-typed `Tagged<Tag, Cardinal>`, or `Memory.Address.Count`),
    /// removing the `Int(bitPattern:)` dance at the call site.
    ///
    /// - Parameters:
    ///   - start: A pointer to the start of the buffer.
    ///   - count: The number of bytes in the buffer.
    @inlinable
    public init(start: UnsafeRawPointer?, count: some Carrier.`Protocol`<Cardinal>) {
        unsafe self.init(start: start, count: Int(bitPattern: count.underlying))
    }
}
