// MARK: - Int to Cardinal Conversions

extension Cardinal {
    /// Creates a count from a signed integer, returning `nil` if negative.
    ///
    /// - Parameter value: The signed integer value.
    /// - Returns: A count if `value >= 0`, otherwise `nil`.
    @inlinable
    public init?(exactly value: Int) {
        guard value >= 0 else { return nil }
        self.init(__unchecked: (), UInt(value))
    }

    /// Creates a count from a signed integer, throwing if negative.
    ///
    /// - Parameter value: The signed integer value.
    /// - Throws: `Error.negativeSource` if `value < 0`.
    @inlinable
    public init(_ value: Int) throws(Error) {
        guard value >= 0 else {
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
    public init(_ count: Cardinal) throws(Cardinal.Error) {
        guard count.rawValue <= UInt(Int.max) else {
            throw .overflow
        }
        self = Int(count.rawValue)
    }
}
