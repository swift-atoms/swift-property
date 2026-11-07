import Property
import Testing

private enum Fixture {}

enum `Property+Carrier Tests` {}

extension `Property+Carrier Tests` {
    @Suite
    struct `Property carriers preserve their underlying representation` {
        @Test
        func `Property exposes its underlying value through Carrier`() {
            let property = Property::Property<Fixture, Int>(42)
            #expect(property.underlying == 42)
        }
    }
}
