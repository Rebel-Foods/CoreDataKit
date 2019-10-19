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
}
