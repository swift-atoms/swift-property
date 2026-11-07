public import Carrier

extension Property::Property: Carrier.`Protocol` where Base: ~Copyable {

    public typealias Underlying = Base

    public typealias Domain = Tag

    @inlinable
    public var underlying: Base {
        _read { yield base }
    }
}
