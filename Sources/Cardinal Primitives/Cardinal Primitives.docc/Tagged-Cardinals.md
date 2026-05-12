# Tagged Cardinals

@Metadata {
    @TitleHeading("Cardinal Primitives")
}

Phantom-tagged count types — `Tagged<Tag, Cardinal>` — and how they compose with the bare `Cardinal` arithmetic surface.

## Overview

Bare ``Cardinal_Primitives_Core/Cardinal`` answers *"how many?"*. Often the answer is more specific: *how many users? how many inbox items? how many bytes?* Mixing those counts in arithmetic is usually a defect — adding a user-count to an inbox-count is meaningless. The `Tagged` primitive (from `swift-tagged-primitives`) supplies a phantom-tag mechanism that makes the distinction representable in the type system:

```swift
extension User { enum Count {} }
extension Inbox { enum Count {} }

let users: Tagged<User.Count, Cardinal> = 100
let inboxItems: Tagged<Inbox.Count, Cardinal> = 12

// users + inboxItems    // ❌ compile error — different tags
// users + Cardinal(1)   // ❌ compile error — different shapes

let nextUsers = try users.add.exact(Tagged<User.Count, Cardinal>(1))   // 101
```

`Cardinal Primitives` ships the `Tagged<Tag, Cardinal>` arithmetic accessors so per-domain count types compose with the same `.add` / `.subtract` API the bare `Cardinal` exposes:

- `Tagged<Tag, Cardinal>.add.saturating(_:)` / `.exact(_:)` / `callAsFunction(_:)`
- `Tagged<Tag, Cardinal>.subtract.saturating(_:)` / `.exact(_:)` / `callAsFunction(_:)`

The accessors carry the same overflow / underflow policy semantics as the bare-Cardinal versions.

## `Tag: ~Copyable` — what the constraint says

The `Tagged<Tag, Cardinal>` accessors are declared on:

```swift
extension Tagged where Underlying == Cardinal, Tag: ~Copyable {
    public init(_ uint: UInt) { ... }
    public init(_ int: Int) throws(Cardinal.Error) { ... }
}
```

The `Tag: ~Copyable` bound forwards the noncopyable-Tag possibility from `Tagged` itself — Tagged admits `Tag: ~Copyable` for tags that are themselves move-only (e.g., a tag that wraps a unique resource). Cardinal itself remains `Copyable`; the bound applies only to the phantom Tag, not to Cardinal.

For a Tag that is plain `Copyable` (the common case — `User.Count` is an `enum` with no cases), the `~Copyable` bound is a no-op and the constraint matches automatically.

## Standard Library Integration

The Standard Library Integration target ships overloads accepting `some Carrier.`Protocol`<Cardinal>` — meaning the same call sites accept *both* bare `Cardinal` and `Tagged<Tag, Cardinal>` as counts:

```swift
// All three call sites compile, all reach the same SLI overload
buffer.allocate(capacity: Cardinal(64))
buffer.allocate(capacity: bytes)                    // Tagged<Buffer.Bytes, Cardinal>
buffer.allocate(capacity: requestedSize.underlying) // Carrier-of-Cardinal of any shape
```

The SLI surface includes `UnsafeBufferPointer`, `UnsafeMutableBufferPointer`, `Span`, `MutableSpan`, `OutputSpan`, `ContiguousArray`, `UnsafeMutablePointer`, and `UInt32` initializers. Each accepts `some Carrier.`Protocol`<Cardinal>` as a count parameter, lifting the typed-cardinal API into the standard library's untyped-`Int` shape.

## Int Conversion

The `Int` conversion path goes through `Tagged<Tag, Cardinal>`'s underlying:

```swift
extension Int {
    public init<Tag: ~Copyable>(_ count: Tagged<Tag, Cardinal>) throws(Cardinal.Error)
    public init<Tag: ~Copyable>(bitPattern count: Tagged<Tag, Cardinal>)
    public init<Tag: ~Copyable>(clamping count: Tagged<Tag, Cardinal>)
}
```

Each variant matches the bare-Cardinal version of the same name; the Tagged routing layer extracts the underlying `Cardinal` and delegates.
