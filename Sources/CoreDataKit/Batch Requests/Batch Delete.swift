//
//  Batch Delete.swift
//  CoreDataKit
//
//  Created by Raghav Ahuja on 08/01/20.
//  Copyright © 2019 Raghav Ahuja. All rights reserved.
//

import Foundation

public class CKBatchDelete<Result: CKResult> {
    
    let batchDeleteRequest: CKBatchDeleteRequest
    
    var type: String
    
    public init<Object: CKObject>(_ request: CKFetch<Object>) {
        batchDeleteRequest = CKBatchDeleteRequest(fetchRequest: request.fetchRequest)
        type = "\(Object.self)"
    }
    
    public init(objectIds: [CKObjectId]) {
        batchDeleteRequest = CKBatchDeleteRequest(objectIDs: objectIds)
        type = "\(objectIds)"
    }
}
