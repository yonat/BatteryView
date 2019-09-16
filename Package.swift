// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "BatteryView",
    platforms: [
        .iOS(.v9)
    ],
    products: [
        .library( name: "BatteryView", targets: ["BatteryView"])
    ],
    dependencies: [
        .package(url: "https://github.com/yonat/SweeterSwift", from: "1.0.4"),
    ],
    targets: [
        .target(name: "BatteryView", dependencies: ["SweeterSwift"], path: "Sources")
    ],
    swiftLanguageVersions: [.v5]
)
