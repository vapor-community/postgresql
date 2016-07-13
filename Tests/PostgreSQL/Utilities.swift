import XCTest
import PostgreSQL

extension PostgreSQL.Database {
    static func makeTestConnection() -> PostgreSQL.Database {
        do {
            let postgreSQL = PostgreSQL.Database(
                host: "127.0.0.1",
                port: "5432",
                dbname: "test",
                user: "pugwuh",
                password: ""
                
            )
            try postgreSQL.execute("SELECT version()")
            return postgreSQL
        } catch {
            print()
            print()
            print("⚠️  PostgreSQL Not Configured ⚠️")
            print()
            print("Error: \(error)")
            print()
            print("You must configure PostgreSQL to run with the following configuration: ")
            print("    user: 'root'")
            print("    password: '' // (empty)")
            print("    host: '127.0.0.1'")
            print("    database: 'test'")
            print()

            print()

            XCTFail("Configure PostgreSQL")
            fatalError("Configure PostgreSQL")
        }
    }
}

// Makes fetching values during tests easier
extension PostgreSQL.Value {
    var string: String? {
        guard case .string(let string) = self else {
            return nil
        }

        return string
    }

    var int: Int? {
        guard case .int(let int) = self else {
            return nil
        }

        return int
    }

    var double: Double? {
        guard case .double(let double) = self else {
            return nil
        }

        return double
    }

    var bool: Bool? {
        guard case .bool(let bool) = self else {
            return nil
        }

        return Bool(bool)
    }
}
