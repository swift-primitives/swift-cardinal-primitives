import Cardinal_Primitives_Test_Support
import Testing

@testable import Cardinal_Primitives

extension Cardinal {
    @Suite
    struct Test {
        @Suite struct Unit {}
        @Suite struct `Edge Case` {}
        @Suite struct Integration {}
        @Suite struct Performance {}
    }
}

// MARK: - Unit

extension Cardinal.Test.Unit {

    // MARK: Construction

    @Test
    func `construction from UInt`() {
        let count: Cardinal = 42
        #expect(count == 42)
    }

    @Test
    func `construction from int success`() {
        let count: Cardinal = 42
        #expect(count == 42)
    }

    @Test
    func `construction succeeds for non-negative`() throws(Cardinal.Error) {
        let result = try Cardinal(42)
        #expect(result == 42)
    }

    // MARK: Constants

    @Test
    func `zero constant`() {
        #expect(Cardinal.zero == 0)
    }

    @Test
    func `one constant`() {
        #expect(Cardinal.one == 1)
    }

    @Test
    func `max constant`() {
        #expect(Cardinal.max.rawValue == UInt.max)
    }

    // MARK: Addition

    @Test
    func `addition operator`() {
        let a: Cardinal = 5
        let b: Cardinal = 3
        #expect((a + b) == 8)
    }

    @Test
    func `add saturating`() {
        let max = Cardinal(UInt.max)
        #expect(max.add.saturating(.one).rawValue == UInt.max)
    }

    @Test
    func `add exact succeeds`() throws(Cardinal.Error) {
        let a: Cardinal = 5
        let b: Cardinal = 3
        let result = try a.add.exact(b)
        #expect(result == 8)
    }

    // MARK: Subtraction (Monus)

    @Test
    func `subtract saturating`() {
        let a: Cardinal = 5
        let b: Cardinal = 3
        #expect(a.subtract.saturating(b) == 2)
    }

    @Test
    func `subtract saturating identity`() {
        let a: Cardinal = 5
        #expect(a.subtract.saturating(.zero) == a)
    }

    @Test
    func `subtract saturating self`() {
        let a: Cardinal = 5
        #expect(a.subtract.saturating(a) == .zero)
    }

    @Test
    func `subtract exact success`() throws(Cardinal.Error) {
        let a: Cardinal = 5
        let b: Cardinal = 3
        let result = try a.subtract.exact(b)
        #expect(result == 2)
    }

    // MARK: Comparison

    @Test
    func comparison() {
        let a: Cardinal = 3
        let b: Cardinal = 5
        #expect(a < b)
        #expect(a <= b)
        #expect(b > a)
        #expect(b >= a)
        #expect(a == a)
        #expect(a != b)
    }
}

// MARK: - Edge Case

extension Cardinal.Test.`Edge Case` {

    @Test
    func `construction from int fails for negative`() {
        #expect(throws: Cardinal.Error.negativeSource(-1)) {
            try Cardinal(Int(-1))
        }
    }

    @Test
    func `add exact throws on overflow`() {
        let max = Cardinal(UInt.max)
        let one = Cardinal.one
        #expect(throws: Cardinal.Error.overflow) {
            try max.add.exact(one)
        }
    }

    @Test
    func `subtract saturating underflow`() {
        let a: Cardinal = 3
        let b: Cardinal = 5
        #expect(a.subtract.saturating(b) == 0)
    }

    @Test
    func `subtract saturating from zero`() {
        let a: Cardinal = 5
        #expect(Cardinal.zero.subtract.saturating(a) == .zero)
    }

    @Test
    func `subtract exact throws on underflow`() {
        let a: Cardinal = 3
        let b: Cardinal = 5
        #expect(throws: Cardinal.Error.underflow) {
            try a.subtract.exact(b)
        }
    }

    @Test
    func `int conversion throws on overflow`() {
        let count = Cardinal(UInt.max)
        #expect(throws: Cardinal.Error.overflow) {
            try Int(count)
        }
    }
}

// MARK: - Integration

extension Cardinal.Test.Integration {

    @Test
    func `description matches UInt`() {
        let count: Cardinal = 42
        #expect(count.description == "42")
    }

    @Test
    func `int conversion success`() throws(Cardinal.Error) {
        let count: Cardinal = 42
        let value = try Int(count)
        #expect(value == 42)
    }

    @Test
    func `int bit pattern conversion preserves bits`() {
        let count = Cardinal(UInt.max)
        let value = Int(bitPattern: count)
        #expect(value == -1)
    }

    @Test
    func `int clamping conversion at max`() {
        let count = Cardinal(UInt.max)
        let value = Int(clamping: count)
        #expect(value == Int.max)
    }
}
