//
//  CKBatchInsert.swift
//  CoreDatabaseKit
//
//  Created by Raghav Ahuja on 18/10/19.
//  Copyright © 2019 Raghav Ahuja. All rights reserved.
//

import Foundation

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public class CKBatchInsert<Object: CKObject> {
    
    let batchInsertRequest: CKBatchInsertRequest
    
    public init(objectsToInsert: CKBatchInserts) {
        batchInsertRequest = CKBatchInsertRequest(entity: Object.self.entity(), objects: objectsToInsert)
    }
}
