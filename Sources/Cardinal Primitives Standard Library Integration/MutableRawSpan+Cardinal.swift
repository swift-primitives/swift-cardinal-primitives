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

// MARK: - MutableRawSpan + Cardinal.Protocol

extension MutableRawSpan {
    /// Creates a mutable raw span from a start address and a cardinal byte count.
    ///
    /// Typed-Cardinal overload mirroring stdlib's
    /// `MutableRawSpan.init(_unsafeStart: UnsafeMutableRawPointer, byteCount: Int)`.
    /// Accepts any `Carrier.`Protocol`<Cardinal>` conformer.
    ///
    /// - Parameters:
    ///   - pointer: A pointer to the start of the span.
    ///   - byteCount: The number of bytes in the span.
    /// - Warning: The caller must ensure lifetime safety.
    @unsafe
    @_lifetime(borrow pointer)
    @inlinable
    public init(
        _unsafeStart pointer: UnsafeMutableRawPointer,
        byteCount: some Carrier.`Protocol`<Cardinal>
    ) {
        unsafe self.init(
            _unsafeStart: pointer,
            byteCount: Int(bitPattern: byteCount.underlying)
        )
    }
}
