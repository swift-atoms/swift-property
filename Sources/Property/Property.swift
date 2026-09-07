public struct Property<Tag: ~Copyable & ~Escapable, Base: ~Copyable>: ~Copyable {

    @usableFromInline
    internal var _base: Base

    @inlinable
    public init(_ base: consuming Base) {
        self._base = base
    }
}

extension Property::Property where Base: ~Copyable {

    @inlinable
    public var base: Base {
        _read { yield _base }
        _modify { yield &_base }
    }
}

extension Property::Property: Swift.Copyable where Tag: ~Swift.Copyable & ~Escapable, Base: Swift.Copyable {}

extension Property::Property: Swift.Sendable where Tag: ~Copyable & ~Escapable, Base: Swift.Sendable {}
