#if os(Linux)

import XCTest
@testable import PostgreSQLTestSuite

XCTMain([
    testCase(PostgreSQLTests.allTests)
])

#endif
