// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-property",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(name: "Property", targets: ["Property"]),

        .library(name: "Property Foundation Integration", targets: ["Property Foundation Integration"]),
        .library(name: "Property Test Support", targets: ["Property Test Support"]),
    ],
    dependencies: [

        .package(
            url: "https://github.com/swift-atoms/swift-ownership.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-tagged.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-carrier.git",
            branch: "main"
        ),
    ],
    targets: [
        .target(
            name: "Property",
            dependencies: [
                .product(name: "Carrier", package: "swift-carrier"),
                .product(name: "Ownership", package: "swift-ownership"),
                .product(name: "Tagged", package: "swift-tagged"),
            ],
            path: "Sources/Property"
        ),
        
        .target(
            name: "Property Foundation Integration",
            dependencies: [
                .target(name: "Property"),
            ],
            path: "Sources/Property Foundation Integration"
        ),
        .target(
            name: "Property Test Support",
            dependencies: [
                .target(name: "Property"),
            ],
            path: "Tests/Support"
        ),
        .testTarget(
            name: "Property Tests",
            dependencies: [
                .target(name: "Property"),
                .target(name: "Property Test Support"),
                .target(name: "Property Foundation Integration"),
            ],
            path: "Tests/Property Tests"
        ),
        .testTarget(
            name: "Consolidated Property Carrier Tests",
            dependencies: [

                .target(name: "Property"),
                .product(name: "Carrier", package: "swift-carrier"),
            ],
            path: "Tests/Consolidated swift-property-carrier"
        ),
        .testTarget(
            name: "Consolidated Property Ownership Tests",
            dependencies: [

                .target(name: "Property"),
                .product(name: "Ownership", package: "swift-ownership"),
                .product(name: "Tagged", package: "swift-tagged"),
            ],
            path: "Tests/Consolidated swift-property-ownership"
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets {
    target.swiftSettings = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]
}
