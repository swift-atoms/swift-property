import Property
import Property_Test_Support
import Testing

@Suite
struct `Borrowed properties lend their underlying values without mutation` {
    @Suite struct `Borrowed property construction supports mutable and immutable bindings` {}
    @Suite struct `Repeated property borrowing preserves the original value` {}
    @Suite struct `No borrowed property integration cases are defined` {}
}

extension `Borrowed properties lend their underlying values without mutation`.`Borrowed property construction supports mutable and immutable bindings` {

    @Test
    func `Borrowed property access exposes the base value`() {
        var box = Box(value: 42)

        #expect(box.inspect.current == 42)
        #expect(box.inspect.first == 1)
    }

    @Test
    func `Borrowed property construction accepts an immutable binding`() {
        let box = Box(value: 42)

        #expect(box.borrow.current == 42)
        #expect(box.borrow.first == 1)
    }
}

extension `Borrowed properties lend their underlying values without mutation`.`Repeated property borrowing preserves the original value` {

    @Test
    func `borrow accessor does not mutate`() {
        var box = Box(value: 100)

        let first = box.inspect.current
        let second = box.inspect.current

        #expect(first == 100)
        #expect(second == 100)
    }

    @Test
    func `borrowing init supports multiple reads`() {
        let box = Box(value: 100)

        let first = box.borrow.current
        let second = box.borrow.current

        #expect(first == 100)
        #expect(second == 100)
    }
}
