//
//  CoreDatabase.swift
//  CoreDatabase
//
//  Created by Raghav Ahuja on 18/10/19.
//  Copyright © 2019 Raghav Ahuja. All rights reserved.
//

import CoreData

public final class CoreDatabase {
    
    private init() {}
    
    public static var coreDataModelName: String = "nil"
    
    /// Perform Action on Database.
    /// - Parameter builder: Block to build Fetch Request.
    @discardableResult
    public class func perform<T: NSManagedObject>(_ builder: () -> FetchRequest<T>) -> Perform<T> {
        let perform = Perform<T>(builder: builder)
        return perform
    }
    
    /// Saves the new NSManaged Object in persistent store on a `private queue`.
    /// - Parameter insertions: Block with new `NSManagedObject`.
    public class func performInsert<T: NSManagedObject>(_ insertions: (T) -> Void) throws {
        _ = try Insert<T>(insertions)
    }
    
    /// Saves the new NSManaged Object in persistent store on a `private queue`.
    /// - Parameter insertions: Block with new `NSManagedObject` and its `NSManagedObjectContext`.
    public class func performInsert<T: NSManagedObject>(_ insertions: (T, NSManagedObjectContext) -> Void) throws {
        _ = try Insert<T>(insertions)
    }
    
    /// Saves batch inserts in persistent store on a `private queue`.
    /// - Parameter insertions: Array of `Dictionary<String, Any>` with insertions to be saved.
    @available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
    public class func performBatchInsertions<T: NSManagedObject>(_ insertions: BatchInserts, in: T.Type) throws {
        _ = try Insert<T>(insertions)
    }
    
    /// Executes a batch update request on a `private queue`.
    /// - Parameter builder: Block that returns Batch Update Request.
    public class func performBatchUpdates<T: NSManagedObject>(_ builder: () -> BatchUpdateRequest<T>) throws {
        _ = try BatchUpdate<T>(builder)
    }
}
