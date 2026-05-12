# ``Cardinal_Primitives_Core/Cardinal``

@Metadata {
    @DisplayName("Cardinal")
    @TitleHeading("Cardinal Primitives")
}

A non-negative finite cardinal number representing a count.

## Overview

`Cardinal` answers the question *"how many?"*. It is backed by `UInt` so that non-negativity is a property of the representation, not a runtime check — there is no construction path that produces a negative cardinal at runtime, and the type system rejects negative literals at compile time.

```swift
let items: Cardinal = 5         // OK — UInt-typed literal
let invalid: Cardinal = -1      // ❌ compile error
```

The arithmetic surface is split across three layers depending on the consumer's overflow / underflow tolerance:

- **Trapping** (`Cardinal.+`, `Cardinal.+=`) — matches Swift integer semantics. Overflow traps; useful when the operands' bounds are statically known.
- **Saturating** (`.add.saturating(_:)`, `.subtract.saturating(_:)`) — clamps at `UInt.max` (addition) or zero (subtraction monus). Total functions; never throw.
- **Exact** (`.add.exact(_:)`, `.subtract.exact(_:)`, `callAsFunction(_:)`) — throws ``Error`` on overflow / underflow. Use when the consumer wants typed-error recovery.

## No `-` operator

Cardinal does **not** provide a `-` operator. Natural-number subtraction is partial: `0 - 1` is undefined for cardinals. The two policy variants — `.subtract.saturating` (monus, clamps at zero) and `.subtract.exact` (throws ``Error/underflow``) — make the partiality explicit at the call site:

```swift
let three: Cardinal = 3
let five: Cardinal = 5

let monus = three.subtract.saturating(five)            // 0  (saturated at zero)
let exact = try three.subtract.exact(five)             // throws .underflow
```

Hiding partiality behind a `-` operator would silently produce wrong values; making the consumer choose a policy is the typed alternative.

## Construction

```swift
public init(_ value: UInt)                                  // Total
public init<T: UnsignedInteger>(_ value: T)                 // Total
public init(_ value: Swift.Int) throws(Cardinal.Error)      // Throws .negativeSource(Int) on negative input
```

`Cardinal: ExpressibleByIntegerLiteral` accepts unsigned literals; negative literals are compile-time errors. The `Int`-taking init is the standard escape hatch when the source is signed, with the rejected value carried in ``Error/negativeSource(_:)``.

## Conformances

| Protocol | Source | Notes |
|----------|--------|-------|
| `Hashable`, `Comparable`, `Sendable` | Auto-synthesized via `let rawValue: UInt`. |  |
| `Equation.`Protocol`` | Cross-package via `swift-equation-primitives`. | Cardinal explicit `==` matches the synthesized version. |
| `Comparison.`Protocol`` | Cross-package via `swift-comparison-primitives`. | Cardinal explicit `<`, `<=`, `>`, `>=` match the synthesized versions; explicit overloads exist to satisfy the protocol's exact-shape requirement. |
| `Carrier.`Protocol`` | Cross-package via `swift-carrier-primitives`. | Trivial self-carrier (`Underlying = Cardinal`). The `Domain` associated type defaults to `Never`. |
| `CustomStringConvertible` |  | Renders the underlying `UInt`. |

## Constants

```swift
public static var zero: Cardinal { ... }   // Cardinal(0)
public static var one: Cardinal { ... }    // Cardinal(1)
public static var max: Cardinal { ... }    // Cardinal(UInt.max)
```

## Topics

### Construction

- ``init(_:)-9w8e6``
- ``init(_:)-3iuop``
- ``init(_:)-89jhx``

### Constants

- ``zero``
- ``one``
- ``max``

### Trapping Arithmetic

- ``+(_:_:)``
- ``+=(_:_:)``

### Policy-Aware Arithmetic

- ``add``
- ``subtract``
- ``Add``
- ``Subtract``

### Errors

- ``Error``
