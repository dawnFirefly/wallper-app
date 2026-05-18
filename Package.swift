// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "WallperApp",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .executable(name: "wallper-app", targets: ["WallperApp"])
    ],
    targets: [
        .executableTarget(
            name: "WallperApp",
            path: "open-source-code"
        )
    ]
)
