//
//  Insert.swift
//  CoreDatabase
//
//  Created by Raghav Ahuja on 18/10/19.
//  Copyright © 2019 Raghav Ahuja. All rights reserved.
//

import CoreData

public typealias BatchInserts = [[String : Any]]

internal class Insert<T: NSManagedObject> {
    
    private let entity: T
    private let context = CoreDataStack.shared.newBackgroundTask()
    
    internal init(_ insertions: (T) -> Void) throws {
        entity = T(context: context)
        insertions(entity)
        try context.save()
    }

    internal init(_ insertions: (T, NSManagedObjectContext) -> Void) throws {
        entity = T(context: context)
        insertions(entity, context)
        try context.save()
    }
    
    @available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
    internal init(_ insertions: BatchInserts) throws {
        entity = T(context: context)
        let batchInsert = NSBatchInsertRequest(entity: entity.entity, objects: insertions)
        
        try context.execute(batchInsert)
        try context.save()
    }

}
