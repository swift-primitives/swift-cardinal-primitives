public import Carrier_Primitives

// MARK: - Cardinal to UInt32 Conversion

extension UInt32 {
    /// Creates a 32-bit unsigned integer from any cardinal value.
    ///
    /// Accepts both bare `Cardinal` and phantom-typed `Tagged<Tag, Cardinal>` via
    /// `Cardinal.Protocol` conformance.
    ///
    /// - Parameter cardinal: The cardinal value.
    /// - Precondition: The cardinal's value must fit in `UInt32`.
    @inlinable
    public init(_ cardinal: some Carrier.`Protocol`<Cardinal>) {
        self = UInt32(cardinal.underlying.rawValue)
    }
}
