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
    
    public static var coreDataModelName: String = ""
    
    @discardableResult
    public class func perform<T: NSManagedObject>(_ builder: () -> FetchRequest<T>) -> Perform<T> {
        let perform = Perform<T>(builder: builder)
        return perform
    }
    
    public class func performInsert<T: NSManagedObject>(_ insertions: (T) -> Void) throws {
        _ = try Insert<T>(insertions)
    }
    
    public class func performInsert<T: NSManagedObject>(_ insertions: (T, NSManagedObjectContext) -> Void) throws {
        _ = try Insert<T>(insertions)
    }
    
    @available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
    public class func performBatchInsertions<T: NSManagedObject>(_ insertions: BatchInserts, in: T.Type) throws {
        _ = try Insert<T>(insertions)
    }
    
    public class func performBatchUpdates<T: NSManagedObject>(_ builder: () -> BatchUpdateRequest<T>) throws {
        _ = try BatchUpdate<T>(builder)
    }
}
