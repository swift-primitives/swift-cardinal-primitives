public import Property_Primitives

extension Cardinal {
    /// Tag type for addition operations.
    public enum Add {}

    /// Policy-aware addition operations.
    ///
    /// Use this accessor when you need control over overflow behavior:
    /// - `.add.saturating(_:)` — clamps at `UInt.max`
    /// - `.add.exact(_:)` — throws on overflow
    ///
    /// For trapping addition (Swift integer semantics), use the `+` operator.
    @inlinable
    public var add: Property<Add, Self> {
        Property(self)
    }
}

extension Property where Tag == Cardinal.Add, Base == Cardinal {
    /// Adds a count, saturating at the maximum representable value.
    ///
    /// If the sum would overflow, returns `Cardinal(UInt.max)`.
    ///
    /// - Parameter other: The count to add.
    /// - Returns: The sum, clamped to `UInt.max` on overflow.
    @inlinable
    public func saturating(_ other: Base) -> Base {
        let (result, overflow) = base.rawValue.addingReportingOverflow(other.rawValue)
        if overflow {
            return Base(.max)
        }
        return Base(result)
    }

    /// Adds a count, throwing on overflow.
    ///
    /// - Parameter other: The count to add.
    /// - Returns: The sum.
    /// - Throws: `Cardinal.Error.overflow` if the sum exceeds `UInt.max`.
    @inlinable
    public func exact(_ other: Base) throws(Base.Error) -> Base {
        let (result, overflow) = base.rawValue.addingReportingOverflow(other.rawValue)
        if overflow {
            throw .overflow
        }
        return Base(result)
    }
}
