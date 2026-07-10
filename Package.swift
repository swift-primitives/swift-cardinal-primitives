// swift-tools-version: 6.3.3
import PackageDescription

let package = Package(
    name: "swift-cardinal-primitives",
    platforms: [
        .macOS(.v26),
        .iOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26),
        .visionOS(.v26),
    ],
    products: [
        // MARK: - Namespace
        .library(
            name: "Cardinal Primitive",
            targets: ["Cardinal Primitive"]
        ),

        // MARK: - Sub-namespace targets
        .library(
            name: "Cardinal Error Primitives",
            targets: ["Cardinal Error Primitives"]
        ),
        .library(
            name: "Cardinal Add Primitives",
            targets: ["Cardinal Add Primitives"]
        ),
        .library(
            name: "Cardinal Subtract Primitives",
            targets: ["Cardinal Subtract Primitives"]
        ),
        .library(
            name: "Cardinal Carrier Primitives",
            targets: ["Cardinal Carrier Primitives"]
        ),
        .library(
            name: "Cardinal Equation Primitives",
            targets: ["Cardinal Equation Primitives"]
        ),
        .library(
            name: "Cardinal Hash Primitives",
            targets: ["Cardinal Hash Primitives"]
        ),
        .library(
            name: "Cardinal Comparison Primitives",
            targets: ["Cardinal Comparison Primitives"]
        ),
        .library(
            name: "Cardinal Tagged Primitives",
            targets: ["Cardinal Tagged Primitives"]
        ),

        // MARK: - StdLib Integration
        .library(
            name: "Cardinal Primitives Standard Library Integration",
            targets: ["Cardinal Primitives Standard Library Integration"]
        ),

        // MARK: - Umbrella
        .library(
            name: "Cardinal Primitives",
            targets: ["Cardinal Primitives"]
        ),

        // MARK: - Test Support
        .library(
            name: "Cardinal Primitives Test Support",
            targets: ["Cardinal Primitives Test Support"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-primitives/swift-tagged-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-carrier-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-property-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-equation-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-hash-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-comparison-primitives.git", branch: "main"),
    ],
    targets: [

        // MARK: - Namespace
        .target(
            name: "Cardinal Primitive",
            dependencies: []
        ),

        // MARK: - Sub-namespace targets (per [MOD-031])
        .target(
            name: "Cardinal Error Primitives",
            dependencies: [
                "Cardinal Primitive",
            ]
        ),
        .target(
            name: "Cardinal Add Primitives",
            dependencies: [
                "Cardinal Primitive",
                "Cardinal Error Primitives",
                .product(name: "Property Primitives", package: "swift-property-primitives"),
            ]
        ),
        .target(
            name: "Cardinal Subtract Primitives",
            dependencies: [
                "Cardinal Primitive",
                "Cardinal Carrier Primitives",
                "Cardinal Error Primitives",
                .product(name: "Property Primitives", package: "swift-property-primitives"),
            ]
        ),
        .target(
            name: "Cardinal Carrier Primitives",
            dependencies: [
                "Cardinal Primitive",
                .product(name: "Carrier Primitives", package: "swift-carrier-primitives"),
            ]
        ),
        .target(
            name: "Cardinal Equation Primitives",
            dependencies: [
                "Cardinal Primitive",
                .product(name: "Equation Primitives", package: "swift-equation-primitives"),
            ]
        ),
        .target(
            name: "Cardinal Hash Primitives",
            dependencies: [
                "Cardinal Primitive",
                .product(name: "Hash Primitives", package: "swift-hash-primitives"),
            ]
        ),
        .target(
            name: "Cardinal Comparison Primitives",
            dependencies: [
                "Cardinal Primitive",
                .product(name: "Comparison Primitives", package: "swift-comparison-primitives"),
            ]
        ),
        .target(
            name: "Cardinal Tagged Primitives",
            dependencies: [
                "Cardinal Primitive",
                "Cardinal Error Primitives",
                "Cardinal Add Primitives",
                "Cardinal Subtract Primitives",
                .product(name: "Property Primitives", package: "swift-property-primitives"),
                .product(name: "Tagged Primitives", package: "swift-tagged-primitives"),
            ]
        ),

        // MARK: - StdLib Integration
        .target(
            name: "Cardinal Primitives Standard Library Integration",
            dependencies: [
                "Cardinal Primitive",
                "Cardinal Error Primitives",
                "Cardinal Carrier Primitives",
                .product(name: "Carrier Primitives", package: "swift-carrier-primitives"),
                .product(name: "Tagged Primitives", package: "swift-tagged-primitives"),
                .product(name: "Tagged Primitives Standard Library Integration", package: "swift-tagged-primitives"),
            ]
        ),

        // MARK: - Umbrella
        .target(
            name: "Cardinal Primitives",
            dependencies: [
                "Cardinal Primitive",
                "Cardinal Error Primitives",
                "Cardinal Add Primitives",
                "Cardinal Subtract Primitives",
                "Cardinal Carrier Primitives",
                "Cardinal Equation Primitives",
                "Cardinal Hash Primitives",
                "Cardinal Comparison Primitives",
                "Cardinal Tagged Primitives",
                "Cardinal Primitives Standard Library Integration",
                .product(name: "Tagged Primitives", package: "swift-tagged-primitives"),
            ]
        ),

        // MARK: - Test Support
        .target(
            name: "Cardinal Primitives Test Support",
            dependencies: [
                "Cardinal Primitives",
                .product(name: "Tagged Primitives Test Support", package: "swift-tagged-primitives"),
            ],
            path: "Tests/Support"
        ),

        // MARK: - Tests
        .testTarget(
            name: "Cardinal Primitives Tests",
            dependencies: [
                "Cardinal Primitives",
                "Cardinal Primitives Test Support",
            ]
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
        .enableExperimentalFeature("LifetimeDependence"),
        .enableExperimentalFeature("Lifetimes"),
        .enableExperimentalFeature("SuppressedAssociatedTypes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
        .enableUpcomingFeature("LifetimeDependence"),
    ]

    // Platforms whose Swift SDK can compile the `Synchronization` module.
    // Android is excluded because the swift-android-sdk artifact bundle's
    // `SwiftOverlayShims/LibcOverlayShims.h` includes `<semaphore.h>`, which
    // Bionic libc does not ship as a standalone header (upstream gap in the
    // community Android Swift SDK). Embedded targets lack Synchronization
    // entirely. Source files that import Synchronization should guard with
    // `#if SYNCHRONIZATION_AVAILABLE`.
    let package: [SwiftSetting] = [
        .define(
            "SYNCHRONIZATION_AVAILABLE",
            .when(platforms: [.macOS, .iOS, .tvOS, .watchOS, .visionOS, .linux, .windows])
        )
    ]

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
