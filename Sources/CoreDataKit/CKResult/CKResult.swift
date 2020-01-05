//
//  CKResult.swift
//  CoreDataKit
//
//  Created by Raghav Ahuja on 18/10/19.
//  Copyright © 2019 Raghav Ahuja. All rights reserved.
//

import Foundation

public protocol CKResult {
    
    static var ckResultType: CKResultType { get }
}

extension Int: CKResult {
    
    public static var ckResultType: CKResultType {
        .count
    }
}

extension Bool: CKResult {
    
    public static var ckResultType: CKResultType {
        .statusOnly
    }
}

extension Array: CKResult where Element: CKObjectId {
    
    public static var ckResultType: CKResultType {
        .objectIDs
    }
}

/// Batch Request result type.
public enum CKResultType {
    case statusOnly  // Return a status boolean. Bool.
    case objectIDs // Return the object IDs of the rows that were inserted / updated. [CKObjectId].
    case count // Return the number of rows that were inserted / updated.

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    var batchInsert: CKBatchInsertResultType {
        switch self {
            case .statusOnly: return .statusOnly
            case .objectIDs: return .objectIDs
            case .count: return .count
        }
    }
    
    var batchUpdate: CKBatchUpdateResultType {
        switch self {
            case .statusOnly: return .statusOnlyResultType
            case .objectIDs: return .updatedObjectIDsResultType
            case .count: return .updatedObjectsCountResultType
        }
    }
    
    var batchDelete: CKBatchDeleteResultType {
        switch self {
        case .statusOnly: return .resultTypeStatusOnly
        case .objectIDs: return .resultTypeObjectIDs
        case .count: return .resultTypeCount
        }
    }
}
