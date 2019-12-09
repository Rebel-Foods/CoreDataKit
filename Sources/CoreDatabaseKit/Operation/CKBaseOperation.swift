//
//  CKBaseOperation.swift
//  CoreDatabaseKit
//
//  Created by Raghav Ahuja on 18/10/19.
//  Copyright © 2019 Raghav Ahuja. All rights reserved.
//

import Foundation

public class /*abstract*/ CKBaseOperation {
    
    /// A Boolean value that indicates whether the operation has uncommitted changes.
    public var hasChanges: Bool { context.hasChanges }
    
    let context: CKContext
    let queue: DispatchQueue
    
    let logger: CKLogger
    
    var isCommitted: Bool
    
    var isRunningInAllowedQueue: Bool { queue.isCurrentExecutionContext() }
    
    /// The merge policy of the operation.
    /// A policy that you use to resolve conflicts between the persistent store and in-memory versions of managed objects.
    /// The default is `.errorMergePolicyType`.
    public var mergePolicy: CKMergePolicyType = .errorMergePolicyType {
        willSet {
            context.mergePolicy = CKMergePolicy(merge: newValue)
        }
    }
    
    private let runningCondition = " outside its designated queue."
    private lazy var committedCondition = " from an already committed \(String(reflecting: Self.self))."
    
    init(context moc: CKContext, queue q: DispatchQueue, logger l: CKLogger) {
        context = moc
        queue = q
        logger = l
        isCommitted = false
    }
}

// MARK: INSERT METHODS
public extension CKBaseOperation {
    
    func insert<Object: CKObject>(_ entityType: Object.Type) -> Object {
        precondition("Attempted to insert an entity of type '\(entityType)'")
        
        let object = Object(context: context)
        context.insert(object)
        return object
    }
}

// MARK: UPDATE METHODS
public extension CKBaseOperation {
    
    func update<Object: CKObject>(_ objects: [Object]) -> [Object] {
        precondition("Attempted to update an entities")
        
        return objects.compactMap { context.fetchExisting($0) }
    }
    
    func update<Object: CKObject>(_ object: Object?) -> Object? {
        precondition("Attempted to update an entity of type '\(String(reflecting: object))'")
        
        guard let object = object else { return nil }
        return context.fetchExisting(object)
    }
    
    func batchUpdate<Object: CKObject>(_ request: CKBatchUpdate<Object>, resultType: CKBatchUpdateResultType) throws -> Any? {
        precondition("Attempted to batch update an entity of type \(String(reflecting: Object.self))")
        let result = try context.batchUpdate(request, resultType: resultType)
        return result.result
    }
    
    func batchUpdate<Object: CKObject>(_ request: CKBatchUpdate<Object>) throws -> Bool {
        precondition("Attempted to batch update an entity of type \(String(reflecting: Object.self))")
        
        let result = try context.batchUpdate(request, resultType: .statusOnlyResultType)
        return result.result as? Bool ?? false
    }
    
    func batchUpdate<Object: CKObject>(_ request: CKBatchUpdate<Object>) throws -> [CKObjectId] {
        precondition("Attempted to batch update an entity of type \(String(reflecting: Object.self))")
        
        let result = try context.batchUpdate(request, resultType: .updatedObjectIDsResultType)
        return result.result as? [CKObjectId] ?? []
    }
    
    func batchUpdate<Object: CKObject>(_ request: CKBatchUpdate<Object>) throws -> Int {
        precondition("Attempted to batch update an entity of type \(String(reflecting: Object.self))")
        
        let result = try context.batchUpdate(request, resultType: .updatedObjectsCountResultType)
        return result.result as? Int ?? NSNotFound
    }
}

// MARK: DELETE METHODS
public extension CKBaseOperation {
    
    func delete<Object: CKObject>(_ object: Object?) {
        precondition("Attempted to delete from entity of type '\(String(reflecting: object))'")
        
        guard let object = object else { return }
        delete([object])
    }
    
    func delete<Object: CKObject>(_ objects: Object...) {
        precondition("Attempted to delete from entities")
        
        objects.compactMap { context.fetchExisting($0) }.forEach { context.delete($0) }
    }
    
    func delete<Object: CKObject>(_ objects: [Object]) {
        precondition("Attempted to delete from entities")
        
        objects.compactMap { context.fetchExisting($0) }.forEach { context.delete($0) }
    }
    
    func delete<Object>(_ request: CKFetch<Object>) throws {
        precondition("Attempted to delete from entity of type '\(String(reflecting: Object.self))'")
        
        try context.delete(request)
    }
    
    func batchDelete<Object>(_ request: CKFetch<Object>, resultType: CKBatchDeleteResultType) throws -> Any? {
        precondition("Attempted to delete from entity of type '\(String(reflecting: Object.self))'")
        
        let result = try context.batchDelete(request, resultType: resultType)
        return result.result
    }
    
    func batchDelete<Object>(_ request: CKFetch<Object>) throws -> Int {
        precondition("Attempted to delete from entity of type '\(String(reflecting: Object.self))'")
        
        let result = try context.batchDelete(request, resultType: .resultTypeCount)
        return result.result as? Int ?? NSNotFound
    }
    
    
    func batchDelete<Object>(_ request: CKFetch<Object>) throws -> [CKObjectId] {
        precondition("Attempted to delete from entity of type '\(String(reflecting: Object.self))'")
        
        let result = try context.batchDelete(request, resultType: .resultTypeObjectIDs)
        return result.result as? [CKObjectId] ?? []
    }
    
    
    func batchDelete<Object>(_ request: CKFetch<Object>) throws -> Bool {
        precondition("Attempted to delete from entity of type '\(String(reflecting: Object.self))'")
        
        let result = try context.batchDelete(request, resultType: .resultTypeStatusOnly)
        return result.result as? Bool ?? false
    }
}

// MARK: FETCH METHODS
extension CKBaseOperation: FetchClause {
    
    public func fetch<Object>(_ request: CKFetch<Object>) throws -> [Object] where Object : CKObject {
        precondition("Attempted to fetch from a \(String(reflecting: Object.self))")
        
        return try context.fetch(request)
    }
    
    public func fetchFirst<Object>(_ request: CKFetch<Object>) throws -> Object? where Object : CKObject {
        precondition("Attempted to fetch from a \(String(reflecting: Object.self))")
        
        return try context.fetchFirst(request)
    }
    
    public func fetchExisting<Object>(_ object: Object) -> Object? where Object : CKObject {
        context.fetchExisting(object)
    }
    
    public func fetchExisting<Object>(with objectId: CKObjectId) -> Object? where Object : CKObject {
        context.fetchExisting(with: objectId)
    }
    
    public func fetchExisting<Object, S>(_ objects: S) -> [Object] where Object : CKObject, Object == S.Element, S : Sequence {
        context.fetchExisting(objects)
    }
    
    public func fetchExisting<Object, S>(_ objectIds: S) -> [Object] where Object : CKObject, S : Sequence, S.Element == CKObjectId {
        context.fetchExisting(objectIds)
    }
    
    public func fetchIds<Object>(_ request: CKFetch<Object>) throws -> [CKObjectId] where Object : CKObject {
        precondition("Attempted to fetch from a \(String(reflecting: Object.self))")
        
        return try context.fetchIds(request)
    }
    
    public func query<Object>(_ request: CKFetch<Object>) throws -> [NSDictionary] where Object : CKObject {
        precondition("Attempted to fetch from a \(String(reflecting: Object.self))")
        
        return try context.query(request)
    }
    
    public func count<Object>(_ request: CKFetch<Object>) throws -> Int where Object : CKObject {
        precondition("Attempted to fetch from a \(String(reflecting: Object.self))")
        
        return try context.count(request)
    }
    
    public var unsafeContext: CKContext {
        context
    }
}

// MARK: LOGGING
private extension CKBaseOperation {
    
    func precondition(_ message: String, file: StaticString = #file, line: UInt = #line, function: StaticString = #function) {
        logger.assert(isRunningInAllowedQueue, message + runningCondition, file: file, line: line, function: function)
        
        logger.assert(!isCommitted, message + committedCondition, file: file, line: line, function: function)
    }
}
