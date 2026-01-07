// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CoursesUxMiamFramework",
    defaultLocalization: "fr",
    platforms: [
        .iOS(.v12),
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "CoursesUxMiamFramework",
            targets: ["CoursesUxMiamFramework"]),
    ],
    dependencies: [
        .package(url: "https://github.com/miamtech/MealziOSSDKRelease", exact: "5.10.8"),
        .package(url: "https://github.com/miamtech/MealzCoreRelease", exact: "5.10.8"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "CoursesUxMiamFramework",
            dependencies: [
                .product(name: "MealziOSSDK", package: "MealziOSSDKRelease"),
                .product(name: "MealzCore", package: "MealzCoreRelease"),
            ],
            resources: [.process("Resources")]),
    ])
