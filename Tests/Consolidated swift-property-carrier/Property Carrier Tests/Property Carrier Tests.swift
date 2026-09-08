import enum Carrier.Carrier
import struct Property.Property
import Property
import Testing

private enum Name {}

@Suite
struct `Property Carrier Tests` {
    @Test
    func `Underlying is the property base`() {
        let property = Property<Name, Int>(42)

        #expect(property.underlying == 42)
    }

    @Test
    func `Domain preserves the property tag`() {
        #expect(Property<Name, Int>.Domain.self == Name.self)
    }

    @Test
    func `Property satisfies a generic Carrier constraint`() {
        func extract<Value: Carrier.`Protocol`>(_ value: borrowing Value) -> Int
        where Value.Underlying == Int {
            value.underlying
        }

        #expect(extract(Property<Name, Int>(42)) == 42)
    }

    @Test
    func `Carrier initializer constructs a property`() {
        func make<Value: Carrier.`Protocol`>(
            _: Value.Type,
            underlying: consuming Value.Underlying
        ) -> Value {
            Value(underlying)
        }

        let property = make(Property<Name, Int>.self, underlying: 42)

        #expect(property.base == 42)
    }
}
