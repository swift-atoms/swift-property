#if !hasFeature(Embedded)
    import Synchronization

    // Sendable only where every read and transition runs under the `Mutex`.
    // Under Embedded the storage is an unsynchronized box, so `State` is not Sendable there.
    extension Property::Property.Consume.State: @unchecked Swift::Sendable where Base: Swift::Sendable {}
#endif
