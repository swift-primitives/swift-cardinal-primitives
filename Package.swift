// swift-tools-version: 6.3.1
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
        .library(
            name: "Cardinal Primitives",
            targets: ["Cardinal Primitives"]
        ),
        .library(
            name: "Cardinal Primitives Core",
            targets: ["Cardinal Primitives Core"]
        ),
        .library(
            name: "Cardinal Primitives Standard Library Integration",
            targets: ["Cardinal Primitives Standard Library Integration"]
        ),
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

        // MARK: - Core
        .target(
            name: "Cardinal Primitives Core",
            dependencies: [
                .product(name: "Tagged Primitives", package: "swift-tagged-primitives"),
                .product(name: "Carrier Primitives", package: "swift-carrier-primitives"),
                .product(name: "Property Primitives", package: "swift-property-primitives"),
                .product(name: "Equation Primitives", package: "swift-equation-primitives"),
                .product(name: "Hash Primitives", package: "swift-hash-primitives"),
                .product(name: "Comparison Primitives", package: "swift-comparison-primitives"),
            ]
        ),

        // MARK: - Umbrella
        .target(
            name: "Cardinal Primitives",
            dependencies: [
                "Cardinal Primitives Core",
                "Cardinal Primitives Standard Library Integration",
            ]
        ),

        // MARK: - StdLib Integration
        .target(
            name: "Cardinal Primitives Standard Library Integration",
            dependencies: [
                "Cardinal Primitives Core",
                .product(name: "Carrier Primitives", package: "swift-carrier-primitives"),
                .product(name: "Tagged Primitives Standard Library Integration", package: "swift-tagged-primitives"),
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
