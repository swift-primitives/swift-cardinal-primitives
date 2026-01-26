extension Cardinal {
    /// A finite cardinal number representing quantity.
    ///
    /// `Cardinal.Count` answers "how many?" with a non-negative integer.
    /// It is backed by `UInt` to make non-negativity representational
    /// rather than runtime-checked.
    ///
    /// ## Usage
    ///
    /// ```swift
    /// let items = Cardinal.Count(5)
    /// let total = items + Cardinal.Count(3)  // 8
    ///
    /// // Policy-aware subtraction (monus)
    /// let remaining = items.subtract.saturating(Cardinal.Count(2))  // 3
    /// let result = try items.subtract.exact(Cardinal.Count(10))     // throws .underflow
    /// ```
    ///
    /// ## Design
    ///
    /// - **Backing**: `UInt` (machine word) ensures non-negativity at the type level
    /// - **Addition**: Trapping `+` operator matches Swift integer semantics
    /// - **Subtraction**: No `-` operator; use `.subtract.saturating` (monus) or `.subtract.exact`
    public struct Count: Hashable, Comparable, Sendable {
        /// The underlying unsigned integer value.
        public let rawValue: UInt

        // MARK: - Construction

        /// Creates a count from an unsigned integer.
        ///
        /// - Parameter value: The non-negative count value.
        @inlinable
        public init(_ value: UInt) {
            self.rawValue = value
        }

        /// Creates a count without validation.
        ///
        /// - Parameters:
        ///   - unchecked: Marker parameter for unchecked construction.
        ///   - value: The raw value.
        @inlinable
        public init(__unchecked value: UInt) {
            self.rawValue = value
        }

        // MARK: - Constants

        /// The zero count.
        @inlinable
        public static var zero: Self { Self(__unchecked: 0) }

        /// The count of one.
        @inlinable
        public static var one: Self { Self(__unchecked: 1) }

        // MARK: - Trapping Addition

        /// Adds two counts, trapping on overflow.
        ///
        /// This matches Swift integer semantics: overflow is a programmer error
        /// that causes a runtime trap. For overflow-aware addition, use
        /// `.add.saturating(_:)` or `.add.exact(_:)`.
        ///
        /// - Parameters:
        ///   - lhs: The first count.
        ///   - rhs: The second count.
        /// - Returns: The sum of the two counts.
        @inlinable
        public static func + (lhs: Self, rhs: Self) -> Self {
            let (result, overflow) = lhs.rawValue.addingReportingOverflow(rhs.rawValue)
            precondition(!overflow, "Cardinal.Count overflow in addition")
            return Self(__unchecked: result)
        }

        /// Adds a count to this count in place, trapping on overflow.
        @inlinable
        public static func += (lhs: inout Self, rhs: Self) {
            lhs = lhs + rhs
        }

        // MARK: - Equatable / Equation.Protocol

        /// Explicit equality for Equatable/Equation.Protocol compatibility.
        @inlinable
        public static func == (lhs: Self, rhs: Self) -> Bool {
            lhs.rawValue == rhs.rawValue
        }

        // MARK: - Comparable / Comparison.Protocol

        @inlinable
        public static func < (lhs: Self, rhs: Self) -> Bool {
            lhs.rawValue < rhs.rawValue
        }

        @inlinable
        public static func <= (lhs: Self, rhs: Self) -> Bool {
            lhs.rawValue <= rhs.rawValue
        }

        @inlinable
        public static func > (lhs: Self, rhs: Self) -> Bool {
            lhs.rawValue > rhs.rawValue
        }

        @inlinable
        public static func >= (lhs: Self, rhs: Self) -> Bool {
            lhs.rawValue >= rhs.rawValue
        }
    }
}

// MARK: - Protocol Conformances

extension Cardinal.Count: Equation.`Protocol` {}
extension Cardinal.Count: Comparison.`Protocol` {}
