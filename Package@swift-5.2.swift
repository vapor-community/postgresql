// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "PostgreSQL",
    products: [
        .library(name: "PostgreSQL", targets: ["PostgreSQL"]),
    ],
    dependencies: [
        // Module map for `libpq`
        .package(name: "CPostgreSQL", url: "https://github.com/vapor-community/cpostgresql.git", from: "2.1.0"),
        
        // Data structure for converting between multiple representations
        .package(name: "Node", url: "https://github.com/vapor/node.git", from: "2.1.0"),

        // Core extensions, type-aliases, and functions that facilitate common tasks
        .package(name: "Core", url: "https://github.com/vapor/core.git", from: "2.1.2"),
    ],
    targets: [
        .target(name: "PostgreSQL", dependencies: ["CPostgreSQL", "Node", "Core"]),
        .testTarget(name: "PostgreSQLTests", dependencies: ["PostgreSQL"]),
    ]
)
