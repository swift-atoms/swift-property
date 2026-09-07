import Property
import Testing

@Suite
struct PropertyExportsTests {
    private enum Domain {}

    @Test
    func `one import exposes the core dependencies`() {
        let tagged = Tagged<Domain, Int>(_unchecked: 42)
        let property = Property<Domain, Int>(tagged.underlying)

        func read<C: Carrier.`Protocol`>(_ carrier: C) -> Int where C.Underlying == Int {
            carrier.underlying
        }

        #expect(read(tagged) == 42)
        #expect(read(property) == 42)

        var value = 1
        do {
            let reference = Ownership.Inout(mutating: &value)
            reference.value = 2
        }
        #expect(value == 2)
    }
}
