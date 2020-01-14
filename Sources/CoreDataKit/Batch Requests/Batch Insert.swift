//
//  Batch Insert.swift
//  CoreDataKit
//
//  Created by Raghav Ahuja on 18/10/19.
//  Copyright © 2019 Raghav Ahuja. All rights reserved.
//

import Foundation

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public class CKBatchInsert<Object: CKObject, Result: CKResult> {
    
    let batchInsertRequest: CKBatchInsertRequest
    
    public init(objectsToInsert: CKBatchInserts) {
        batchInsertRequest = CKBatchInsertRequest(entity: Object.self.entity(), objects: objectsToInsert)
    }
}
