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
