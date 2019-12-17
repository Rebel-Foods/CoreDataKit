import XCTest
import CoreData
@testable import CoreDataKit

final class CoreDataKitTests: XCTestCase {
    func testExample() {
        class Test: NSManagedObject {
            @NSManaged var id: Int
            @NSManaged var subTest: SubTest?
        }
        
        class SubTest: NSManagedObject {
            @NSManaged var id: Int
        }
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
