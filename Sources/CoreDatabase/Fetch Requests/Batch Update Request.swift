//
//  Batch Update Request.swift
//  CoreDatabase
//
//  Created by Raghav Ahuja on 18/10/19.
//  Copyright © 2019 Raghav Ahuja. All rights reserved.
//

import CoreData

public typealias BatchUpdates = [AnyHashable : Any]
public typealias KeyPathBatchUpdates<T: NSManagedObject> = [PartialKeyPath<T>: Any]

public final class BatchUpdateRequest<T: NSManagedObject> {
    
    internal let batchUpdateRequest: NSBatchUpdateRequest
    internal let context = CoreDataStack.shared.newBackgroundTask()
    
    public init() {
        let table = T(context: context)
        batchUpdateRequest = NSBatchUpdateRequest(entity: table.entity)
    }
    
    /// Dictionary of new updates to be performed.
    /// - Parameter propertiesToUpdate: `Optional<Dictionary<PartialKeyPath<NSManagedObject>, Any>>` of updates,
    /// where `key` is `NSManagedObject KeyPath` and `value` is KeyPath's new value.
    @discardableResult
    public func propertiesToUpdate(_ propertiesToUpdate: KeyPathBatchUpdates<T>?) -> BatchUpdateRequest {
        if let propertiesToUpdate = propertiesToUpdate {
            let updates = Dictionary(uniqueKeysWithValues: propertiesToUpdate.map { ($0._kvcKeyPathString!, $1) })
            batchUpdateRequest.propertiesToUpdate = updates
        } else {
            batchUpdateRequest.propertiesToUpdate = nil
        }
        return self
    }
    
    /// Dictionary of new updates to be performed.
    /// - Parameter propertiesToUpdate: `Optional<Dictionary<AnyHashable, Any>>` of updates,
    /// where `key` is `NSManagedObject KeyPath` String and `value` is KeyPath's new value.
    @discardableResult
    public func propertiesToUpdate(_ propertiesToUpdate: BatchUpdates?) -> BatchUpdateRequest {
        batchUpdateRequest.propertiesToUpdate = propertiesToUpdate
        return self
    }
    
    /// Should perform batch updates on sub entities.
    /// - Parameter includesSubentities: Include sub entities to perform batch update on them.
    @discardableResult
    public func includesSubentities(_ includesSubentities: Bool) -> BatchUpdateRequest {
        batchUpdateRequest.includesSubentities = includesSubentities
        return self
    }
    
    /// Initializes a predicate by substituting the values in a given array into a format string and parsing the result.
    /// - Parameter format: The format string for the new predicate.
    /// - Parameter args: The arguments to substitute into predicateFormat. Values are substituted in the order they appear in the array.
    @discardableResult
    public func `where`(_ format: String, args: CVarArg...) -> BatchUpdateRequest {
        let predicate = NSPredicate(format: format, args)
        batchUpdateRequest.predicate = predicate
        return self
    }
    
    /// Creates and returns a predicate that always evaluates to a given Boolean value.
    /// - Parameter value: The Boolean value to which the new predicate should evaluate.
    @discardableResult
    public func `where`(_ value: Bool) -> BatchUpdateRequest {
        let predicate = NSPredicate(value: value)
        batchUpdateRequest.predicate = predicate
        return self
    }
    
    /// Initializes a predicate by substituting the values in a given array into a format string and parsing the result.
    /// - Parameter format: The format string for the new predicate.
    /// - Parameter args: The arguments to substitute into predicateFormat. Values are substituted in the order they appear in the array.
    @discardableResult
    public func `where`(_ format: String, argumentArray: [Any]?) -> BatchUpdateRequest {
        let predicate = NSPredicate(format: format, argumentArray: argumentArray)
        batchUpdateRequest.predicate = predicate
        return self
    }
    
    /// The predicate of the fetch request.
    /// - Parameter predicate: The predicate instance constrains the selection of objects the `FetchRequest` instance is to fetch.
    @discardableResult
    public func `where`(_ predicate: NSPredicate?) -> BatchUpdateRequest {
        batchUpdateRequest.predicate = predicate
        return self
    }
    
    /// The predicate of the fetch request.
    /// - Parameter clause: `Where` clause to create a `FetchRequest` with.
    @discardableResult
    public func `where`(_ clause: Where<T>) -> BatchUpdateRequest {
        batchUpdateRequest.predicate = clause.predicate
        return self
    }
}
