#if !hasFeature(Embedded)
import Synchronization
#endif


extension Property::Property.Consume.State: @unchecked Swift.Sendable where Base: Swift.Sendable {}
