//
//  File.swift
//  
//
//  Created by Raghav Ahuja on 09/12/19.
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

public enum CKResultType {
    case statusOnly
    case objectIDs
    case count

    @available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
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
}
