import XCTest
@testable import PostgreSQL

class MiscTests: XCTestCase {
    static let allTests = [
        ("testContext", testContext)
    ]

    func testContext() throws {
        let context = PostgreSQLContext.shared.isPostgreSQL
        XCTAssert(context == true)
    }
}
