//
//  FetchClause.swift
//  CoreDataKit
//
//  Created by Raghav Ahuja on 18/10/19.
//  Copyright © 2019 Raghav Ahuja. All rights reserved.
//

import Foundation

public protocol FetchClause {
    
    /// <#Description#>
    /// - Parameter request: <#request description#>
    func fetch<Object: CKObject>(_ request: CKFetch<Object>) throws -> [Object]
    
    /// <#Description#>
    /// - Parameter request: <#request description#>
    func fetchFirst<Object: CKObject>(_ request: CKFetch<Object>) throws -> Object?
    
    /// <#Description#>
    /// - Parameter object: <#object description#>
    func fetchExisting<Object: CKObject>(_ object: Object) -> Object?
    
    /// <#Description#>
    /// - Parameter objectId: <#objectId description#>
    func fetchExisting<Object: CKObject>(with objectId: CKObjectId) -> Object?
    
    /// <#Description#>
    /// - Parameter objects: <#objects description#>
    func fetchExisting<Object: CKObject, S: Sequence>(_ objects: S) -> [Object] where S.Iterator.Element == Object
    
    /// <#Description#>
    /// - Parameter objectIds: <#objectIds description#>
    func fetchExisting<Object: CKObject, S: Sequence>(_ objectIds: S) -> [Object] where S.Iterator.Element == CKObjectId
    
    /// <#Description#>
    /// - Parameter request: <#request description#>
    func fetchIds<Object: CKObject>(_ request: CKFetch<Object>) throws -> [CKObjectId]
    
    /// <#Description#>
    /// - Parameter request: <#request description#>
    func query<Object: CKObject>(_ request: CKFetch<Object>) throws -> [NSDictionary]
    
    /// <#Description#>
    /// - Parameter request: <#request description#>
    func count<Object: CKObject>(_ request: CKFetch<Object>) throws -> Int
    
    /// <#Description#>
    var unsafeContext: CKContext { get }
}
