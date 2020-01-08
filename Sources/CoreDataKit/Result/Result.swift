//
//  Result.swift
//  CoreDataKit
//
//  Created by Raghav Ahuja on 18/10/19.
//  Copyright © 2019 Raghav Ahuja. All rights reserved.
//

import Foundation

public protocol CKResult {
    associatedtype CKType
    
    static var ckResultType: CKResultType { get }
}

extension Int: CKResult {
    
    public typealias CKType = Self
    
    public static var ckResultType: CKResultType {
        .count
    }
}

extension Bool: CKResult {
    
    public typealias CKType = Self
    
    public static var ckResultType: CKResultType {
        .statusOnly
    }
}

extension CKObjectId: CKResult {
    
    public typealias CKType = [CKObjectId]
    
    public static var ckResultType: CKResultType {
        .objectIds
    }
}

/// Batch Request result type.
public struct CKResultType {
    
    private enum ResultType {
        case statusOnly
        case objectIds
        case count
    }
    
    private let resultType: ResultType
    
    let batchUpdate: CKBatchUpdateResultType
    let batchDelete: CKBatchDeleteResultType
    
    
    static let statusOnly = CKResultType(resultType: .statusOnly, batchUpdate: .statusOnlyResultType, batchDelete: .resultTypeStatusOnly)  // Return a status boolean. Bool.
    
    static let objectIds = CKResultType(resultType: .objectIds, batchUpdate: .updatedObjectIDsResultType, batchDelete: .resultTypeObjectIDs) // Return the object IDs of the rows that were inserted / updated. [CKObjectId].
    
    static let count = CKResultType(resultType: .count, batchUpdate: .updatedObjectsCountResultType, batchDelete: .resultTypeCount) // Return the number of rows that were inserted / updated.
    
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func batchInsertValue() -> CKBatchInsertResultType {
        switch resultType {
        case .statusOnly: return .statusOnly
        case .objectIds: return .objectIDs
        case .count: return .count
        }
    }
}
