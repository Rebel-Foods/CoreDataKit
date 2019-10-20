//
//  PerformBatchUpdates.swift
//  CoreDatabase
//
//  Created by Raghav Ahuja on 19/10/19.
//  Copyright © 2019 Raghav Ahuja. All rights reserved.
//

import CoreData

internal final class BatchUpdate<T: NSManagedObject> {
    
    /// Executes a batch update request on a `private queue`.
    /// - Parameter builder: Block that returns Batch Update Request.
    init(_ builder: () -> BatchUpdateRequest<T>) throws {
        let request = builder()
        try request.context.execute(request.batchUpdateRequest)
    }
}
