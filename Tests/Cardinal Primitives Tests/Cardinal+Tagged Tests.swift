import Cardinal_Primitives_Test_Support
import Testing

@testable import Cardinal_Primitives

private enum UserCount {}
private enum InboxCount {}

extension Cardinal {
    @Suite
    struct Tagged {
        @Suite struct Unit {}
        @Suite struct `Edge Case` {}
        @Suite struct Integration {}
        @Suite struct Performance {}
    }
}

// MARK: - Unit

extension Cardinal.Tagged.Unit {

    // MARK: Construction

    @Test
    func `construction from UInt`() {
        let users = Tagged_Primitives.Tagged<UserCount, Cardinal>(100 as UInt)
        #expect(users.underlying == Cardinal(100))
    }

    @Test
    func `construction from int success`() throws(Cardinal.Error) {
        let users = try Tagged_Primitives.Tagged<UserCount, Cardinal>(42)
        #expect(users.underlying == Cardinal(42))
    }

    // MARK: Addition

    @Test
    func `add saturating`() {
        let max = Tagged_Primitives.Tagged<UserCount, Cardinal>(UInt.max)
        let result = max.add.saturating(Tagged_Primitives.Tagged<UserCount, Cardinal>(1 as UInt))
        #expect(result.underlying == Cardinal(UInt.max))
    }

    @Test
    func `add exact succeeds`() throws(Cardinal.Error) {
        let a = Tagged_Primitives.Tagged<UserCount, Cardinal>(5 as UInt)
        let b = Tagged_Primitives.Tagged<UserCount, Cardinal>(3 as UInt)
        let result = try a.add.exact(b)
        #expect(result.underlying == Cardinal(8))
    }

    @Test
    func `add call as function exact`() throws(Cardinal.Error) {
        let a = Tagged_Primitives.Tagged<UserCount, Cardinal>(5 as UInt)
        let b = Tagged_Primitives.Tagged<UserCount, Cardinal>(3 as UInt)
        let result = try a.add(b)
        #expect(result.underlying == Cardinal(8))
    }

    // MARK: Subtraction

    @Test
    func `subtract saturating`() {
        let a = Tagged_Primitives.Tagged<UserCount, Cardinal>(5 as UInt)
        let b = Tagged_Primitives.Tagged<UserCount, Cardinal>(3 as UInt)
        let result = a.subtract.saturating(b)
        #expect(result.underlying == Cardinal(2))
    }

    @Test
    func `subtract exact succeeds`() throws(Cardinal.Error) {
        let a = Tagged_Primitives.Tagged<UserCount, Cardinal>(5 as UInt)
        let b = Tagged_Primitives.Tagged<UserCount, Cardinal>(3 as UInt)
        let result = try a.subtract.exact(b)
        #expect(result.underlying == Cardinal(2))
    }

    @Test
    func `subtract call as function exact`() throws(Cardinal.Error) {
        let a = Tagged_Primitives.Tagged<UserCount, Cardinal>(5 as UInt)
        let b = Tagged_Primitives.Tagged<UserCount, Cardinal>(3 as UInt)
        let result = try a.subtract(b)
        #expect(result.underlying == Cardinal(2))
    }

    // MARK: Tag Discrimination

    @Test
    func `different tags are distinct types`() {
        let users = Tagged_Primitives.Tagged<UserCount, Cardinal>(10 as UInt)
        let inboxItems = Tagged_Primitives.Tagged<InboxCount, Cardinal>(10 as UInt)
        #expect(users.underlying == inboxItems.underlying)
        // Compile-time guarantee: `users + inboxItems` does not type-check.
        // Generic code can dispatch on `.Tag` to distinguish them at the
        // type level without runtime overhead.
    }
}

// MARK: - Edge Case

extension Cardinal.Tagged.`Edge Case` {

    @Test
    func `construction from int fails for negative`() {
        #expect(throws: Cardinal.Error.negativeSource(-3)) {
            try Tagged_Primitives.Tagged<UserCount, Cardinal>(Int(-3))
        }
    }

    @Test
    func `add exact throws on overflow`() {
        let max = Tagged_Primitives.Tagged<UserCount, Cardinal>(UInt.max)
        let one = Tagged_Primitives.Tagged<UserCount, Cardinal>(1 as UInt)
        #expect(throws: Cardinal.Error.overflow) {
            try max.add.exact(one)
        }
    }

    @Test
    func `subtract saturating underflow clamps to zero`() {
        let a = Tagged_Primitives.Tagged<UserCount, Cardinal>(3 as UInt)
        let b = Tagged_Primitives.Tagged<UserCount, Cardinal>(5 as UInt)
        let result = a.subtract.saturating(b)
        #expect(result.underlying == .zero)
    }

    @Test
    func `subtract exact throws on underflow`() {
        let a = Tagged_Primitives.Tagged<UserCount, Cardinal>(3 as UInt)
        let b = Tagged_Primitives.Tagged<UserCount, Cardinal>(5 as UInt)
        #expect(throws: Cardinal.Error.underflow) {
            try a.subtract.exact(b)
        }
    }

    @Test
    func `int conversion throws on overflow`() {
        let users = Tagged_Primitives.Tagged<UserCount, Cardinal>(UInt.max)
        #expect(throws: Cardinal.Error.overflow) {
            try Int(users)
        }
    }
}

// MARK: - Integration

extension Cardinal.Tagged.Integration {

    @Test
    func `int conversion success`() throws(Cardinal.Error) {
        let users = Tagged_Primitives.Tagged<UserCount, Cardinal>(42 as UInt)
        let value = try Int(users)
        #expect(value == 42)
    }

    @Test
    func `int bit pattern conversion preserves bits`() {
        let users = Tagged_Primitives.Tagged<UserCount, Cardinal>(UInt.max)
        let value = Int(bitPattern: users)
        #expect(value == -1)
    }

    @Test
    func `int clamping conversion at max`() {
        let users = Tagged_Primitives.Tagged<UserCount, Cardinal>(UInt.max)
        let value = Int(clamping: users)
        #expect(value == Int.max)
    }
}
