// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import Foundation

let configurationMode = ProcessInfo.processInfo.environment["CONFIGURATION_MODE"] ?? "prod"

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
    dependencies: {
        var dependencies: [Package.Dependency] = []

        if configurationMode == "dev" {
            dependencies.append(contentsOf: [
                .package(path: "../MealzCore"),
                .package(path: "../MealziOSSDK")
            ])
        } else {
            dependencies.append(contentsOf: [
                .package(url: "https://github.com/miamtech/MealziOSSDKRelease", exact: "6.0.2"),
                .package(url: "https://github.com/miamtech/MealzCoreRelease", exact: "6.0.2")
            ])
        }
        return dependencies
    }(),
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "CoursesUxMiamFramework",
            dependencies: {
                var dependencies: [Target.Dependency] = []
                if configurationMode == "dev" {
                    dependencies.append(contentsOf: [
                        .product(name: "MealzCore", package: "MealzCore"),
                        .product(name: "MealziOSSDK", package: "MealziOSSDK")
                    ])
                } else {
                    dependencies.append(contentsOf: [
                        .product(name: "MealziOSSDK", package: "MealziOSSDKRelease"),
                        .product(name: "MealzCore", package: "MealzCoreRelease")
                    ])
                }
                return dependencies
            }(),
            resources: [.process("Resources")]
        )
    ])
