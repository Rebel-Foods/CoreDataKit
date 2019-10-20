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
    
    /// Intitalizes Fetch Request to perform actions.
    /// - Parameter builder: Block which returns the Fetch Request.
    init(builder: () -> FetchRequest<T>) {
        context = CoreDataStack.shared.newBackgroundTask()
        request = builder()
    }
    
    internal init() {
        context = CoreDataStack.shared.newBackgroundTask()
        request = FetchRequest<T>()
    }
    
    /// Attempts to fetch objects from a persistent store and saves the updates on a `private queue`.
    /// - Parameter completion: Block to update array of objects.
    public func update(_ completion: ([T]) -> Void) throws -> [T] {
        let objects: [T] = try _fetch(context: context)
        completion(objects)
        try context.save()
        return objects
    }
    
    /// Attempts to do delete data with given fetch request in a persistent store by loading data into memory and deleteing it.
    public func delete() throws {
        let fetchRequest = request.fetchRequest
        
        fetchRequest.resultType = .managedObjectResultType
        let objects = try context.fetch(fetchRequest) as! [T]
        objects.forEach { (object) in
            context.delete(object)
        }
        try context.save()
    }
    
    /// Attempts to do a batch delete of data with given fetch request in a persistent store without loading any data into memory.
    public func batchDelete() throws {
        let fetchRequest = request.fetchRequest
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        try context.execute(batchDeleteRequest)
    }
    
    private func delete(_ object: T, inContext objectContext: NSManagedObjectContext? = nil) throws {
        let context = objectContext ?? object.managedObjectContext
        context?.delete(object)
        try context?.save()
    }
    
    /// Attempts to fetch objects from a persistent store with given fetch request on `main queue`.
    /// - Returns: Array of objects.
    public func fetch() throws -> [T] {
        let context = CoreDataStack.shared.viewContext
        return try _fetch(context: context)
    }
    
    /// Attempts to fetch objects from a persistent store with given fetch request on `main queue`.
    /// - Returns: Array of `Dictionary<String, Any>`.
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
