import Property
import Property_Test_Support
import Testing

@Suite
struct `Inout properties preserve pointer reads and mutations` {
    @Suite struct `Inout property access supports stored values and stable borrowing` {}
    @Suite struct `No inout property boundary cases are defined` {}
    @Suite struct `Inout property pointers expose tuple elements` {}
}

extension `Inout properties preserve pointer reads and mutations`.`Inout property access supports stored values and stable borrowing` {

    @Test
    func `Property pointers read stored property values`() {
        let box = Box(value: 77)

        let result = unsafe Property::Property<Box.Inspect, Box>.pointer(
            to: box.value
        ) { pointer in
            unsafe pointer.pointee * 2
        }

        #expect(result == 154)
    }

    @Test
    func `Mutating property pointers write through to the stored value`() {
        var scalar = 50

        unsafe Property::Property<Box.Inspect, Box>.pointer(
            to: &scalar,
            mutating: { pointer in
                unsafe pointer.pointee += 25
            }
        )

        #expect(scalar == 75)
    }

    @Test
    func `init from inout base enables value reads`() {
        var box = Box(value: 200)
        let accessor = Property::Property<Box.Inspect, Box>.Inout(&box)
        let value = accessor.base.value.value

        #expect(value == 200)
    }

    @Test
    func `Unsafe borrowed property construction supports a read across module boundaries`() {

        let box = Box(value: 321)
        let accessor = unsafe Property::Property<Box.Inspect, Box>.Inout(box)
        let first = accessor.base.value.value
        #expect(first == 321)
    }

    @Test
    func `Unsafe borrowed property construction preserves repeated reads across module boundaries`() {

        let box = Box(value: 654)
        let accessor = unsafe Property::Property<Box.Inspect, Box>.Inout(box)
        let first = accessor.base.value.value
        let second = accessor.base.value.value
        #expect(first == 654)
        #expect(second == 654)
    }
}

extension `Inout properties preserve pointer reads and mutations`.`Inout property pointers expose tuple elements` {

    @Test
    func `Property pointers expose tuple contents`() {
        let box = Box(value: 10)

        let sum = unsafe Property::Property<Box.Inspect, Box>.pointer(
            to: box.storage
        ) { pointer in
            let tuple = unsafe pointer.pointee
            return tuple.0 + tuple.1 + tuple.2 + tuple.3
        }

        #expect(sum == 10)
    }
}
