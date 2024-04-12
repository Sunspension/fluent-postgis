// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "fluent-postgis",
    platforms: [
        .macOS(.v12),
    ],
    products: [
        .library(
            name: "FluentPostGIS",
            targets: ["FluentPostGIS"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/fluent-kit.git", from: "1.45.1"),
        .package(url: "https://github.com/vapor/fluent-postgres-driver.git", from: "2.8.0"),
        .package(url: "https://github.com/rabc/WKCodable.git", from: "0.1.0"),
    ],
    targets: [
        .target(
            name: "FluentPostGIS",
            dependencies: [
                .product(name: "FluentKit", package: "fluent-kit"),
                .product(name: "FluentPostgresDriver", package: "fluent-postgres-driver"),
                .product(name: "WKCodable", package: "WKCodable"),
            ]
        ),
        .testTarget(
            name: "FluentPostGISTests",
            dependencies: [
                .target(name: "FluentPostGIS"),
                .product(name: "FluentBenchmark", package: "fluent-kit"),
            ]
        ),
    ]
)
