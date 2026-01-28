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
public struct Cardinal: Hashable, Comparable, Sendable {
    /// The underlying unsigned integer value.
    public let rawValue: UInt
}
