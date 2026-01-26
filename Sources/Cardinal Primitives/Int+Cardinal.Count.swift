// MARK: - Int to Cardinal.Count Conversions

extension Cardinal.Count {
    /// Creates a count from a signed integer, returning `nil` if negative.
    ///
    /// - Parameter value: The signed integer value.
    /// - Returns: A count if `value >= 0`, otherwise `nil`.
    @inlinable
    public init?(exactly value: Int) {
        guard value >= 0 else { return nil }
        self.init(__unchecked: UInt(value))
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
        self.init(__unchecked: UInt(value))
    }
}

// MARK: - Cardinal.Count to Int Conversions

extension Int {
    /// Creates an integer from a count, returning `nil` if it exceeds `Int.max`.
    ///
    /// On 64-bit platforms, this can fail for counts near `UInt.max`.
    /// On 32-bit platforms, this fails for counts exceeding `Int32.max`.
    ///
    /// - Parameter count: The cardinal count.
    /// - Returns: The integer value if representable, otherwise `nil`.
    @inlinable
    public init?(exactly count: Cardinal.Count) {
        guard count.rawValue <= UInt(Int.max) else { return nil }
        self = Int(count.rawValue)
    }

    /// Creates an integer from a count, throwing if it exceeds `Int.max`.
    ///
    /// - Parameter count: The cardinal count.
    /// - Throws: `Cardinal.Count.Error.overflow` if the count exceeds `Int.max`.
    @inlinable
    public init(_ count: Cardinal.Count) throws(Cardinal.Count.Error) {
        guard count.rawValue <= UInt(Int.max) else {
            throw .overflow
        }
        self = Int(count.rawValue)
    }
}
