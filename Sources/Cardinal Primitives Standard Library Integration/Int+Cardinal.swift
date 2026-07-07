public import Cardinal_Error_Primitives
public import Cardinal_Primitive
public import Carrier_Primitives

// MARK: - Int to Cardinal Conversions

extension Cardinal {
    /// Creates a count from a signed integer, throwing if negative.
    ///
    /// - Parameter value: The signed integer value.
    /// - Throws: `Cardinal.Error.negativeSource` if `value < 0`.
    @inlinable
    public init(
        _ value: Swift.Int
    ) throws(Self.Error) {
        guard value >= .zero else {
            throw .negativeSource(value)
        }
        self.init(UInt(value))
    }

}

// MARK: - Cardinal to Int Conversions

extension Int {
    /// Creates an integer from a cardinal, throwing if it exceeds `Int.max`.
    ///
    /// - Parameter cardinal: The cardinal count.
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

    /// Creates an integer by reinterpreting the bit pattern of any
    /// `Carrier.`Protocol`<Cardinal>` conformer.
    ///
    /// Generic typed-Cardinal overload covering bare `Cardinal` AND phantom-typed
    /// `Tagged<Tag, Cardinal>` (including `Index<Element>.Count`,
    /// `Memory.Address.Count`, etc.) without requiring callers to unwrap via
    /// `.underlying` / `.cardinal` accessor chains at the call site.
    ///
    /// - Parameter carrier: Any conformer to `Carrier.`Protocol`<Cardinal>`.
    @inlinable
    public init(bitPattern carrier: some Carrier.`Protocol`<Cardinal>) {
        self = Int(bitPattern: carrier.underlying)
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
