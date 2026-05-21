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

// MARK: - UnsafeMutableRawBufferPointer + Cardinal.Protocol

extension UnsafeMutableRawBufferPointer {
    /// Creates a mutable raw buffer pointer from a start address and a cardinal byte count.
    ///
    /// Typed-Cardinal overload mirroring stdlib's
    /// `UnsafeMutableRawBufferPointer.init(start: UnsafeMutableRawPointer?, count: Int)`.
    /// Accepts any `Carrier.`Protocol`<Cardinal>` conformer.
    ///
    /// - Parameters:
    ///   - start: A pointer to the start of the buffer.
    ///   - count: The number of bytes in the buffer.
    @inlinable
    public init(start: UnsafeMutableRawPointer?, count: some Carrier.`Protocol`<Cardinal>) {
        unsafe self.init(start: start, count: Int(bitPattern: count.underlying))
    }

    /// Allocates a mutable raw buffer with a typed cardinal byte count and alignment.
    ///
    /// Typed-Cardinal overload mirroring stdlib's
    /// `UnsafeMutableRawBufferPointer.allocate(byteCount: Int, alignment: Int)`.
    ///
    /// - Parameters:
    ///   - byteCount: The number of bytes to allocate.
    ///   - alignment: The alignment requirement in bytes.
    /// - Returns: A new mutable raw buffer pointer to uninitialized memory.
    @inlinable
    public static func allocate(
        byteCount: some Carrier.`Protocol`<Cardinal>,
        alignment: some Carrier.`Protocol`<Cardinal>
    ) -> UnsafeMutableRawBufferPointer {
        UnsafeMutableRawBufferPointer.allocate(
            byteCount: Int(bitPattern: byteCount.underlying),
            alignment: Int(bitPattern: alignment.underlying)
        )
    }
}
