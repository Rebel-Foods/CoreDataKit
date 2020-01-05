//
//  CKBatchUpdate.swift
//  CoreDataKit
//
//  Created by Raghav Ahuja on 18/10/19.
//  Copyright © 2019 Raghav Ahuja. All rights reserved.
//

import Foundation

public final class CKBatchUpdate<Object: CKObject> {
    
    var propertiesToUpdate: CKBatchUpdates? = nil
    var includesSubentities: Bool = false
    var resultType: CKBatchUpdateResultType = .statusOnlyResultType
    var predicate: CKPredicate?
    
    public init() { }
    
    func batchUpdateRequest(in context: CKContext) -> CKBatchUpdateRequest {
        let object = Object(context: context)
        
        let batchUpdateRequest = CKBatchUpdateRequest(entity: object.entity)
        batchUpdateRequest.predicate = predicate
        batchUpdateRequest.includesSubentities = includesSubentities
        batchUpdateRequest.resultType = resultType
        batchUpdateRequest.propertiesToUpdate = propertiesToUpdate
        
        return batchUpdateRequest
    }
}

extension CKBatchUpdate {
    
    /// Dictionary of new updates to be performed.
    /// - Parameter propertiesToUpdate: `Optional<Dictionary<PartialKeyPath<NSManagedObject>, Any>>` of updates,
    /// where `key` is `NSManagedObject KeyPath` and `value` is KeyPath's new value.
    public func propertiesToUpdate(_ propertiesToUpdate: CKKeyPathBatchUpdates<Object>?) -> Self {
        if let propertiesToUpdate = propertiesToUpdate {
            let updates = Dictionary(uniqueKeysWithValues: propertiesToUpdate.map { ($0.objcStringValue, $1) })
            self.propertiesToUpdate = updates
        } else {
            self.propertiesToUpdate = nil
        }
        return self
    }
    
    /// Dictionary of new updates to be performed.
    /// - Parameter propertiesToUpdate: `Optional<Dictionary<AnyHashable, Any>>` of updates,
    /// where `key` is `NSManagedObject KeyPath` String and `value` is KeyPath's new value.
    public func propertiesToUpdate(_ propertiesToUpdate: CKBatchUpdates?) -> Self {
        self.propertiesToUpdate = propertiesToUpdate
        return self
    }
    
    /// Should perform batch updates on sub entities.
    /// - Parameter includesSubentities: Include sub entities to perform batch update on them.
    public func includesSubentities(_ includesSubentities: Bool) -> Self {
        self.includesSubentities = includesSubentities
        return self
    }
    
    /// Returns/sets the result type of the fetch request (the instance type of objects returned from executing the request.) Setting the value to `updatedObjectIDsResultType` will demote any sort orderings to "best effort" hints if property values are not included in the request.  Defaults to `statusOnlyResultType`.
    /// - Parameter type: Result type of the fetch request.
    func resultType(_ type: CKBatchUpdateResultType) -> Self {
        resultType = type
        return self
    }
}

extension CKBatchUpdate: WhereClause {
    
    /// Initializes a predicate by substituting the values in a given array into a format string and parsing the result.
    /// - Parameter format: The format string for the new predicate.
    /// - Parameter args: The arguments to substitute into predicateFormat. Values are substituted in the order they appear in the array.
    public func `where`(_ format: String, args: CVarArg...) -> Self {
        let p = CKPredicate(format: format, args)
        predicate = p
        return self
    }
    
    /// Creates and returns a predicate that always evaluates to a given Boolean value.
    /// - Parameter value: The Boolean value to which the new predicate should evaluate.
    public func `where`(_ value: Bool) -> Self {
        let p = CKPredicate(value: value)
        predicate = p
        return self
    }
    
    /// Initializes a predicate by substituting the values in a given array into a format string and parsing the result.
    /// - Parameter format: The format string for the new predicate.
    /// - Parameter args: The arguments to substitute into predicateFormat. Values are substituted in the order they appear in the array.
    public func `where`(_ format: String, argumentArray: [Any]?) -> Self {
        let p = CKPredicate(format: format, argumentArray: argumentArray)
        predicate = p
        return self
    }
    
    /// The predicate of the fetch request.
    /// - Parameter predicate: The predicate instance constrains the selection of objects the `FetchRequest` instance is to fetch.
    public func `where`(_ predicate: CKPredicate?) -> Self {
        self.predicate = predicate
        return self
    }
    
    /// The predicate of the fetch request.
    /// - Parameter clause: `Where` clause to create a `FetchRequest` with.
    public func `where`(_ clause: Where<Object>) -> Self {
        predicate = clause.predicate
        return self
    }
}
