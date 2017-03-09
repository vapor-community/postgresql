import XCTest
import PostgreSQL

class ConnectionTests: XCTestCase {
    
    func testConnInfoParams() {
        do {
            let postgreSQL = try PostgreSQL.Database(params: ["host": "127.0.0.1",
                                                              "port": "5432",
                                                              "dbname": "test",
                                                              "user": "postgres",
                                                              "password": ""])
            try postgreSQL.execute("SELECT version()")
        } catch {
            XCTFail("Could not connect to database")
        }
    }
}
