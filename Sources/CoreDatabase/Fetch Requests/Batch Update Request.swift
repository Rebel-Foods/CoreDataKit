//
//  Batch Update Request.swift
//  CoreDatabase
//
//  Created by Raghav Ahuja on 18/10/19.
//  Copyright © 2019 Raghav Ahuja. All rights reserved.
//

import CoreData

public final class BatchUpdateRequest<T: NSManagedObject> {
    
    internal let batchUpdateRequest: NSBatchUpdateRequest
    
    public init(in context: NSManagedObjectContext) {
        let table = T(context: context)
        batchUpdateRequest = NSBatchUpdateRequest(entity: table.entity)
    }
    
    @discardableResult
    public func propertiesToUpdate(_ propertiesToUpdate: [PartialKeyPath<T>: Any]?) -> BatchUpdateRequest {
        if let propertiesToUpdate = propertiesToUpdate {
            let updates = Dictionary(uniqueKeysWithValues: propertiesToUpdate.map { ($0._kvcKeyPathString!, $1) })
            batchUpdateRequest.propertiesToUpdate = updates
        } else {
            batchUpdateRequest.propertiesToUpdate = nil
        }
        return self
    }
    
    @discardableResult
    public func propertiesToUpdate(_ propertiesToUpdate: [AnyHashable : Any]?) -> BatchUpdateRequest {
        batchUpdateRequest.propertiesToUpdate = propertiesToUpdate
        return self
    }
    
    @discardableResult
    public func includesSubentities(_ includesSubentities: Bool) -> BatchUpdateRequest {
        batchUpdateRequest.includesSubentities = includesSubentities
        return self
    }
    
    @discardableResult
    public func `where`(_ format: String, args: CVarArg...) -> BatchUpdateRequest {
        let predicate = NSPredicate(format: format, args)
        batchUpdateRequest.predicate = predicate
        return self
    }
    
    @discardableResult
    public func `where`(_ value: Bool) -> BatchUpdateRequest {
        let predicate = NSPredicate(value: value)
        batchUpdateRequest.predicate = predicate
        return self
    }
    
    @discardableResult
    public func `where`(_ format: String, argumentArray: [Any]?) -> BatchUpdateRequest {
        let predicate = NSPredicate(format: format, argumentArray: argumentArray)
        batchUpdateRequest.predicate = predicate
        return self
    }
    
    @discardableResult
    public func `where`(_ predicate: NSPredicate?) -> BatchUpdateRequest {
        batchUpdateRequest.predicate = predicate
        return self
    }
    
    @discardableResult
    public func `where`(_ clause: Where<T>) -> BatchUpdateRequest {
        batchUpdateRequest.predicate = clause.predicate
        return self
    }
}
