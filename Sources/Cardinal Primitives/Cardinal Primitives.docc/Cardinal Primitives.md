# ``Cardinal_Primitives``

@Metadata {
    @DisplayName("Cardinal Primitives")
    @TitleHeading("Swift Institute — Primitives Layer")
}

A typed cardinal-number primitive — `Cardinal`, a non-negative count, with policy-aware arithmetic and a phantom-tagged variant for per-domain count types.

## Overview

`Cardinal Primitives` ships ``Cardinal_Primitives_Core/Cardinal``, a value type backed by `UInt` that answers the question *"how many?"*. Cardinal is non-negative by representation: the `UInt` backing makes negativity unrepresentable rather than checked-and-rejected at runtime. Arithmetic is policy-aware: trapping `+` for the everyday case (Swift integer semantics), saturating and throwing variants via `.add` / `.subtract` accessors when the consumer needs control over overflow / underflow.

Cardinal is the first of three packages in **Story 1 of the data-structures cohort**: cardinal (count), ordinal (position), affine (offset) — three things stdlib calls `Int`. The package also ships `Tagged<Tag, Cardinal>` arithmetic accessors so per-domain count types (`Tagged<User.Count, Cardinal>`, `Tagged<Inbox.Count, Cardinal>`) compose naturally with the Tagged primitive.

## Topics

### Essentials

- <doc:Cardinal>
- <doc:Tagged-Cardinals>

### Core Type

- ``Cardinal_Primitives_Core/Cardinal``
- ``Cardinal_Primitives_Core/Cardinal/Error``

### Standard-Library Integration

- ``Swift/Int/init(_:)-2cardinal``
- ``Swift/Int/init(bitPattern:)``
- ``Swift/Int/init(clamping:)``
