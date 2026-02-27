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
        self.init(UInt(value))
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

    /// Creates an integer by reinterpreting the count's bit pattern.
    ///
    /// This is an unchecked conversion that reinterprets the underlying `UInt`
    /// as `Int`. Values greater than `Int.max` become negative.
    ///
    /// Use this for pointer arithmetic and other low-level operations where
    /// you need the raw bit pattern without validation.
    ///
    /// - Parameter cardinal: The cardinal count.
    @inlinable
    public init(bitPattern cardinal: Cardinal) {
        self = Int(bitPattern: cardinal.rawValue)
    }

    /// Creates an integer from a count, clamping to `Int.max` if too large.
    ///
    /// Use this for APIs like `Sequence.underestimatedCount` that return `Int`
    /// but where the actual count may exceed `Int.max`.
    ///
    /// - Parameter cardinal: The cardinal count.
    @inlinable
    public init(clamping cardinal: Cardinal) {
        self = Int(clamping: cardinal.rawValue)
    }
}
