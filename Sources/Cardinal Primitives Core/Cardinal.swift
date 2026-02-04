/// Namespace for cardinal number types.
///
/// Cardinal numbers answer the question "how many?" — they represent the
/// size or cardinality of finite sets. Unlike ordinals (which denote position),
/// cardinals are purely about quantity.
///
/// ## Scope
///
/// This package provides finite cardinals for programming use:
/// - `Cardinal` — a non-negative count backed by `UInt`
///
/// Transfinite cardinals (ℵ₀, 2^ℵ₀, etc.) are explicitly out of scope.
/// This is "finite cardinals for programming," not set-theoretic cardinality.

/// A finite cardinal number representing quantity.
///
/// `Cardinal` answers "how many?" with a non-negative integer.
/// It is backed by `UInt` to make non-negativity representational
/// rather than runtime-checked.
///
/// ## Usage
///
/// ```swift
/// let items = Cardinal(5)
/// let total = items + Cardinal(3)  // 8
///
/// // Policy-aware subtraction (monus)
/// let remaining = items.subtract.saturating(Cardinal(2))  // 3
/// let result = try items.subtract.exact(Cardinal(10))     // throws .underflow
/// ```
///
/// ## Design
///
/// - **Backing**: `UInt` (machine word) ensures non-negativity at the type level
/// - **Addition**: Trapping `+` operator matches Swift integer semantics
/// - **Subtraction**: No `-` operator; use `.subtract.saturating` (monus) or `.subtract.exact`
public struct Cardinal {
    /// The underlying unsigned integer value.
    public let rawValue: UInt
}

extension Cardinal: Hashable {}
extension Cardinal: Comparable {}
extension Cardinal: Sendable {}

extension Cardinal {
    
    // MARK: - Construction
    
    /// Creates a count from an unsigned integer.
    ///
    /// - Parameter value: The non-negative count value.
    @inlinable
    public init(_ value: UInt) {
        self.rawValue = value
    }
}

extension Cardinal.`Protocol` {
    // MARK: - Constants

    /// The zero count.
    @inlinable
    public static var zero: Self { Self(Cardinal(0)) }

    /// The count of one.
    @inlinable
    public static var one: Self { Self(Cardinal(1)) }
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
        return Self(result)
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
