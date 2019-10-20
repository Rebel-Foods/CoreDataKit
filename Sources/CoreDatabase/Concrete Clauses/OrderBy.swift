//
//  OrderBy.swift
//  CoreDatabase
//
//  Created by Raghav Ahuja on 18/10/19.
//  Copyright © 2019 Raghav Ahuja. All rights reserved.
//

import CoreData

public enum OrderBy<T: NSManagedObject, Value>: Hashable, Equatable {
    
    case ascending(KeyPath<T, Value>)
    case descending(KeyPath<T, Value>)
    
    internal var descriptor: NSSortDescriptor {
        switch self {
        case .ascending(let keyPath):
            return NSSortDescriptor(keyPath: keyPath, ascending: true)
            
        case .descending(let keyPath):
            return NSSortDescriptor(keyPath: keyPath, ascending: false)
        }
    }
}
