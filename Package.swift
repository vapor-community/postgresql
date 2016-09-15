import PackageDescription

let package = Package(
    name: "PostgreSQL",
    dependencies: [
   		 .Package(url: "https://github.com/vapor/cpostgresql.git", majorVersion: 0, minor: 1),
   		 .Package(url: "https://github.com/vapor/node.git", majorVersion: 0, minor: 6)
    ]
)
