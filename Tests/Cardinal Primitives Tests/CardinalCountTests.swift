import Testing
@testable import Cardinal_Primitives
import Cardinal_Primitives_Test_Support

@Suite
struct CardinalCountTests {
    // MARK: - Construction

    @Test
    func constructionFromUInt() throws {
        let count: Cardinal.Count = 42
        #expect(count == 42)
    }

    @Test
    func constructionFromIntSuccess() throws {
        let count: Cardinal.Count = 42
        #expect(count == 42)
    }

    @Test
    func constructionFromIntFailsForNegative() {
        #expect(throws: Cardinal.Count.Error.negativeSource(-1)) {
            try Cardinal.Count(Int(-1))
        }
    }

    @Test
    func constructionExactlyReturnsNilForNegative() {
        #expect(Cardinal.Count(exactly: Int(-1)) == nil)
    }

    @Test
    func constructionExactlySucceeds() {
        #expect(Cardinal.Count(exactly: 42) == 42)
    }

    // MARK: - Constants

    @Test
    func zeroConstant() {
        #expect(Cardinal.Count.zero == 0)
    }

    @Test
    func oneConstant() {
        #expect(Cardinal.Count.one == 1)
    }

    // MARK: - Addition

    @Test
    func additionOperator() throws {
        let a: Cardinal.Count = 5
        let b: Cardinal.Count = 3
        #expect((a + b) == 8)
    }

    @Test
    func addSaturating() throws {
        let max = Cardinal.Count(UInt.max)
        #expect(max.add.saturating(.one).rawValue == UInt.max)
    }

    @Test
    func addExactThrowsOnOverflow() {
        let max = Cardinal.Count(UInt.max)
        let one = Cardinal.Count.one
        #expect(throws: Cardinal.Count.Error.overflow) {
            try max.add.exact(one)
        }
    }

    @Test
    func addExactSucceeds() throws {
        let a: Cardinal.Count = 5
        let b: Cardinal.Count = 3
        let result = try a.add.exact(b)
        #expect(result == 8)
    }

    // MARK: - Subtraction (Monus)

    @Test
    func subtractSaturating() throws {
        let a: Cardinal.Count = 5
        let b: Cardinal.Count = 3
        #expect(a.subtract.saturating(b) == 2)
    }

    @Test
    func subtractSaturatingUnderflow() throws {
        let a: Cardinal.Count = 3
        let b: Cardinal.Count = 5
        #expect(a.subtract.saturating(b) == 0)
    }

    @Test
    func subtractSaturatingIdentity() throws {
        let a: Cardinal.Count = 5
        #expect(a.subtract.saturating(.zero) == a)
    }

    @Test
    func subtractSaturatingFromZero() throws {
        let a: Cardinal.Count = 5
        #expect(Cardinal.Count.zero.subtract.saturating(a) == .zero)
    }

    @Test
    func subtractSaturatingSelf() throws {
        let a: Cardinal.Count = 5
        #expect(a.subtract.saturating(a) == .zero)
    }

    @Test
    func subtractExactSuccess() throws {
        let a: Cardinal.Count = 5
        let b: Cardinal.Count = 3
        let result = try a.subtract.exact(b)
        #expect(result == 2)
    }

    @Test
    func subtractExactThrowsOnUnderflow() throws {
        let a: Cardinal.Count = 3
        let b: Cardinal.Count = 5
        #expect(throws: Cardinal.Count.Error.underflow) {
            try a.subtract.exact(b)
        }
    }

    // MARK: - Comparison

    @Test
    func comparison() throws {
        let a: Cardinal.Count = 3
        let b: Cardinal.Count = 5
        #expect(a < b)
        #expect(a <= b)
        #expect(b > a)
        #expect(b >= a)
        #expect(a == a)
        #expect(a != b)
    }

    // MARK: - Int Conversion

    @Test
    func intConversionSuccess() throws {
        let count: Cardinal.Count = 42
        let value = try Int(count)
        #expect(value == 42)
    }

    @Test
    func intConversionExactlySuccess() throws {
        let count: Cardinal.Count = 42
        #expect(Int(exactly: count) == 42)
    }
}
