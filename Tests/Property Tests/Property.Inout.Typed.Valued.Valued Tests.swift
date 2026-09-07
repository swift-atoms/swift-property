import Property
import Property_Test_Support
import Testing

@Suite
struct `Inout properties bind two value parameters while preserving mutation` {
    @Suite struct `Double valued property access binds both generics and writes through` {}
    @Suite struct `Minimal value parameters construct a double valued property accessor` {}
    @Suite struct `No double valued inout property integration cases are defined` {}
}

extension `Inout properties bind two value parameters while preserving mutation`.`Double valued property access binds both generics and writes through` {

    @Test
    func `double valued accessor binds both value generics`() {
        var inner = Slice<Int>.Inline<4>.Inner<9>(count: 3)

        #expect(inner.access.outer == 4)
        #expect(inner.access.inner == 9)
        #expect(inner.access.size == 3)
    }

    @Test
    func `double valued accessor mutation writes through pointer`() {
        var inner = Slice<Int>.Inline<2>.Inner<6>(count: 1)

        inner.access.resize(to: 5)
        #expect(inner.count == 5)
        #expect(inner.access.size == 5)
    }
}

extension `Inout properties bind two value parameters while preserving mutation`.`Minimal value parameters construct a double valued property accessor` {

    @Test
    func `minimum value-generics n=1 m=1 are well-formed`() {
        var inner = Slice<Int>.Inline<1>.Inner<1>(count: 0)

        #expect(inner.access.outer == 1)
        #expect(inner.access.inner == 1)
        #expect(inner.access.size == 0)

        inner.access.resize(to: 1)
        #expect(inner.access.size == 1)
    }
}
