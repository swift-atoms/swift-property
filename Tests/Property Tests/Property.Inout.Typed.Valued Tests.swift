import Property
import Property_Test_Support
import Testing

@Suite
struct `Valued inout properties bind value parameters and preserve writes` {
    @Suite struct `Valued inout property access binds its generic and writes through` {}
    @Suite struct `Valued property counts remain independent of the phantom parameter` {}
    @Suite struct `No valued inout property integration cases are defined` {}
}

extension `Valued inout properties bind value parameters and preserve writes`.`Valued inout property access binds its generic and writes through` {

    @Test
    func `valued accessor binds value generic in extension where-clause`() {
        var inline = Slice<Int>.Inline<5>(count: 3)

        #expect(inline.access.capacity == 5)
        #expect(inline.access.size == 3)
    }

    @Test
    func `valued accessor mutation writes through pointer`() {
        var inline = Slice<Int>.Inline<8>(count: 2)

        inline.access.resize(to: 7)
        #expect(inline.count == 7)
        #expect(inline.access.size == 7)
    }
}

extension `Valued inout properties bind value parameters and preserve writes`.`Valued property counts remain independent of the phantom parameter` {

    @Test
    func `count is not constrained by the value generic n (phantom semantics)`() {

        var overCapacity = Slice<Int>.Inline<3>(count: 100)
        var underCapacity = Slice<Int>.Inline<3>(count: 0)

        #expect(overCapacity.access.capacity == 3)
        #expect(overCapacity.access.size == 100)

        #expect(underCapacity.access.capacity == 3)
        #expect(underCapacity.access.size == 0)
    }
}
