//
//  Aliases.swift
//  CoreDatabaseKit
//
//  Created by Raghav Ahuja on 18/10/19.
//  Copyright © 2019 Raghav Ahuja. All rights reserved.
//

import CoreData

public typealias CKObject = NSManagedObject

public typealias CKObjectId = NSManagedObjectID

public typealias CKContext = NSManagedObjectContext


public typealias CKFetchRequest<Result: CKFetchResult> = NSFetchRequest<Result>

public typealias CKFetchRequestResultType = NSFetchRequestResultType

public typealias CKFetchResult = NSFetchRequestResult


public typealias CKBatchDeleteRequest = NSBatchDeleteRequest

public typealias CKBatchDeleteResultType = NSBatchDeleteRequestResultType

public typealias CKBatchDeleteResult = NSBatchDeleteResult


public typealias CKBatchUpdates = [AnyHashable : Any]

public typealias CKKeyPathBatchUpdates<Object: CKObject> = [PartialKeyPath<Object>: Any]


public typealias CKBatchUpdateRequest = NSBatchUpdateRequest

public typealias CKBatchUpdateResultType = NSBatchUpdateRequestResultType

public typealias CKBatchUpdateResult = NSBatchUpdateResult


public typealias CKPredicate = NSPredicate

public typealias CKFetchedResultsController<ResultType: CKFetchResult> = NSFetchedResultsController<ResultType>

/// Constants that define merge policy types.
public typealias CKMergePolicyType = NSMergePolicyType

/// A policy object that you use to resolve conflicts between the persistent store and in-memory versions of managed objects.
///
///A conflict is a mismatch between state held at two different layers in the Core Data stack. A conflict can arise when you save a managed object context and you have stale data at another layer. There are two places in which a conflict may occur:
/// * Between the managed object context layer and its in-memory cached state at the persistent store coordinator layer.
/// * Between the cached state at the persistent store coordinator and the external store (file, database, and so forth).
///
/// Conflicts are represented by instances of [NSMergeConflict](apple-reference-documentation://hstmK0FPJu).
public typealias CKMergePolicy = NSMergePolicy
