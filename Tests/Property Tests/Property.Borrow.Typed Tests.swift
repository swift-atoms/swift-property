import Property
import Property_Test_Support
import Testing

enum `Property.Borrow.Typed Tests` {}

extension `Property.Borrow.Typed Tests` {
    @Suite
    struct `Typed borrowed properties preserve typed value access` {
    }
}

extension `Property.Borrow.Typed Tests`.`Typed borrowed properties preserve typed value access` {
    @Suite struct `Typed borrowed property construction accepts immutable bindings` {}

    @Suite struct `No typed borrowed property boundary cases are defined` {}

    @Suite struct `No typed borrowed property integration cases are defined` {}
}

extension `Property.Borrow.Typed Tests`.`Typed borrowed properties preserve typed value access`.`Typed borrowed property construction accepts immutable bindings` {

    @Test
    func `Typed borrowed property access exposes the base value`() {
        let slice = Slice<Int>(count: 5)

        #expect(slice.peek.size == 5)
    }

    @Test
    func `Typed borrowed property construction accepts an immutable binding`() {
        let slice = Slice<Int>(count: 7)

        #expect(slice.borrow.size == 7)
    }
}
