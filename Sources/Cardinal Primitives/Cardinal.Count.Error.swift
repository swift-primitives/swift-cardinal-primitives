extension Cardinal.Count {
    /// Errors that can occur during cardinal operations.
    public enum Error: Swift.Error, Hashable, Sendable {
        /// The operation would overflow the representable range.
        ///
        /// Thrown by `.add.exact(_:)` when the sum exceeds `UInt.max`,
        /// or by `Int.init(_:)` when the count exceeds `Int.max`.
        case overflow

        /// The operation would require a negative result.
        ///
        /// Thrown by `.subtract.exact(_:)` when the subtrahend exceeds
        /// the minuend (i.e., `other > self`).
        case underflow

        /// The source integer was negative.
        ///
        /// Thrown by `init(_: Int)` when the input is less than zero.
        /// - Parameter value: The negative value that was provided.
        case negativeSource(Int)
    }
}
