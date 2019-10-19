//
//  Keypath+Querying.swift
//  CoreDatabase
//
//  Created by Raghav Ahuja on 18/10/19.
//  Copyright © 2019 Raghav Ahuja. All rights reserved.
//

import CoreData

public func == <T: NSManagedObject, Value: QueryableAttributeType & Equatable>(_ keyPath: KeyPath<T, Value>, _ value: Value) -> Where<T> {
    
    let path = keyPath._kvcKeyPathString!
    return Where<T>(path, isEqualTo: value)
}

public func != <T: NSManagedObject, Value: QueryableAttributeType & Equatable>(_ keyPath: KeyPath<T, Value>, _ value: Value) -> Where<T> {
    
    let path = keyPath._kvcKeyPathString!
    return !Where<T>(path, isEqualTo: value)
}

public func < <T: NSManagedObject, Value: QueryableAttributeType & Comparable>(_ keyPath: KeyPath<T, Value>, _ value: Value) -> Where<T> {
    
    let path = keyPath._kvcKeyPathString!
    let predicate = NSPredicate(format: "\(path) < \(value.cs_toQueryableNativeType())")
    return Where<T>(predicate)
}

public func <= <T: NSManagedObject, Value: QueryableAttributeType & Comparable>(_ keyPath: KeyPath<T, Value>, _ value: Value) -> Where<T> {
    
    let path = keyPath._kvcKeyPathString!
    let predicate = NSPredicate(format: "\(path) <= \(value.cs_toQueryableNativeType())")
    return Where<T>(predicate)
}

public func > <T: NSManagedObject, Value: QueryableAttributeType & Comparable>(_ keyPath: KeyPath<T, Value>, _ value: Value) -> Where<T> {
    
    let path = keyPath._kvcKeyPathString!
    let predicate = NSPredicate(format: "\(path) > \(value.cs_toQueryableNativeType())")
    return Where<T>(predicate)
}

public func >= <T: NSManagedObject, Value: QueryableAttributeType & Comparable>(_ keyPath: KeyPath<T, Value>, _ value: Value) -> Where<T> {
    
    let path = keyPath._kvcKeyPathString!
    let predicate = NSPredicate(format: "\(path) >= \(value.cs_toQueryableNativeType())")
    return Where<T>(predicate)
}

// MARK: Optionals

public func == <T: NSManagedObject, V: QueryableAttributeType & Equatable>(_ keyPath: KeyPath<T, Optional<V>>, _ value: V?) -> Where<T> {
    
    let path = keyPath._kvcKeyPathString!
    return Where<T>(path, isEqualTo: value)
}

public func != <T: NSManagedObject, V: QueryableAttributeType & Equatable>(_ keyPath: KeyPath<T, Optional<V>>, _ value: V?) -> Where<T> {
    
    let path = keyPath._kvcKeyPathString!
    return !Where<T>(path, isEqualTo: value)
}

public func < <T: NSManagedObject, V: QueryableAttributeType & Comparable>(_ keyPath: KeyPath<T, Optional<V>>, _ value: V?) -> Where<T> {
    
    if let value = value {
        return Where<T>("%K < %@", keyPath._kvcKeyPathString!, value.cs_toQueryableNativeType())
    } else {
        return Where<T>("%K < nil", keyPath._kvcKeyPathString!)
    }
}

public func <= <T: NSManagedObject, V: QueryableAttributeType & Comparable>(_ keyPath: KeyPath<T, Optional<V>>, _ value: V?) -> Where<T> {
    
    if let value = value {
        return Where<T>("%K <= %@", keyPath._kvcKeyPathString!, value.cs_toQueryableNativeType())
    } else {
        return Where<T>("%K <= nil", keyPath._kvcKeyPathString!)
    }
}

public func > <T: NSManagedObject, V: QueryableAttributeType & Comparable>(_ keyPath: KeyPath<T, Optional<V>>, _ value: V?) -> Where<T> {
    
    if let value = value {
        return Where<T>("%K > %@", keyPath._kvcKeyPathString!, value.cs_toQueryableNativeType())
    } else {
        return Where<T>("%K > nil", keyPath._kvcKeyPathString!)
    }
}

public func >= <T: NSManagedObject, V: QueryableAttributeType & Comparable>(_ keyPath: KeyPath<T, Optional<V>>, _ value: V?) -> Where<T> {
    
    if let value = value {
        return Where<T>("%K >= %@", keyPath._kvcKeyPathString!, value.cs_toQueryableNativeType())
    } else {
        return Where<T>("%K >= nil", keyPath._kvcKeyPathString!)
    }
}
