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
    return Where<T>("%K < %@", path, value.cs_toQueryableNativeType())
}

public func <= <T: NSManagedObject, Value: QueryableAttributeType & Comparable>(_ keyPath: KeyPath<T, Value>, _ value: Value) -> Where<T> {
    
    let path = keyPath._kvcKeyPathString!
    return Where<T>("%K <= %@", path, value.cs_toQueryableNativeType())
}

public func > <T: NSManagedObject, Value: QueryableAttributeType & Comparable>(_ keyPath: KeyPath<T, Value>, _ value: Value) -> Where<T> {
    
    let path = keyPath._kvcKeyPathString!
    return Where<T>("%K > %@", path, value.cs_toQueryableNativeType())
}

public func >= <T: NSManagedObject, Value: QueryableAttributeType & Comparable>(_ keyPath: KeyPath<T, Value>, _ value: Value) -> Where<T> {
    
    let path = keyPath._kvcKeyPathString!
    return Where<T>("%K >= %@", path, value.cs_toQueryableNativeType())
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
    
    let path = keyPath._kvcKeyPathString!
    if let value = value {
        return Where<T>("%K < %@", path, value.cs_toQueryableNativeType())
    } else {
        return Where<T>("%K < nil", path)
    }
}

public func <= <T: NSManagedObject, V: QueryableAttributeType & Comparable>(_ keyPath: KeyPath<T, Optional<V>>, _ value: V?) -> Where<T> {
    
    let path = keyPath._kvcKeyPathString!
    if let value = value {
        return Where<T>("%K <= %@", path, value.cs_toQueryableNativeType())
    } else {
        return Where<T>("%K <= nil", path)
    }
}

public func > <T: NSManagedObject, V: QueryableAttributeType & Comparable>(_ keyPath: KeyPath<T, Optional<V>>, _ value: V?) -> Where<T> {
    
    let path = keyPath._kvcKeyPathString!
    if let value = value {
        return Where<T>("%K > %@", path, value.cs_toQueryableNativeType())
    } else {
        return Where<T>("%K > nil", path)
    }
}

public func >= <T: NSManagedObject, V: QueryableAttributeType & Comparable>(_ keyPath: KeyPath<T, Optional<V>>, _ value: V?) -> Where<T> {
    
    let path = keyPath._kvcKeyPathString!
    if let value = value {
        return Where<T>("%K >= %@", path, value.cs_toQueryableNativeType())
    } else {
        return Where<T>("%K >= nil", path)
    }
}
