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
        .library(name: "Property Standard Library Integration", targets: ["Property Standard Library Integration"]),
        .library(name: "Property Foundation Library Integration", targets: ["Property Foundation Library Integration"]),
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
            name: "Property Standard Library Integration",
            dependencies: [
                .target(name: "Property"),
            ],
            path: "Sources/Property Standard Library Integration"
        ),
        .target(
            name: "Property Foundation Library Integration",
            dependencies: [
                .target(name: "Property"),
                .target(name: "Property Standard Library Integration"),
            ],
            path: "Sources/Property Foundation Library Integration"
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
                .target(name: "Property Standard Library Integration"),
                .target(name: "Property Foundation Library Integration"),
            ],
            path: "Tests/Property Tests"
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
