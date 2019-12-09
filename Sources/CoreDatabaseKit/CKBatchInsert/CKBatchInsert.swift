//
//  File.swift
//  
//
//  Created by Raghav Ahuja on 09/12/19.
//

import Foundation

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public class CKBatchInsert<Object: CKObject> {
    
    let batchInsertRequest: CKBatchInsertRequest
    
    public init(objectsToInsert: CKBatchInserts) {
        batchInsertRequest = CKBatchInsertRequest(entity: Object.self.entity(), objects: objectsToInsert)
    }
}
