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
    
    /// Creates a default `NSFetchRequest` of `ManagedObject`.`
    public init() {
        fetchRequest = T.self.fetchRequest()
    }
    
    // MARK: FETCH BATCH SIZE CLAUSE
    
    /// The batch size of the objects specified in the fetch request.
    ///
    ///The default value is 0. A batch size of 0 is treated as infinite, which disables the batch faulting behavior.
    ///
    /// If you set a nonzero batch size, the collection of objects returned when an instance of NSFetchRequest is executed is broken into batches. When the fetch is executed, the entire request is evaluated and the identities of all matching objects recorded, but only data for objects up to the batchSize will be fetched from the persistent store at a time. The array returned from executing the request is a proxy object that transparently faults batches on demand. (In database terms, this is an in-memory cursor.)
    ///
    /// You can use this feature to restrict the working set of data in your application. In combination with fetchLimit, you can create a subrange of an arbitrary result set.
    ///
    /// - Parameter fetchBatchSize: The batch size of the objects specified in the fetch request.
    @discardableResult
    public func batchSize(_ fetchBatchSize: Int) -> FetchRequest {
        fetchRequest.fetchBatchSize = fetchBatchSize
        return self
    }
    
    // MARK: FETCH LIMIT CLAUSE
    
    /// The fetch limit of the fetch request.
    ///
    /// The fetch limit specifies the maximum number of objects that a request should return when executed.
    ///
    /// If you set a fetch limit, the framework makes a best effort to improve efficiency, but does not guarantee it. For every object store except the SQL store, a fetch request executed with a fetch limit in effect simply performs an unlimited fetch and throws away the unasked for rows.
    ///
    /// - Parameter fetchLimit: The fetch limit of the fetch request.
    @discardableResult
    public func limit(_ fetchLimit: Int) -> FetchRequest {
        fetchRequest.fetchLimit = fetchLimit
        return self
    }
    
    // MARK: CUSTOMISE CLAUSE
    
    /// Customise `NSFetchRequest`.
    /// - Parameter requestBlock: The block to customize the `NSFetchRequest`.
    @discardableResult
    public func customise(_ requestBlock: (RequestType) -> Void) -> FetchRequest {
        requestBlock(fetchRequest)
        return self
    }
    
    // MARK: ORDER BY CLAUSE
    
    /// `OrderBy` clause to create a `FetchRequest` with.
    /// - Parameter sortKeys: Array of `OrderBy` clauses with KeyPath.
    @discardableResult
    public func orderBy<Value>(_ sortKeys: OrderBy<T, Value>...) -> FetchRequest {
        fetchRequest.sortDescriptors = sortKeys.map { $0.descriptor }
        return self
    }
    
    /// The sort descriptors of the fetch request.
    ///
    /// The sort descriptors specify how the objects returned when the FetchRequest is issued should be ordered—for example, by last name and then by first name. The sort descriptors are applied in the order in which they appear in the sortDescriptors array (serially in lowest-array-index-first order).
    ///
    /// A value of nil is treated as no sort descriptors.
    ///
    /// - Parameter sortDescriptors: The sort descriptors of the fetch request.
    @discardableResult
    public func orderBy(sortDescriptors: NSSortDescriptor...) -> FetchRequest {
        fetchRequest.sortDescriptors = sortDescriptors.map { $0 }
        return self
    }
    
    // MARK: WHERE CLAUSE
    
    /// Initializes a predicate by substituting the values in a given array into a format string and parsing the result.
    /// - Parameter format: The format string for the new predicate.
    /// - Parameter args: The arguments to substitute into predicateFormat. Values are substituted in the order they appear in the array.
    @discardableResult
    public func `where`(_ format: String, args: CVarArg...) -> FetchRequest {
        let predicate = NSPredicate(format: format, args)
        fetchRequest.predicate = predicate
        return self
    }
    
    /// Creates and returns a predicate that always evaluates to a given Boolean value.
    /// - Parameter value: The Boolean value to which the new predicate should evaluate.
    @discardableResult
    public func `where`(_ value: Bool) -> FetchRequest {
        let predicate = NSPredicate(value: value)
        fetchRequest.predicate = predicate
        return self
    }
    
    /// Initializes a predicate by substituting the values in a given array into a format string and parsing the result.
    /// - Parameter format: The format string for the new predicate.
    /// - Parameter args: The arguments to substitute into predicateFormat. Values are substituted in the order they appear in the array.
    @discardableResult
    public func `where`(_ format: String, argumentArray: [Any]?) -> FetchRequest {
        let predicate = NSPredicate(format: format, argumentArray: argumentArray)
        fetchRequest.predicate = predicate
        return self
    }
    
    /// The predicate of the fetch request.
    /// - Parameter predicate: The predicate instance constrains the selection of objects the `FetchRequest` instance is to fetch.
    @discardableResult
    public func `where`(_ predicate: NSPredicate?) -> FetchRequest {
        fetchRequest.predicate = predicate
        return self
    }
    
    /// The predicate of the fetch request.
    /// - Parameter clause: `Where` clause to create a `FetchRequest` with.
    @discardableResult
    public func `where`(_ clause: Where<T>) -> FetchRequest {
        fetchRequest.predicate = clause.predicate
        return self
    }
    
    // MARK: FETCH PROPERTIES CLAUSE
    
    /// A collection of either property descriptions or string property names that specify which properties should be returned by the fetch.
    ///
    /// Property descriptions can either be instances of NSPropertyDescription or NSString. The property descriptions may represent attributes, to-one relationships, or expressions. The name of an attribute or relationship description must match the name of a description on the fetch request’s entity.
    /// - Parameter propertiesToFetch: A collection of either property descriptions or string property names that specify which properties should be returned by the fetch.
    @discardableResult
    public func properties(_ propertiesToFetch: [Any]?) -> FetchRequest {
        fetchRequest.propertiesToFetch = propertiesToFetch
        return self
    }
    
    /// A collection of either property descriptions or string property names that specify which properties should be returned by the fetch.
    ///
    /// Property descriptions can either be instances of NSPropertyDescription or NSString. The property descriptions may represent attributes, to-one relationships, or expressions. The name of an attribute or relationship description must match the name of a description on the fetch request’s entity.
    /// - Parameter propertiesToFetch: A collection of either property descriptions or string property names that specify which properties should be returned by the fetch.
    @discardableResult
    public func properties(_ propertiesToFetch: PartialKeyPath<T>...) -> FetchRequest {
        let propertiesToFetch = propertiesToFetch.compactMap { $0._kvcKeyPathString }
        fetchRequest.propertiesToFetch = propertiesToFetch
        return self
    }
    
    // MARK: GROUP BY CLAUSE
    
    /// An array of objects that indicates how data should be grouped before a select statement is run in a SQL database.
    ///
    ///An array of NSPropertyDescription or NSExpressionDescription objects or key-path strings that indicate how data should be grouped before a select statement is run in an SQL database.
    ///
    ///If you use this setting, you must set the resultType to dictionaryResultType, and the SELECT values must be literals, aggregates, or columns specified in propertiesToGroupBy.
    ///
    ///Aggregates will operate on the groups specified in propertiesToGroupBy rather than the whole table. If you set propertiesToGroupBy, you can also set a predicate to filter rows that are returned by propertiesToGroupBy.
    ///
    /// - Parameter propertiesToGroupBy: An array of objects that indicates how data should be grouped before a select statement is run in a SQL database.
    @discardableResult
    public func groupBy(_ propertiesToGroupBy: [Any]?) -> FetchRequest {
        fetchRequest.propertiesToGroupBy = propertiesToGroupBy
        fetchRequest.resultType = .dictionaryResultType
        return self
    }
    
    /// An array of objects that indicates how data should be grouped before a select statement is run in a SQL database.
    ///
    ///An array of NSPropertyDescription or NSExpressionDescription objects or key-path strings that indicate how data should be grouped before a select statement is run in an SQL database.
    ///
    ///If you use this setting, you must set the resultType to dictionaryResultType, and the SELECT values must be literals, aggregates, or columns specified in propertiesToGroupBy.
    ///
    ///Aggregates will operate on the groups specified in propertiesToGroupBy rather than the whole table. If you set propertiesToGroupBy, you can also set a predicate to filter rows that are returned by propertiesToGroupBy.
    ///
    /// - Parameter propertiesToGroupBy: An array of objects that indicates how data should be grouped before a select statement is run in a SQL database.
    @discardableResult
    public func groupBy(_ propertiesToGroupBy: Any...) -> FetchRequest {
        fetchRequest.propertiesToGroupBy = propertiesToGroupBy
        fetchRequest.resultType = .dictionaryResultType
        return self
    }
    
    /// An array of objects that indicates how data should be grouped before a select statement is run in a SQL database.
    ///
    ///An array of NSPropertyDescription or NSExpressionDescription objects or key-path strings that indicate how data should be grouped before a select statement is run in an SQL database.
    ///
    ///If you use this setting, you must set the resultType to dictionaryResultType, and the SELECT values must be literals, aggregates, or columns specified in propertiesToGroupBy.
    ///
    ///Aggregates will operate on the groups specified in propertiesToGroupBy rather than the whole table. If you set propertiesToGroupBy, you can also set a predicate to filter rows that are returned by propertiesToGroupBy.
    ///
    /// - Parameter groupBy: An object that indicates how data should be grouped before a select statement is run in a SQL database.
    /// - Parameter propertiesToGroupBy: An array of objects that indicates how data should be grouped before a select statement is run in a SQL database.
    @discardableResult
    public func groupBy<Value>(_ groupBy: KeyPath<T, Value>, _ propertiesToGroupBy: PartialKeyPath<T>...) -> FetchRequest {
        let propertiesToGroupBy = ([groupBy] + propertiesToGroupBy).compactMap { $0._kvcKeyPathString }
        fetchRequest.propertiesToGroupBy = propertiesToGroupBy
        fetchRequest.resultType = .dictionaryResultType
        return self
    }
    
    // MARK: HAVING CLAUSE
    
    /// The predicate used to filter rows being returned by a query containing a `GROUP BY` directive.
    ///
    /// If a `havingPredicate` value is supplied, the predicate will be run after .Specifying a havingPredicate requires that propertiesToGroupBy also be specified.
    ///
    /// - Parameter format: The format string for the new predicate.
    /// - Parameter args: The arguments to substitute into predicateFormat. Values are substituted in the order they appear in the array.
    @discardableResult
    public func having(_ format: String, args: CVarArg...) -> FetchRequest {
        let predicate = NSPredicate(format: format, args)
        fetchRequest.havingPredicate = predicate
        return self
    }
    
    /// The predicate used to filter rows being returned by a query containing a `GROUP BY` directive.
    ///
    /// If a `havingPredicate` value is supplied, the predicate will be run after .Specifying a havingPredicate requires that propertiesToGroupBy also be specified.
    ///
    /// - Parameter value: The Boolean value to which the new predicate should evaluate.
    @discardableResult
    public func having(_ value: Bool) -> FetchRequest {
        let predicate = NSPredicate(value: value)
        fetchRequest.havingPredicate = predicate
        return self
    }
    
    /// The predicate used to filter rows being returned by a query containing a `GROUP BY` directive.
    ///
    /// If a `havingPredicate` value is supplied, the predicate will be run after .Specifying a havingPredicate requires that propertiesToGroupBy also be specified.
    ///
    /// - Parameter format: The format string for the new predicate.
    /// - Parameter argumentArray: The arguments to substitute into predicateFormat. Values are substituted in the order they appear in the array.
    @discardableResult
    public func having(_ format: String, argumentArray: [Any]?) -> FetchRequest {
        let predicate = NSPredicate(format: format, argumentArray: argumentArray)
        fetchRequest.havingPredicate = predicate
        return self
    }
    
    /// The predicate used to filter rows being returned by a query containing a `GROUP BY` directive.
    ///
    /// If a `havingPredicate` value is supplied, the predicate will be run after .Specifying a havingPredicate requires that propertiesToGroupBy also be specified.
    ///
    /// - Parameter predicate: The predicate instance constrains the selection of objects the `FetchRequest` instance is to fetch.
    @discardableResult
    public func having(_ predicate: NSPredicate) -> FetchRequest {
        fetchRequest.havingPredicate = predicate
        return self
    }
    
    /// The predicate used to filter rows being returned by a query containing a `GROUP BY` directive.
    ///
    /// If a `havingPredicate` value is supplied, the predicate will be run after .Specifying a havingPredicate requires that propertiesToGroupBy also be specified.
    ///
    /// - Parameter clause: `Where` clause to create a `FetchRequest` with.
    @discardableResult
    public func having(_ clause: Where<T>) -> FetchRequest {
        fetchRequest.havingPredicate = clause.predicate
        return self
    }
}
