// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MobileQuickLaunchKit",
    defaultLocalization: "en",
    platforms: [.iOS(.v14)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "MobileQuickLaunchKit",
            targets: ["MobileQuickLaunchKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "9.0.0"),
        .package(url: "https://github.com/google/GoogleSignIn-iOS.git", from: "7.0.0"),
        // Add other dependencies as needed
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "MobileQuickLaunchKit",
            dependencies: [
                .product(name: "FirebaseAnalytics", package: "firebase-ios-sdk"),
                .product(name: "GoogleSignIn", package: "GoogleSignIn-iOS"),
                .product(name: "GoogleSignInSwift", package: "GoogleSignIn-iOS")
                // Add other dependencies as needed
            ],
            resources: [.process("Assets/MobileQuickLaunchKitAssets.xcassets")]
        ),
        .testTarget(
            name: "MobileQuickLaunchKitTests",
            dependencies: ["MobileQuickLaunchKit"]),
    ]
)
