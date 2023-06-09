// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "coursesU-iOS-templates",
    platforms: [
        .iOS(.v12),
      ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "coursesU-iOS-templates",
            targets: ["coursesU-iOS-templates"]),
    ],
    dependencies: [
            // The package dependency is defined as a local path.
//        .package(url: "https://github.com/miamtech/miam-sdk", from: "3.0.0"),
//        .package(url: "https://github.com/miamtech/miam-sdk", branch: "main"),
        .package(path: "../../miam-sdk"),
        ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "coursesU-iOS-templates",
            dependencies: [
                    .product(name: "MiamIOSFramework", package: "miam-sdk")
                  ],
            resources: [.process("Resources")]),
        .testTarget(
            name: "coursesU-iOS-templatesTests",
            dependencies: ["coursesU-iOS-templates"]),
    ]
)
