import XCTest
import CoreData
@testable import CoreDataKit

class Test: NSManagedObject {
    @NSManaged var id: Int
    @NSManaged var subTest: SubTest?
}

class SubTest: NSManagedObject {
    @NSManaged var id: Int
}

final class CoreDataKitTests: XCTestCase {
    
    @CKFetchRequest<Test>(sortDescriptors: []) var x: CKFetchedResults<Test>
    
    func testExample() {
        CoreDataCloudKit.default.replaceStoreDescriptions(with: CKStoreDescription())
        CoreDataCloudKit.default.loadPersistentStores()
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
