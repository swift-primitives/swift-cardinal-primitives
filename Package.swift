// swift-tools-version: 6.3
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
        .package(path: "../swift-identity-primitives"),
        .package(path: "../swift-property-primitives"),
        .package(path: "../swift-equation-primitives"),
        .package(path: "../swift-comparison-primitives"),
    ],
    targets: [

        // MARK: - Core
        .target(
            name: "Cardinal Primitives Core",
            dependencies: [
                .product(name: "Identity Primitives", package: "swift-identity-primitives"),
                .product(name: "Property Primitives", package: "swift-property-primitives"),
                .product(name: "Equation Primitives", package: "swift-equation-primitives"),
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
            ]
        ),

        // MARK: - Test Support
        .target(
            name: "Cardinal Primitives Test Support",
            dependencies: [
                "Cardinal Primitives",
                .product(name: "Identity Primitives Test Support", package: "swift-identity-primitives"),
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

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
