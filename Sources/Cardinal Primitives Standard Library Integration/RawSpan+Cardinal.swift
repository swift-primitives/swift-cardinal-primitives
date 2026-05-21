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

// MARK: - RawSpan + Cardinal.Protocol

extension RawSpan {
    /// Creates a raw span from a start address and a cardinal byte count.
    ///
    /// Typed-Cardinal overload mirroring stdlib's
    /// `RawSpan.init(_unsafeStart: UnsafeRawPointer, byteCount: Int)`. Accepts
    /// any `Carrier.`Protocol`<Cardinal>` conformer (bare `Cardinal`,
    /// phantom-typed `Tagged<Tag, Cardinal>`, or `Memory.Address.Count`),
    /// removing the `Int(bitPattern:)` dance at the call site.
    ///
    /// - Parameters:
    ///   - pointer: A pointer to the start of the span.
    ///   - byteCount: The number of bytes in the span.
    /// - Warning: The caller must ensure lifetime safety.
    @_lifetime(borrow pointer)
    @inlinable
    public init(
        _unsafeStart pointer: UnsafeRawPointer,
        byteCount: some Carrier.`Protocol`<Cardinal>
    ) {
        unsafe self.init(
            _unsafeStart: pointer,
            byteCount: Int(bitPattern: byteCount.underlying)
        )
    }
}
