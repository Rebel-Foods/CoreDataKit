//
//  Fetch Request.swift
//  CoreDatabase
//
//  Created by Raghav Ahuja on 18/10/19.
//  Copyright © 2019 Raghav Ahuja. All rights reserved.
//

import CoreData

public typealias RequestType = NSFetchRequest<NSFetchRequestResult>

public final class FetchRequest<T: NSManagedObject> {
    
    internal let fetchRequest: RequestType
    
    public init() {
        fetchRequest = T.self.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
    }
    
    // MARK: FETCH BATCH SIZE CLAUSE
    
    @discardableResult
    public func batchSize(_ fetchBatchSize: Int) -> FetchRequest {
        fetchRequest.fetchBatchSize = fetchBatchSize
        return self
    }
    
    // MARK: FETCH LIMIT CLAUSE
    
    @discardableResult
    public func limit(_ fetchLimit: Int) -> FetchRequest {
        fetchRequest.fetchLimit = fetchLimit
        return self
    }
    
    // MARK: CUSTOMISE CLAUSE
    
    @discardableResult
    public func customise(_ completion: (RequestType) -> Void) -> FetchRequest {
        completion(fetchRequest)
        return self
    }
    
    // MARK: ORDER BY CLAUSE
    
    @discardableResult
    public func orderBy<Value>(_ sortKeys: OrderBy<T, Value>...) -> FetchRequest {
        fetchRequest.sortDescriptors = sortKeys.map { $0.descriptor }
        return self
    }
    
    @discardableResult
    public func orderBy(sortDescriptors: NSSortDescriptor...) -> FetchRequest {
        fetchRequest.sortDescriptors = sortDescriptors.map { $0 }
        return self
    }
    
    // MARK: WHERE CLAUSE
    
    @discardableResult
    public func `where`(_ format: String, args: CVarArg...) -> FetchRequest {
        let predicate = NSPredicate(format: format, args)
        fetchRequest.predicate = predicate
        return self
    }
    
    @discardableResult
    public func `where`(_ value: Bool) -> FetchRequest {
        let predicate = NSPredicate(value: value)
        fetchRequest.predicate = predicate
        return self
    }
    
    @discardableResult
    public func `where`(_ format: String, argumentArray: [Any]?) -> FetchRequest {
        let predicate = NSPredicate(format: format, argumentArray: argumentArray)
        fetchRequest.predicate = predicate
        return self
    }
    
    @discardableResult
    public func `where`(_ predicate: NSPredicate) -> FetchRequest {
        fetchRequest.predicate = predicate
        return self
    }
    
    @discardableResult
    public func `where`(_ clause: Where<T>) -> FetchRequest {
        fetchRequest.predicate = clause.predicate
        return self
    }
    
    // MARK: FETCH PROPERTIES CLAUSE
    
    @discardableResult
    public func properties(_ propertiesToFetch: [Any]) -> FetchRequest {
        fetchRequest.propertiesToFetch = propertiesToFetch
        return self
    }
    
    @discardableResult
    public func properties(_ propertiesToFetch: PartialKeyPath<T>...) -> FetchRequest {
        let propertiesToFetch = propertiesToFetch.compactMap { $0._kvcKeyPathString }
        fetchRequest.propertiesToFetch = propertiesToFetch
        return self
    }
    
    // MARK: GROUP BY CLAUSE
    
    @discardableResult
    public func groupBy(_ propertiesToGroupBy: [Any]) -> FetchRequest {
        fetchRequest.propertiesToGroupBy = propertiesToGroupBy
        fetchRequest.resultType = .dictionaryResultType
        return self
    }
    
    @discardableResult
    public func groupBy(_ propertiesToGroupBy: Any...) -> FetchRequest {
        fetchRequest.propertiesToGroupBy = propertiesToGroupBy
        fetchRequest.resultType = .dictionaryResultType
        return self
    }
    
    @discardableResult
    public func groupBy<Value>(_ groupBy: KeyPath<T, Value>, _ propertiesToGroupBy: PartialKeyPath<T>...) -> FetchRequest {
        let propertiesToGroupBy = ([groupBy] + propertiesToGroupBy).compactMap { $0._kvcKeyPathString }
        fetchRequest.propertiesToGroupBy = propertiesToGroupBy
        fetchRequest.resultType = .dictionaryResultType
        return self
    }
    
    // MARK: HAVING CLAUSE
    
    @discardableResult
    public func having(_ format: String, args: CVarArg...) -> FetchRequest {
        let predicate = NSPredicate(format: format, args)
        fetchRequest.havingPredicate = predicate
        return self
    }

    @discardableResult
    public func having(_ value: Bool) -> FetchRequest {
        let predicate = NSPredicate(value: value)
        fetchRequest.havingPredicate = predicate
        return self
    }

    @discardableResult
    public func having(_ format: String, argumentArray: [Any]?) -> FetchRequest {
        let predicate = NSPredicate(format: format, argumentArray: argumentArray)
        fetchRequest.havingPredicate = predicate
        return self
    }

    @discardableResult
    public func having(_ predicate: NSPredicate) -> FetchRequest {
        fetchRequest.havingPredicate = predicate
        return self
    }

    @discardableResult
    public func having(_ clause: Where<T>) -> FetchRequest {
        fetchRequest.havingPredicate = clause.predicate
        return self
    }
}

