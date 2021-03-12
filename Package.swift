// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "pixelmatch",
  platforms: [
    .macOS(.v10_15),
  ],
  products: [
    .executable(
      name: "pixelmatch",
      targets: ["pixelmatch"]
    ),
  ],
  dependencies: [
    // Dependencies declare other packages that this package depends on.
    // .package(url: /* package url */, from: "1.0.0"),
    .package(url: "https://github.com/apple/swift-argument-parser", from: "0.4.1"),
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages this package depends on.
    .target(
      name: "pixelmatch",
      dependencies: [
        .product(name: "ArgumentParser", package: "swift-argument-parser"),
      ],
      resources: [
        .copy("pixelmatch"),
      ]
    ),
    .testTarget(
      name: "pixelmatchTests",
      dependencies: ["pixelmatch"]
    ),
  ]
)
