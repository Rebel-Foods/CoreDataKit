//
//  Insert.swift
//  CoreDatabase
//
//  Created by Raghav Ahuja on 18/10/19.
//  Copyright © 2019 Raghav Ahuja. All rights reserved.
//

import CoreData

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
}
