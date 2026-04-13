// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "ETHStrategyIOS",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "ETHStrategyIOS",
            targets: ["ETHStrategyIOS"]
        )
    ],
    targets: [
        .target(
            name: "ETHStrategyIOS",
            path: "Sources/ETHStrategyIOS"
        )
    ]
)
