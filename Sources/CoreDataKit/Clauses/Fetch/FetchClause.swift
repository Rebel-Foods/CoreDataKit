//
//  FetchClause.swift
//  CoreDataKit
//
//  Created by Raghav Ahuja on 18/10/19.
//  Copyright © 2019 Raghav Ahuja. All rights reserved.
//

import Foundation

public protocol FetchClause {
    
    /// Fetches all `CKObject` instances that satisfy the specified fetch clauses provided.
    /// - Parameter request: A `CKFetch` request indicating the entity type and clauses.
    /// - Throws: If there is a problem executing the fetch, upon return contains an instance of NSError that describes the problem.
    /// Returns an array of objects that meet the criteria specified by a given fetch request.
    /// - Returns: An array of `CKObject` type objects that meet the criteria specified by the given `CKFetch` request.
    func fetch<Object: CKObject>(_ request: CKFetch<Object>) throws -> [Object]
    
    
    /// Fetches one `CKObject` instance that satisfy the specified fetch clauses provided.
    /// - Parameter request: A `CKFetch` request indicating the entity type and clauses.
    /// - Throws: If there is a problem executing the fetch, upon return contains an instance of NSError that describes the problem.
    /// - Returns: A type of `CKObject` that meets the criteria specified by the given `CKFetch` request if it exists.
    func fetchFirst<Object: CKObject>(_ request: CKFetch<Object>) throws -> Object?
    
    
    /// Returns the `CKObject` registered to current `CKContext` for the specified `CKObject` or nil if it does not exist.
    ///
    /// If there is a `CKObject` with the given `CKContext`'s ID already registered in the current `CKContext`, that object is returned directly; otherwise the corresponding object is faulted into the context.
    ///
    /// This method might perform I/O if the data is uncached.
    ///
    /// - Parameter object: The object for the requested object.
    /// - Throws: If there is a problem executing the fetch, upon return contains an instance of NSError that describes the problem.
    /// - Returns: A type of `CKObject` for the given `CKObject` if it exists.
    func fetchExisting<Object: CKObject>(_ object: Object) -> Object?
    
    
    /// Returns the `CKObject` registered to current `CKContext` for the specified `CKObject` or nil if it does not exist.
    ///
    /// If there is a `CKObject` with the given `CKObjectId` already registered in the current `CKContext`, that object is returned directly; otherwise the corresponding object is faulted into the context.
    ///
    /// This method might perform I/O if the data is uncached.
    ///
    /// - Parameter objectId: The `CKObjectId` for the requested `CKObject`.
    /// - Throws: If there is a problem executing the fetch, upon return contains an instance of NSError that describes the problem.
    /// - Returns: A type of `CKObject` for the given `CKObjectId` if it exists.
    func fetchExisting<Object: CKObject>(with objectId: CKObjectId) -> Object?
    
    
    /// Returns the `CKObject`s registered to current `CKContext` for the specified `CKObject`s. A `CKObject` which cannot be found in the current `CKContext` is not returned.
    ///
    /// If there is a managed object with the given ID already registered in the context, that object is returned directly; otherwise the corresponding object is faulted into the context.
    ///
    /// This method might perform I/O if the data is uncached.
    ///
    /// - Parameter objects: An array of objects registered to the current context for the requested objects.
    /// - Throws: If there is a problem executing the fetch, upon return contains an instance of NSError that describes the problem.
    /// - Returns: An array of exisiting `CKObject` type objects for the given `CKObjects`s.
    func fetchExisting<Object: CKObject, S: Sequence>(_ objects: S) -> [Object] where S.Iterator.Element == Object
    
    
    /// Returns the `CKObject`s registered to current `CKContext` for the specified `CKObjectId`s. A `CKObject` which cannot be found for the given `CKObjectId` in the current `CKContext` is not returned.
    ///
    /// If there is a managed object with the given ID already registered in the context, that object is returned directly; otherwise the corresponding object is faulted into the context.
    ///
    /// This method might perform I/O if the data is uncached.
    ///
    /// - Parameter objectIds: An array of object IDs for the requested objects.
    /// - Throws: If there is a problem executing the fetch, upon return contains an instance of NSError that describes the problem.
    /// - Returns: An array of exisiting `CKObject` type objects for the given `CKObjectId`s.
    func fetchExisting<Object: CKObject, S: Sequence>(_ objectIds: S) -> [Object] where S.Iterator.Element == CKObjectId
    
    
    /// Fetches `CKObjectId` instances that satisfy the specified fetch clauses provided.
    /// - Parameter request: A `CKFetch` request indicating the entity type and clauses.
    /// - Throws: If there is a problem executing the fetch, upon return contains an instance of NSError that describes the problem.
    /// - Returns: An array of `CKObjectId` type that meet the criteria specified by the given `CKFetch` request.
    func fetchIds<Object: CKObject>(_ request: CKFetch<Object>) throws -> [CKObjectId]
    
    
    /// Fetches `NSDictionary` instances that satisfy the specified fetch clauses provided.
    /// - Parameter request: A `CKFetch` request indicating the entity type and clauses.
    /// - Throws: If there is a problem executing the fetch, upon return contains an instance of NSError that describes the problem.
    /// - Returns: An array of `NSDictionary` that meet the criteria specified by the given `CKFetch` request.
    func query<Object: CKObject>(_ request: CKFetch<Object>) throws -> [NSDictionary]
    
    
    /// Returns the number of objects a given `CKFetch` request would have returned if it had been executed.
    /// - Parameter request: A `CKFetch` request indicating the entity type and clauses.
    /// - Throws: If there is a problem executing the fetch, upon return contains an instance of `NSError` that describes the problem.
    /// - Returns: The number of objects a given `CKFetch` request would have returned if it had been passed to `fetch(_:)`.
    func count<Object: CKObject>(for request: CKFetch<Object>) throws -> Int
    
    
    /// An internal object space that you use to manipulate and track changes to `CKObject`s.
    ///
    /// - Important:  Using this context directly should typically be avoided, and is provided only for extremely specialized cases.
    ///
    /// A context consists of a group of related model objects that represent an internally consistent view of one or more persistent stores. Changes to managed objects are held in memory, in the associated context, until that context is saved to one or more persistent stores. A single managed object instance exists in one and only one context, but multiple copies of an object can exist in different contexts. Thus an object is unique to a particular context.
    var unsafeContext: CKContext { get }
}
