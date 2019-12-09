//
//  FetchClause.swift
//  CoreDatabaseKit
//
//  Created by Raghav Ahuja on 18/10/19.
//  Copyright © 2019 Raghav Ahuja. All rights reserved.
//

import Foundation

public protocol FetchClause {
    
    func fetch<Object: CKObject>(_ request: CKFetch<Object>) throws -> [Object]
    
    func fetchFirst<Object: CKObject>(_ request: CKFetch<Object>) throws -> Object?
    
    func fetchExisting<Object: CKObject>(_ object: Object) -> Object?
    
    func fetchExisting<Object: CKObject>(with objectId: CKObjectId) -> Object?
    
    func fetchExisting<Object: CKObject, S: Sequence>(_ objects: S) -> [Object] where S.Iterator.Element == Object
    
    func fetchExisting<Object: CKObject, S: Sequence>(_ objectIds: S) -> [Object] where S.Iterator.Element == CKObjectId
    
    func fetchIds<Object: CKObject>(_ request: CKFetch<Object>) throws -> [CKObjectId]
    
    func query<Object: CKObject>(_ request: CKFetch<Object>) throws -> [NSDictionary]
    
    func count<Object: CKObject>(_ request: CKFetch<Object>) throws -> Int
    
    var unsafeContext: CKContext { get }
}
