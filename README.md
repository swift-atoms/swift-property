
## Module organization

Import `Property` to use the core API, including the protocols and operations formerly supplied by separate modules. It re-exports `Carrier`, `Ownership`, and `Tagged`. Dependency exports live in `Sources/Property/exports.swift`.

`Property Test Support` lives in `Tests/Support`. Foundation integration can be added as `Property Foundation Library Integration` when needed.
