import PackageDescription

let package = Package(
    name: "PostgreSQL",
    dependencies: [
        .Package(url: "https://github.com/vapor-community/cpostgresql.git", majorVersion: 1),
        .Package(url: "https://github.com/vapor/node.git", majorVersion: 1),
        .Package(url: "https://github.com/vapor/core.git", majorVersion: 1),
    ]
)
