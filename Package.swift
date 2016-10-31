import PackageDescription

let package = Package(
    name: "PostgreSQL",
    dependencies: [
   		 .Package(url: "https://github.com/vapor/cpostgresql.git", majorVersion: 1),
   		 .Package(url: "https://github.com/vapor/node.git", majorVersion: 1),
    ]
)
