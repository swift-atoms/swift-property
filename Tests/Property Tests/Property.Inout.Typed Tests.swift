import Property
import Property_Test_Support
import Testing

@Suite
struct `Typed inout properties write mutations through to their base` {
    @Suite struct `Typed inout property access preserves reads and writes` {}
    @Suite struct `Sequential typed property mutations persist independently` {}
    @Suite struct `Condition driven draining terminates through an inout property view` {}
}

extension `Typed inout properties write mutations through to their base`.`Typed inout property access preserves reads and writes` {

    @Test
    func `Typed inout property access exposes the base value`() {
        var slice = Slice<Int>(count: 5)
        #expect(slice.access.size == 5)
    }

    @Test
    func `inout typed mutation writes through pointer`() {
        var slice = Slice<Int>(count: 5)

        slice.access.resize(to: 12)
        #expect(slice.count == 12)
        #expect(slice.access.size == 12)
    }
}

extension `Typed inout properties write mutations through to their base`.`Sequential typed property mutations persist independently` {

    @Test
    func `sequential mutations each persist independently`() {
        var slice = Slice<Int>(count: 0)

        slice.access.resize(to: 5)
        let afterFirst = slice.access.size

        slice.access.resize(to: 12)
        let afterSecond = slice.access.size

        slice.access.resize(to: 3)
        let afterThird = slice.access.size

        #expect(afterFirst == 5)
        #expect(afterSecond == 12)
        #expect(afterThird == 3)
        #expect(slice.count == 3)
    }
}

extension `Typed inout properties write mutations through to their base`.`Condition driven draining terminates through an inout property view` {

    @Test
    func `condition-driven drain through inout view terminates`() {
        var slice = Slice<Int>(count: 3)
        #expect(slice.drainAll() == 3)
        #expect(slice.count == 0)
    }
}
