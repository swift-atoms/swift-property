import Property
import Property_Test_Support
import Testing

@Suite
struct `Valued borrowed properties bind their value parameter` {
    @Suite struct `Valued borrowed accessors preserve their value generic and immutable base` {}
    @Suite struct `Valued property borrowing leaves its base unchanged` {}
    @Suite struct `No valued borrowed property integration cases are defined` {}
}

extension `Valued borrowed properties bind their value parameter`.`Valued borrowed accessors preserve their value generic and immutable base` {

    @Test
    func `valued borrow accessor binds value generic in extension where-clause`() {
        var inline = Slice<Int>.Inline<7>(count: 4)

        #expect(inline.inspect.capacity == 7)
        #expect(inline.inspect.size == 4)
    }

    @Test
    func `Valued borrowed property construction accepts an immutable base`() {
        let inline = Slice<Int>.Inline<5>(count: 3)

        let accessor = Property::Property<
            Slice<Int>.Inline<5>.Inspect,
            Slice<Int>.Inline<5>
        >.Borrow.Typed<Int>.Valued<5>(inline)

        let count = accessor.base.value.count

        #expect(count == 3)
    }
}

extension `Valued borrowed properties bind their value parameter`.`Valued property borrowing leaves its base unchanged` {

    @Test
    func `valued borrow accessor does not mutate`() {
        var inline = Slice<Int>.Inline<3>(count: 2)

        let firstRead = inline.inspect.size
        let secondRead = inline.inspect.size

        #expect(firstRead == 2)
        #expect(secondRead == 2)
        #expect(inline.count == 2)
    }
}
