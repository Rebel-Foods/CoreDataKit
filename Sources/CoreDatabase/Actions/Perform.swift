//
//  Perform.swift
//  CoreDatabase
//
//  Created by Raghav Ahuja on 18/10/19.
//  Copyright © 2019 Raghav Ahuja. All rights reserved.
//

import CoreData

public final class Perform<T: NSManagedObject> {
    public typealias DictionaryResult = [[String : Any]]
    
    private let request: FetchRequest<T>
    private let context: NSManagedObjectContext
    
    init(builder: () -> FetchRequest<T>) {
        context = CoreDataStack.shared.newBackgroundTask()
        request = builder()
    }
    
    internal init() {
        context = CoreDataStack.shared.newBackgroundTask()
        request = FetchRequest<T>()
    }
    
    public func update(_ completion: ([T]) -> Void) throws -> [T] {
        let objects: [T] = try _fetch(context: context)
        completion(objects)
        try context.save()
        return objects
    }
    
    public func delete() throws {
        let fetchRequest = request.fetchRequest
        
        fetchRequest.resultType = .managedObjectResultType
        let objects = try context.fetch(fetchRequest) as! [T]
        objects.forEach { (object) in
            context.delete(object)
        }
        try context.save()
    }
    
    private func delete(_ object: T, inContext objectContext: NSManagedObjectContext? = nil) throws {
        let context = objectContext ?? object.managedObjectContext
        context?.delete(object)
        try context?.save()
    }
    
    public func fetch() throws -> [T] {
        let context = CoreDataStack.shared.viewContext
        return try _fetch(context: context)
    }
    
    public func fetchDictionary() throws -> DictionaryResult {
        let context = CoreDataStack.shared.viewContext
        return try _fetch(context: context)
    }
    
    private func _fetch<T>(context: NSManagedObjectContext) throws -> T {
        let fetchRequest = request.fetchRequest
        let objects = try context.fetch(fetchRequest) as! T
        return objects
    }
}
