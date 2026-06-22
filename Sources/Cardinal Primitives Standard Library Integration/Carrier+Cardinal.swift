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
public import Carrier_Primitives

// MARK: - Cardinal Shift Operators on Carrier<FixedWidthInteger>
//
// Typed-Carrier shifts by a `Carrier.\`Protocol\`<Cardinal>` amount. Parallel
// to the bare `FixedWidthInteger << Carrier<Cardinal>` operators in
// FixedWidthInteger+Cardinal.swift — same domain (bit shifts as ℕ-indexed
// endomorphisms on Word), same module, lifted to typed-carrier receivers.
//
// Composes with the non-shift bitwise operators on `Carrier<FixedWidthInteger>`
// (`&`, `|`, `^`, `~`, integer-amount `<<` / `>>`) declared in
// `swift-carrier-primitives` `Carrier Primitives Standard Library Integration`
// (Carrier+Bitwise.swift). The two files together provide the full bitwise
// surface for typed-carrier wrappers over fixed-width integers.

/// Left shift a carrier value by a cardinal amount.
@_disfavoredOverload
@inlinable
public func << <C: Carrier.`Protocol`>(
    lhs: C,
    rhs: some Carrier.`Protocol`<Cardinal>
) -> C where C.Underlying: FixedWidthInteger {
    C(lhs.underlying << rhs)
}

/// Right shift a carrier value by a cardinal amount.
@_disfavoredOverload
@inlinable
public func >> <C: Carrier.`Protocol`>(
    lhs: C,
    rhs: some Carrier.`Protocol`<Cardinal>
) -> C where C.Underlying: FixedWidthInteger {
    C(lhs.underlying >> rhs)
}

/// Left shift assignment of a carrier value by a cardinal amount.
@_disfavoredOverload
@inlinable
public func <<= <C: Carrier.`Protocol`>(
    lhs: inout C,
    rhs: some Carrier.`Protocol`<Cardinal>
) where C.Underlying: FixedWidthInteger {
    lhs = lhs << rhs
}

/// Right shift assignment of a carrier value by a cardinal amount.
@_disfavoredOverload
@inlinable
public func >>= <C: Carrier.`Protocol`>(
    lhs: inout C,
    rhs: some Carrier.`Protocol`<Cardinal>
) where C.Underlying: FixedWidthInteger {
    lhs = lhs >> rhs
}
