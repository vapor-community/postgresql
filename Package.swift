import PackageDescription

let package = Package(
    name: "PostgreSQL",
    dependencies: [
        // Module map for `libpq`
        .Package(url: "https://github.com/vapor/cpostgresql.git", Version(2,0,0, prereleaseIdentifiers: ["alpha"])),

        // Data structure for converting between multiple representations
        .Package(url: "https://github.com/vapor/node.git", Version(2,0,0, prereleaseIdentifiers: ["beta"])),

        // Core extensions, type-aliases, and functions that facilitate common tasks
        .Package(url: "https://github.com/vapor/core.git", Version(2,0,0, prereleaseIdentifiers: ["beta"])),
    ]
)
