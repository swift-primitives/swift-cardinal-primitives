public import Property_Primitives

extension Cardinal.Count {
    /// Tag type for subtraction operations.
    public enum Subtract {}

    /// Policy-aware subtraction operations.
    ///
    /// Natural number subtraction is partial — it's undefined when the
    /// subtrahend exceeds the minuend. This accessor provides two policies:
    /// - `.subtract.saturating(_:)` — monus operation, clamps at zero
    /// - `.subtract.exact(_:)` — throws `.underflow` if `other > self`
    ///
    /// There is no `-` operator because subtraction on cardinals is not total.
    @inlinable
    public var subtract: Property<Subtract, Self> {
        Property(self)
    }
}

extension Property where Tag == Cardinal.Count.Subtract, Base == Cardinal.Count {
    /// Subtracts a count using monus (truncated subtraction).
    ///
    /// The monus operation `a ∸ b` is defined as `max(0, a - b)`.
    /// This makes subtraction total on natural numbers.
    ///
    /// ## Laws
    ///
    /// - `a.subtract.saturating(0) == a`
    /// - `0.subtract.saturating(a) == 0`
    /// - `a.subtract.saturating(a) == 0`
    /// - `(a.subtract.saturating(b)).subtract.saturating(c) == a.subtract.saturating(b + c)`
    ///
    /// - Parameter other: The count to subtract.
    /// - Returns: The difference, or zero if `other > self`.
    @inlinable
    public func saturating(_ other: Base) -> Base {
        if other.rawValue >= base.rawValue {
            return .zero
        }
        return Base(__unchecked: base.rawValue - other.rawValue)
    }

    /// Subtracts a count, throwing on underflow.
    ///
    /// - Parameter other: The count to subtract.
    /// - Returns: The difference.
    /// - Throws: `Cardinal.Count.Error.underflow` if `other > self`.
    @inlinable
    public func exact(_ other: Base) throws(Base.Error) -> Base {
        if other.rawValue > base.rawValue {
            throw .underflow
        }
        return Base(__unchecked: base.rawValue - other.rawValue)
    }
}
