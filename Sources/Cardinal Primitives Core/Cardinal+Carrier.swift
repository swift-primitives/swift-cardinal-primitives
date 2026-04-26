// Cardinal+Carrier.swift
// Cardinal conforms to Carrier as a trivial-self-carrier; per-type
// accessor + arithmetic + constants live as constrained extensions on
// `Carrier where Underlying == Cardinal`.

public import Carrier_Primitives

// MARK: - Carrier Conformance (trivial self-carrier)

extension Cardinal: Carrier {
    /// Cardinal IS its own Underlying.
    public typealias Underlying = Cardinal

    // `Domain` defaults to `Never` per the Carrier protocol declaration.
    // `var underlying` and `init(_:)` are inherited from the
    // `Carrier where Underlying == Self` default extension.
}

// MARK: - Per-type Accessor

extension Carrier where Underlying == Cardinal {
    /// The underlying cardinal value.
    ///
    /// Synonym for `underlying` — preserves the per-type accessor name
    /// established by the (now-deprecated) `Cardinal.\`Protocol\``.
    @inlinable
    public var cardinal: Cardinal { underlying }

    /// Alternate name preserved from the legacy
    /// `Cardinal.\`Protocol\`` extension surface.
    @inlinable
    public var count: Cardinal { underlying }
}

// MARK: - Constants

extension Carrier where Underlying == Cardinal {
    /// The zero count.
    @inlinable
    public static var zero: Self { Self(Cardinal(0)) }

    /// The count of one.
    @inlinable
    public static var one: Self { Self(Cardinal(1)) }
}

// MARK: - Arithmetic

extension Carrier where Underlying == Cardinal {
    /// Adds two cardinal quantities (trapping on overflow).
    ///
    /// Delegates to `Cardinal.+` which uses overflow-checked addition.
    @inlinable
    public static func + (lhs: Self, rhs: Self) -> Self {
        Self(lhs.underlying + rhs.underlying)
    }

    /// Adds a cardinal quantity in place (trapping on overflow).
    @inlinable
    public static func += (lhs: inout Self, rhs: Self) {
        lhs = lhs + rhs
    }
}
