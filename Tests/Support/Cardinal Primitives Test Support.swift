public import Cardinal_Primitives

// MARK: - ExpressibleByIntegerLiteral (Test Support)
//
// This conformance bypasses validation and should only be used in tests.
// Production code should use explicit initializers.

extension Cardinal.Count: ExpressibleByIntegerLiteral {
    @_disfavoredOverload
    public init(integerLiteral value: UInt) {
        self.init(__unchecked: value)
    }
}
