// MARK: - Int to Cardinal Conversions

extension Cardinal {
    /// Creates a count from a signed integer, throwing if negative.
    ///
    /// - Parameter value: The signed integer value.
    /// - Throws: `Error.negativeSource` if `value < 0`.
    @inlinable
    public init(
        _ value: Swift.Int
    ) throws(Error) {
        guard value >= .zero else {
            throw .negativeSource(value)
        }
        self.init(__unchecked: (), UInt(value))
    }
}

// MARK: - Cardinal to Int Conversions

extension Int {
    /// Creates an integer from a count, throwing if it exceeds `Int.max`.
    ///
    /// - Parameter count: The cardinal count.
    /// - Throws: `Cardinal.Error.overflow` if the count exceeds `Int.max`.
    @inlinable
    public init(
        _ cardinal: Cardinal
    ) throws(Cardinal.Error) {
        guard cardinal.rawValue <= Swift.UInt(Swift.Int.max) else {
            throw .overflow
        }
        self = Int(cardinal.rawValue)
    }
}
