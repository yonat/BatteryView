// swift-tools-version:5.6

import PackageDescription

let package = Package(
    name: "BatteryView",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library( name: "BatteryView", targets: ["BatteryView"])
    ],
    dependencies: [],
    targets: [
        .target(name: "BatteryView", dependencies: [], path: "Sources", resources: [.copy("PrivacyInfo.xcprivacy")])
    ],
    swiftLanguageVersions: [.v5]
)
