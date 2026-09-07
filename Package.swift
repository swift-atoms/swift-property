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
            ]
        ),
        .testTarget(
            name: "Property Tests",
            dependencies: [
                .target(name: "Property"),
                .target(name: "Property Test Support"),
            ]
        ),
        .testTarget(
            name: "Property Carrier Tests",
            dependencies: [
                .target(name: "Property"),
            ]
        ),
        .testTarget(
            name: "Property Typed Tests",
            dependencies: [
                .target(name: "Property"),
                .target(name: "Property Test Support"),
            ]
        ),
        .testTarget(
            name: "Property Consume Tests",
            dependencies: [
                .target(name: "Property"),
                .target(name: "Property Test Support"),
            ]
        ),
        .testTarget(
            name: "Property Inout Tests",
            dependencies: [
                .target(name: "Property"),
                .target(name: "Property Test Support"),
            ]
        ),
        .testTarget(
            name: "Property Borrow Tests",
            dependencies: [
                .target(name: "Property"),
                .target(name: "Property Test Support"),
            ]
        ),
        .target(
            name: "Property Test Support",
            dependencies: [
                .target(name: "Property"),
            ],
            path: "Tests/Support"
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
