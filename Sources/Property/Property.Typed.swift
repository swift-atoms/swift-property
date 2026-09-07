extension Property::Property where Base: ~Copyable {

    public struct Typed<Element>: ~Copyable {

        @usableFromInline
        internal var _base: Base

        @inlinable
        public init(_ base: consuming Base) {
            self._base = base
        }
    }
}

extension Property::Property.Typed where Base: ~Copyable {

    @inlinable
    public var base: Base {
        _read { yield _base }
        _modify { yield &_base }
    }
}

extension Property::Property.Typed: Swift.Copyable where Base: Swift.Copyable {}

extension Property::Property.Typed: Swift.Sendable where Base: Swift.Sendable {}
