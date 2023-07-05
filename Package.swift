// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CoursesUxMiamFramework",
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
//        .package(url: "https://github.com/miamtech/miam-sdk", branch: "main"),
        .package(path: "../../miam-sdk"),
        ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "CoursesUxMiamFramework",
            dependencies: [
                    .product(name: "MiamIOSFramework", package: "miam-sdk")
                  ],
            resources: [.process("Resources")]),
//            resources: [
//                        .process("Sources/CoursesUIOSTemplate/Resources/Images"),
//                        .process("Sources/CoursesUIOSTemplate/Resources/Icons")
//                    ]),
        .testTarget(
            name: "coursesU-iOS-templatesTests",
            dependencies: ["CoursesUxMiamFramework"]),
    ]
)
