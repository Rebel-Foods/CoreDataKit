//
//  OrderBy.swift
//  CoreDataKit
//
//  Created by Raghav Ahuja on 18/10/19.
//  Copyright © 2019 Raghav Ahuja. All rights reserved.
//

import Foundation

public enum OrderBy<Object: CKObject, Value>: Hashable, Equatable {
    
    case ascending(KeyPath<Object, Value>)
    case descending(KeyPath<Object, Value>)
    
    case ascendingReversed(KeyPath<Object, Value>)
    case descendingReversed(KeyPath<Object, Value>)
    
    internal var descriptor: CKSortDescriptor {
        switch self {
        case .ascending(let keyPath):
            return CKSortDescriptor(keyPath: keyPath, ascending: true)
            
        case .descending(let keyPath):
            return CKSortDescriptor(keyPath: keyPath, ascending: false)
            
        case .ascendingReversed(let keyPath):
            let sortDescriptor = CKSortDescriptor(keyPath: keyPath, ascending: true)
            return sortDescriptor.reversedSortDescriptor as! CKSortDescriptor
            
        case .descendingReversed(let keyPath):
            let sortDescriptor = CKSortDescriptor(keyPath: keyPath, ascending: false)
            return sortDescriptor.reversedSortDescriptor as! CKSortDescriptor
        }
    }
}
