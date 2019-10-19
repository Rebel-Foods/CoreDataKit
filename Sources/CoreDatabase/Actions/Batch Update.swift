//
//  PerformBatchUpdates.swift
//  CoreDatabase
//
//  Created by Raghav Ahuja on 19/10/19.
//  Copyright © 2019 Raghav Ahuja. All rights reserved.
//

import CoreData

internal final class BatchUpdate<T: NSManagedObject> {
    
    init(_ builder: (BatchUpdateRequest<T>) -> Void) throws {
        let request = BatchUpdateRequest<T>()
        builder(request)
        
        try request.context.execute(request.batchUpdateRequest)
    }
}
