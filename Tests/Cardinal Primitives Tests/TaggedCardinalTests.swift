import Cardinal_Primitives_Test_Support
import Testing

@testable import Cardinal_Primitives

@Suite
struct TaggedCardinalTests {
    // Tag types for the Tagged<Tag, Cardinal> surface.
    enum UserCount {}
    enum InboxCount {}

    typealias Users = Tagged<UserCount, Cardinal>
    typealias InboxItems = Tagged<InboxCount, Cardinal>

    // MARK: - Construction

    @Test
    func `construction from UInt`() {
        let users = Users(100 as UInt)
        #expect(users.underlying == Cardinal(100))
    }

    @Test
    func `construction from int success`() throws(Cardinal.Error) {
        let users = try Users(42)
        #expect(users.underlying == Cardinal(42))
    }

    @Test
    func `construction from int fails for negative`() {
        #expect(throws: Cardinal.Error.negativeSource(-3)) {
            try Users(Int(-3))
        }
    }

    // MARK: - Addition

    @Test
    func `add saturating`() {
        let max = Users(UInt.max)
        let result = max.add.saturating(Users(1 as UInt))
        #expect(result.underlying == Cardinal(UInt.max))
    }

    @Test
    func `add exact throws on overflow`() {
        let max = Users(UInt.max)
        let one = Users(1 as UInt)
        #expect(throws: Cardinal.Error.overflow) {
            try max.add.exact(one)
        }
    }

    @Test
    func `add exact succeeds`() throws(Cardinal.Error) {
        let a = Users(5 as UInt)
        let b = Users(3 as UInt)
        let result = try a.add.exact(b)
        #expect(result.underlying == Cardinal(8))
    }

    @Test
    func `add call as function exact`() throws(Cardinal.Error) {
        let a = Users(5 as UInt)
        let b = Users(3 as UInt)
        let result = try a.add(b)
        #expect(result.underlying == Cardinal(8))
    }

    // MARK: - Subtraction

    @Test
    func `subtract saturating`() {
        let a = Users(5 as UInt)
        let b = Users(3 as UInt)
        let result = a.subtract.saturating(b)
        #expect(result.underlying == Cardinal(2))
    }

    @Test
    func `subtract saturating underflow clamps to zero`() {
        let a = Users(3 as UInt)
        let b = Users(5 as UInt)
        let result = a.subtract.saturating(b)
        #expect(result.underlying == .zero)
    }

    @Test
    func `subtract exact succeeds`() throws(Cardinal.Error) {
        let a = Users(5 as UInt)
        let b = Users(3 as UInt)
        let result = try a.subtract.exact(b)
        #expect(result.underlying == Cardinal(2))
    }

    @Test
    func `subtract exact throws on underflow`() {
        let a = Users(3 as UInt)
        let b = Users(5 as UInt)
        #expect(throws: Cardinal.Error.underflow) {
            try a.subtract.exact(b)
        }
    }

    @Test
    func `subtract call as function exact`() throws(Cardinal.Error) {
        let a = Users(5 as UInt)
        let b = Users(3 as UInt)
        let result = try a.subtract(b)
        #expect(result.underlying == Cardinal(2))
    }

    // MARK: - Tag Discrimination

    @Test
    func `different tags are distinct types`() {
        let users = Users(10 as UInt)
        let inboxItems = InboxItems(10 as UInt)
        #expect(users.underlying == inboxItems.underlying)
        // Compile-time guarantee: `users + inboxItems` does not type-check.
        // Generic code can dispatch on `.Tag` to distinguish them at the
        // type level without runtime overhead.
    }

    // MARK: - Int Conversion

    @Test
    func `int conversion success`() throws(Cardinal.Error) {
        let users = Users(42 as UInt)
        let value = try Int(users)
        #expect(value == 42)
    }

    @Test
    func `int conversion throws on overflow`() {
        let users = Users(UInt.max)
        #expect(throws: Cardinal.Error.overflow) {
            try Int(users)
        }
    }

    @Test
    func `int bit pattern conversion preserves bits`() {
        let users = Users(UInt.max)
        let value = Int(bitPattern: users)
        #expect(value == -1)
    }

    @Test
    func `int clamping conversion at max`() {
        let users = Users(UInt.max)
        let value = Int(clamping: users)
        #expect(value == Int.max)
    }
}
