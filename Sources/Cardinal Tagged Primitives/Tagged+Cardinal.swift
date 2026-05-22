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

public import Cardinal_Primitive
public import Tagged_Primitives

// MARK: - Tagged<Tag, Cardinal> Construction
//
// `init(_ count: Cardinal)` is provided by Tagged's unconditional
// `Carrier.\`Protocol\`` conformance.

extension Tagged where Underlying == Cardinal, Tag: ~Copyable {
    /// Creates a tagged cardinal from an unsigned integer.
    @inlinable
    public init(_ uint: UInt) {
        self.init(Cardinal(uint))
    }
}
