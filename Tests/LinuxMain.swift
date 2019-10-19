import XCTest

import CoreDatabaseTests

var tests = [XCTestCaseEntry]()
tests += CoreDatabaseTests.allTests()
XCTMain(tests)
