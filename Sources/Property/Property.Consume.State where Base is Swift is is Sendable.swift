#if !hasFeature(Embedded)
    import Synchronization

    extension Property::Property.Consume.State: @unchecked Swift::Sendable where Base: Swift::Sendable {}
#endif
