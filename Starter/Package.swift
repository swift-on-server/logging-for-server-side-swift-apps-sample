// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "logging-for-server-side-swift-apps-sample",
    platforms: [
        .macOS(.v10_15),
    ],
    products: [
        .library(name: "MyLibrary", targets: ["MyLibrary"]),
        .executable(name: "MyApp", targets: ["MyApp"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-log", from: "1.5.0"),

    ],
    targets: [
        .target(
            name: "MyLibrary",
            dependencies: [
        
            ]
        ),
        .executableTarget(
            name: "MyApp",
            dependencies: [
                .target(name: "MyLibrary"),
                .product(name: "Logging", package: "swift-log"),

            ]
        ),
        .testTarget(
            name: "MyLibraryTests",
            dependencies: [
                .target(name: "MyLibrary"),
                
            ]
        ),
    ]
)
