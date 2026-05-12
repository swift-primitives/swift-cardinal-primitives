import Cardinal_Primitives_Test_Support
import Testing

@testable import Cardinal_Primitives

@Suite
struct CardinalCountTests {
    // MARK: - Construction

    @Test
    func constructionFromUInt() {
        let count: Cardinal = 42
        #expect(count == 42)
    }

    @Test
    func constructionFromIntSuccess() {
        let count: Cardinal = 42
        #expect(count == 42)
    }

    @Test
    func constructionFromIntFailsForNegative() {
        #expect(throws: Cardinal.Error.negativeSource(-1)) {
            try Cardinal(Int(-1))
        }
    }

    @Test
    func constructionExactlyReturnsNilForNegative() {
        #expect((try? Cardinal(Int(-1))) == nil)
    }

    @Test
    func constructionExactlySucceeds() {
        #expect((try? Cardinal(42)) == 42)
    }

    // MARK: - Constants

    @Test
    func zeroConstant() {
        #expect(Cardinal.zero == 0)
    }

    @Test
    func oneConstant() {
        #expect(Cardinal.one == 1)
    }

    @Test
    func maxConstant() {
        #expect(Cardinal.max.rawValue == UInt.max)
    }

    // MARK: - Addition

    @Test
    func additionOperator() {
        let a: Cardinal = 5
        let b: Cardinal = 3
        #expect((a + b) == 8)
    }

    @Test
    func addSaturating() {
        let max = Cardinal(UInt.max)
        #expect(max.add.saturating(.one).rawValue == UInt.max)
    }

    @Test
    func addExactThrowsOnOverflow() {
        let max = Cardinal(UInt.max)
        let one = Cardinal.one
        #expect(throws: Cardinal.Error.overflow) {
            try max.add.exact(one)
        }
    }

    @Test
    func addExactSucceeds() throws(Cardinal.Error) {
        let a: Cardinal = 5
        let b: Cardinal = 3
        let result = try a.add.exact(b)
        #expect(result == 8)
    }

    // MARK: - Subtraction (Monus)

    @Test
    func subtractSaturating() {
        let a: Cardinal = 5
        let b: Cardinal = 3
        #expect(a.subtract.saturating(b) == 2)
    }

    @Test
    func subtractSaturatingUnderflow() {
        let a: Cardinal = 3
        let b: Cardinal = 5
        #expect(a.subtract.saturating(b) == 0)
    }

    @Test
    func subtractSaturatingIdentity() {
        let a: Cardinal = 5
        #expect(a.subtract.saturating(.zero) == a)
    }

    @Test
    func subtractSaturatingFromZero() {
        let a: Cardinal = 5
        #expect(Cardinal.zero.subtract.saturating(a) == .zero)
    }

    @Test
    func subtractSaturatingSelf() {
        let a: Cardinal = 5
        #expect(a.subtract.saturating(a) == .zero)
    }

    @Test
    func subtractExactSuccess() throws(Cardinal.Error) {
        let a: Cardinal = 5
        let b: Cardinal = 3
        let result = try a.subtract.exact(b)
        #expect(result == 2)
    }

    @Test
    func subtractExactThrowsOnUnderflow() {
        let a: Cardinal = 3
        let b: Cardinal = 5
        #expect(throws: Cardinal.Error.underflow) {
            try a.subtract.exact(b)
        }
    }

    // MARK: - Comparison

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

    // MARK: - String Conversion

    @Test
    func descriptionMatchesUInt() {
        let count: Cardinal = 42
        #expect(count.description == "42")
    }

    // MARK: - Int Conversion

    @Test
    func intConversionSuccess() throws(Cardinal.Error) {
        let count: Cardinal = 42
        let value = try Int(count)
        #expect(value == 42)
    }

    @Test
    func intConversionExactlySuccess() {
        let count: Cardinal = 42
        #expect((try? Int(count)) == 42)
    }

    @Test
    func intConversionThrowsOnOverflow() {
        let count = Cardinal(UInt.max)
        #expect(throws: Cardinal.Error.overflow) {
            try Int(count)
        }
    }

    @Test
    func intBitPatternConversionPreservesBits() {
        let count = Cardinal(UInt.max)
        let value = Int(bitPattern: count)
        #expect(value == -1)
    }

    @Test
    func intClampingConversionAtMax() {
        let count = Cardinal(UInt.max)
        let value = Int(clamping: count)
        #expect(value == Int.max)
    }
}
