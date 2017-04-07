import XCTest
import PostgreSQL

class ConnectionTests: XCTestCase {
    static let allTests = [
        ("testConnection", testConnection),
        ("testConnInfoParams", testConnInfoParams),
        ("testConnectionFailure", testConnectionFailure)
    ]

    var postgreSQL: PostgreSQL.Database!

    func testConnection() throws {
        postgreSQL = PostgreSQL.Database.makeTestConnection()

        let connection = try postgreSQL.makeConnection()
        XCTAssertTrue(connection.isConnected)

        try connection.reset()
        try connection.close()
        XCTAssertFalse(connection.isConnected)
    }

    func testConnInfoParams() {
        do {
            let postgreSQL = try PostgreSQL.Database(
                params: ["host": "127.0.0.1",
                         "port": "5432",
                         "dbname": "test",
                         "user": "postgres",
                         "password": ""])
            try postgreSQL.execute("SELECT version()")
        } catch {
            XCTFail("Could not connect to database")
        }
    }

    func testConnectionFailure() throws {
        let database = try PostgreSQL.Database(
            hostname: "127.0.0.1",
            port: 5432,
            database: "some_long_db_name_that_does_not_exist",
            user: "postgres",
            password: ""
        )

        try XCTAssertThrowsError(database.makeConnection()) { error in
            switch error {
            case DatabaseError.cannotEstablishConnection(_):
                break
            default:
                XCTFail("Invalid error")
            }
        }
    }

    func testConnectionSuccess() throws {
        do {
            let database = try PostgreSQL.Database(
                hostname: "127.0.0.1",
                port: 5432,
                database: "test",
                user: "postgres",
                password: ""
            )
            try database.execute("SELECT version()")
        } catch {
            XCTFail("Could not connect to database")
        }
    }
}
