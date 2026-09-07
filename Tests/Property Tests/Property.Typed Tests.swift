import Property_Test_Support
import Property
import Testing

private typealias _TypedIsCopyable = Require.Copyable<Property::Property<Phantom, Int>.Typed<Int>>
private typealias _TypedIsSendable = Require.Sendable<Property::Property<Phantom, Int>.Typed<Int>>

@Suite
struct `Typed owned properties preserve their tagged values` {
    @Suite struct `Typed property construction retains the underlying value` {}
    @Suite struct `No typed owned property boundary cases are defined` {}
    @Suite struct `No typed owned property integration cases are defined` {}
}

extension `Typed owned properties preserve their tagged values`.`Typed property construction retains the underlying value` {

    @Test
    func `Typed owned property access exposes the base value`() {
        var typed = Property::Property<Phantom, Int>.Typed<Int>(42)
        #expect(typed.base == 42)

        typed.base = 100
        #expect(typed.base == 100)
    }
}
