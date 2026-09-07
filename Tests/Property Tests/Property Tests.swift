import Property
import Property_Test_Support
import Testing

private typealias _PropertyIsCopyable = Require.Copyable<Property::Property<Phantom, Int>>
private typealias _PropertyIsSendable = Require.Sendable<Property::Property<Phantom, Int>>

@Suite
struct `Owned property access preserves values and phantom domains` {
    @Suite struct `Owned properties retain underlying values and nested tags` {}
    @Suite struct `No owned property boundary cases are defined` {}
    @Suite struct `Property operations preserve domain isolation and mutation order` {}
}

extension `Owned property access preserves values and phantom domains`.`Owned properties retain underlying values and nested tags` {

    @Test
    func `Owned property construction preserves its base value`() {
        var property = Property::Property<Phantom, Int>(42)
        #expect(property.base == 42)

        property.base = 100
        #expect(property.base == 100)
    }

    @Test
    func `nested phantom tags compile`() {
        var container = Container(1, 2, 3)
        container.merge.from(Container(4, 5))
        #expect(container.count == 3)
    }
}

extension `Owned property access preserves values and phantom domains`.`Property operations preserve domain isolation and mutation order` {

    @Test
    func `Phantom tag extensions remain isolated to their tag`() {
        var container = Container(1, 2, 3)

        container.push.back(4)
        #expect(container.count == 4)

        let popped = container.pop.back()
        #expect(popped == 4)
        #expect(container.count == 3)
    }

    @Test
    func `modify defer pattern preserves state`() {
        var container = Container(10, 20, 30)

        container.push.back(40)
        container.push.back(50)

        #expect(container.count == 5)
        #expect(container.peek() == 50)
    }

    @Test
    func `Sequential property operations preserve the resulting state`() {
        var container = Container<Int>()

        container.push.back(1)
        container.push.back(2)
        container.push.back(3)
        #expect(container.count == 3)

        #expect(container.pop.back() == 3)
        #expect(container.pop.back() == 2)
        #expect(container.count == 1)

        container.push.back(4)
        #expect(container.pop.back() == 4)
        #expect(container.pop.back() == 1)
        #expect(container.isEmpty)
    }
}
