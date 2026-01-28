extension Cardinal {
    
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
    public init(__unchecked: Void, _ value: UInt) {
        self.rawValue = value
    }
}

extension Cardinal {
    // MARK: - Constants
    
    /// The zero count.
    @inlinable
    public static var zero: Self { Self(__unchecked: (), 0) }
    
    /// The count of one.
    @inlinable
    public static var one: Self { Self(__unchecked: (), 1) }
}

extension Cardinal {
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
        precondition(!overflow, "Cardinal overflow in addition")
        return Self(__unchecked: (), result)
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

// MARK: - Protocol Conformances

extension Cardinal: Equation.`Protocol` {}
extension Cardinal: Comparison.`Protocol` {}
