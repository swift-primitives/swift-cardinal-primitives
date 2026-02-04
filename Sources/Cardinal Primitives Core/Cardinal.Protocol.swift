// Cardinal.Protocol.swift
// Abstraction over types that carry a cardinal quantity.

public import Identity_Primitives

// MARK: - Protocol

extension Cardinal {
    /// A type that carries a cardinal quantity.
    ///
    /// Conforming types wrap or represent a `Cardinal` value and can
    /// round-trip through it. This enables generic operations (like
    /// alignment) to accept both bare `Cardinal` and phantom-typed
    /// wrappers like `Index<T>.Count` without rawValue extraction.
    ///
    /// ## Conformers
    ///
    /// - `Cardinal` — identity (self-conformance)
    /// - `Tagged<Tag, Cardinal>` — phantom-typed cardinal wrapper
    ///
    /// ## Example
    ///
    /// ```swift
    /// func align<C: Cardinal.`Protocol`>(_ value: C) -> C {
    ///     C(cardinal: Cardinal(computeAligned(value.cardinal.rawValue)))
    /// }
    /// ```
    public protocol `Protocol` {
        /// The underlying cardinal value.
        var cardinal: Cardinal { get }

        /// Creates an instance from a cardinal value.
        init(_ cardinal: Cardinal)
    }
}

// MARK: - Cardinal Conformance

extension Cardinal: Cardinal.`Protocol` {
    /// Returns self.
    @inlinable
    public var cardinal: Cardinal { self }

    /// Creates a cardinal from a cardinal (identity).
    @inlinable
    public init(_ cardinal: Cardinal) {
        self = cardinal
    }
}

// MARK: - Tagged Conformance

extension Tagged: Cardinal.`Protocol` where RawValue == Cardinal, Tag: ~Copyable {
    /// The underlying cardinal value.
    @inlinable
    public var cardinal: Cardinal { rawValue }

    /// Creates a tagged cardinal from a cardinal value.
    @inlinable
    public init(_ cardinal: Cardinal) {
        self.init(__unchecked: (), cardinal)
    }
}

// MARK: - Arithmetic

extension Cardinal.`Protocol` {
    /// Adds two cardinal quantities (trapping on overflow).
    ///
    /// Delegates to `Cardinal.+` which uses overflow-checked addition.
    @inlinable
    public static func + (lhs: Self, rhs: Self) -> Self {
        Self(lhs.cardinal + rhs.cardinal)
    }

    /// Adds a cardinal quantity in place (trapping on overflow).
    @inlinable
    public static func += (lhs: inout Self, rhs: Self) {
        lhs = lhs + rhs
    }
}
