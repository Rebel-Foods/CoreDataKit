//
//  CKBaseOperation.swift
//  CoreDataKit
//
//  Created by Raghav Ahuja on 18/10/19.
//  Copyright © 2019 Raghav Ahuja. All rights reserved.
//

import CoreData

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
    
    /// Initalizes a task to perform Core Data operations.
    /// - Parameters:
    ///   - context: `CKContext` to perform operations with.
    ///   - queue: `DispatchQueue` on which this task will work.
    ///   - logger: `CKLogger` to check conditions and log errors and success.
    init(context moc: CKContext, queue q: DispatchQueue, logger l: CKLogger) {
        context = moc
        queue = q
        logger = l
        isCommitted = false
    }
}

// MARK: INSERT METHODS
public extension CKBaseOperation {
    
    /// Insert an object for an entity in `CKContext`.
    /// - Parameter entityType: A `CKObject` type to insert.
    /// - Returns: An object of `CKObject` type.
    func insert<Object: CKObject>(_ entityType: Object.Type) -> Object {
        precondition("Attempted to insert an entity of type '\(entityType)'")
        
        let object = Object(context: context)
        context.insert(object)
        return object
    }
    
    /// Batch insert of data in a persistent store without loading any data or object into memory.
    /// - Parameter object: `CKBatchInsert` object containing the batch data to be inserted.
    @available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
    func batchInsert<Object: CKObject>(into object: CKBatchInsert<Object>) throws {
        let _: Bool? = try batchInsert(into: object)
    }
    
    /// Batch insert of data in a persistent store without loading any data or object into memory.
    /// - Parameter object: `CKBatchInsert` object containing the batch data to be inserted.
    /// - Returns: Returns a `CKResult`. `CKResult` can be either `Bool`, `[CKObjectId]` or `Int`.
    @available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
    func batchInsert<Object: CKObject, ResultType: CKResult>(into object: CKBatchInsert<Object>) throws -> ResultType? {
        precondition("Attempted to batch insert an entity of type '\(String(reflecting: Object.self))'")
        
        let result = try context.batchInsert(object, resultType: ResultType.ckResultType.batchInsert)
        return result.result as? ResultType
    }

//    @available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
//    func batchInsert<Object: CKObject>(into object: CKBatchInsert<Object>) throws -> Bool {
//        precondition("Attempted to batch insert an entity of type '\(String(reflecting: Object.self))'")
//        
//        let result = try context.batchInsert(object, resultType: .statusOnly)
//        return result.result as? Bool ?? false
//    }
//
//    @available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
//    func batchInsert<Object: CKObject>(into object: CKBatchInsert<Object>) throws -> [CKObjectId] {
//        precondition("Attempted to batch insert an entity of type '\(String(reflecting: Object.self))'")
//        
//        let result = try context.batchInsert(object, resultType: .objectIDs)
//        return result.result as? [CKObjectId] ?? []
//    }
//
//    @available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
//    func batchInsert<Object: CKObject>(into object: CKBatchInsert<Object>) throws -> Int {
//        precondition("Attempted to batch insert an entity of type '\(String(reflecting: Object.self))'")
//        
//        let result = try context.batchInsert(object, resultType: .count)
//        return result.result as? Int ?? 0
//    }
}

// MARK: UPDATE METHODS
public extension CKBaseOperation {
    
    /// Returns an editable copy of a specified `CKObject` type array.
    /// - Parameter objects: An array of `CKObject`type  to be updated.
    /// - Returns: Returns an editable copy of a specified `CKObject`type array.
    func update<Object: CKObject>(_ objects: [Object]) -> [Object] {
        precondition("Attempted to update an entities")
        
        return objects.compactMap { context.fetchExisting($0) }
    }
    
    /// Returns an editable copy of a specified `CKObject` type.
    /// - Parameter object: A `CKObject` type to be updated.
    /// - Returns: Returns an editable copy of a specified `CKObject` type.
    func update<Object: CKObject>(_ object: Object?) -> Object? {
        precondition("Attempted to update an entity of type '\(String(reflecting: object))'")
        
        guard let object = object else { return nil }
        return context.fetchExisting(object)
    }
    
    /// Batch update of data in a persistent store without loading any data into memory.
    /// - Parameter object: A `CKBatchUpdate` containing the configuarion.
    func batchUpdate<Object: CKObject>(into object: CKBatchUpdate<Object>) throws {
        let _: Bool? = try batchUpdate(into: object)
    }
    
    /// Batch update of data in a persistent store without loading any data into memory.
    /// - Parameter object: A `CKBatchUpdate` containing the configuarion.
    /// - Returns: Returns a `CKResult`. `CKResult` can be either `Bool`, `[CKObjectId]` or `Int`. 
    func batchUpdate<Object: CKObject, Result: CKResult>(into object: CKBatchUpdate<Object>) throws -> Result? {
        precondition("Attempted to batch update an entity of type \(String(reflecting: Object.self))")
        
        let result = try context.batchUpdate(object, resultType: Result.ckResultType.batchUpdate)
        return result.result as? Result
    }
    
//    func batchUpdate<Object: CKObject>(_ request: CKBatchUpdate<Object>) throws -> Bool {
//        precondition("Attempted to batch update an entity of type \(String(reflecting: Object.self))")
//
//        let result = try context.batchUpdate(request, resultType: .statusOnlyResultType)
//        return result.result as? Bool ?? false
//    }
//
//    func batchUpdate<Object: CKObject>(_ request: CKBatchUpdate<Object>) throws -> [CKObjectId] {
//        precondition("Attempted to batch update an entity of type \(String(reflecting: Object.self))")
//
//        let result = try context.batchUpdate(request, resultType: .updatedObjectIDsResultType)
//        return result.result as? [CKObjectId] ?? []
//    }
//
//    func batchUpdate<Object: CKObject>(_ request: CKBatchUpdate<Object>) throws -> Int {
//        precondition("Attempted to batch update an entity of type \(String(reflecting: Object.self))")
//
//        let result = try context.batchUpdate(request, resultType: .updatedObjectsCountResultType)
//        return result.result as? Int ?? NSNotFound
//    }
}

// MARK: DELETE METHODS
public extension CKBaseOperation {
    
    /// <#Description#>
    /// - Parameter object: <#object description#>
    func delete<Object: CKObject>(_ object: Object?) {
        precondition("Attempted to delete from entity of type '\(String(reflecting: object))'")
        
        guard let object = object else { return }
        delete([object])
    }
    
    /// <#Description#>
    /// - Parameter objects: <#objects description#>
    func delete<Object: CKObject>(_ objects: Object...) {
        precondition("Attempted to delete from entities")
        
        objects.compactMap { context.fetchExisting($0) }.forEach { context.delete($0) }
    }
    
    /// Deletes the array objects with the specified `CKObjectID`s
    /// - Parameter objects: <#objects description#>
    func delete<Object: CKObject>(_ objects: [Object]) {
        precondition("Attempted to delete from entities")
        
        objects.compactMap { context.fetchExisting($0) }.forEach { context.delete($0) }
    }
    
    /// <#Description#>
    /// - Parameter request: <#request description#>
    func delete<Object>(_ request: CKFetch<Object>) throws {
        precondition("Attempted to delete from entity of type '\(String(reflecting: Object.self))'")
        
        try context.delete(request)
    }
    
    
    /// <#Description#>
    /// - Parameters:
    ///   - request: <#request description#>
    ///   - resultType: <#resultType description#>
    func batchDelete<Object>(_ request: CKFetch<Object>) throws {
        precondition("Attempted to delete from entity of type '\(String(reflecting: Object.self))'")
        
        _ = try context.batchDelete(request, resultType: .resultTypeStatusOnly)
    }
    
    /// <#Description#>
    /// - Parameters:
    ///   - request: <#request description#>
    ///   - resultType: <#resultType description#>
    func batchDelete<Object, Result: CKResult>(_ request: CKFetch<Object>) throws -> Result? {
        precondition("Attempted to delete from entity of type '\(String(reflecting: Object.self))'")
        
        let result = try context.batchDelete(request, resultType: Result.ckResultType.batchDelete)
        return result.result as? Result
    }
    
//    /// <#Description#>
//    /// - Parameter request: <#request description#>
//    func batchDelete<Object>(_ request: CKFetch<Object>) throws -> Int {
//        precondition("Attempted to delete from entity of type '\(String(reflecting: Object.self))'")
//
//        let result = try context.batchDelete(request, resultType: .resultTypeCount)
//        return result.result as? Int ?? NSNotFound
//    }
//
//    /// <#Description#>
//    /// - Parameter request: <#request description#>
//    func batchDelete<Object>(_ request: CKFetch<Object>) throws -> [CKObjectId] {
//        precondition("Attempted to delete from entity of type '\(String(reflecting: Object.self))'")
//
//        let result = try context.batchDelete(request, resultType: .resultTypeObjectIDs)
//        return result.result as? [CKObjectId] ?? []
//    }
//
//    /// <#Description#>
//    /// - Parameter request: <#request description#>
//    func batchDelete<Object>(_ request: CKFetch<Object>) throws -> Bool {
//        precondition("Attempted to delete from entity of type '\(String(reflecting: Object.self))'")
//
//        let result = try context.batchDelete(request, resultType: .resultTypeStatusOnly)
//        return result.result as? Bool ?? false
//    }
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
