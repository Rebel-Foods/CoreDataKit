//
//  Keypath+Querying.swift
//  CoreDatabase
//
//  Created by Raghav Ahuja on 18/10/19.
//  Copyright © 2019 Raghav Ahuja. All rights reserved.
//

import CoreData

/**
Creates a `Where` clause by comparing if a attribute is equal to given value.
 
 ```
 FetchRequest<User>().where(\.id == 101)
 ```
 
- Parameter keyPath: A key path from a specific `NSManagedObject` to a specific resulting value type.
- Parameter value: Equatable Value with same type of KeyPath.
 **/
public func == <T: NSManagedObject, Value: QueryableAttributeType & Equatable>(_ keyPath: KeyPath<T, Value>, _ value: Value) -> Where<T> {
    
    let path = keyPath._kvcKeyPathString!
    return Where<T>(path, isEqualTo: value)
}

/**
Creates a `Where` clause by comparing if a attribute is not equal to given value.

```
FetchRequest<User>().where(\.id != 101)
```

- Parameter keyPath: A key path from a specific `NSManagedObject` to a specific resulting value type.
- Parameter value: Equatable Value with same type of KeyPath.
**/
 public func != <T: NSManagedObject, Value: QueryableAttributeType & Equatable>(_ keyPath: KeyPath<T, Value>, _ value: Value) -> Where<T> {
    
    let path = keyPath._kvcKeyPathString!
    return !Where<T>(path, isEqualTo: value)
}

/**
Creates a `Where` clause by comparing if a attribute is less than given value.

```
FetchRequest<User>().where(\.age < 18)
```

- Parameter keyPath: A key path from a specific `NSManagedObject` to a specific resulting value type.
- Parameter value: Equatable Value with same type of KeyPath.
**/
 public func < <T: NSManagedObject, Value: QueryableAttributeType & Comparable>(_ keyPath: KeyPath<T, Value>, _ value: Value) -> Where<T> {
    
    let path = keyPath._kvcKeyPathString!
    return Where<T>("%K < %@", path, value.cs_toQueryableNativeType())
}

/**
Creates a `Where` clause by comparing if a attribute is less than or equal to given value.

```
FetchRequest<User>().where(\.age <= 18)
```

- Parameter keyPath: A key path from a specific `NSManagedObject` to a specific resulting value type.
- Parameter value: Equatable Value with same type of KeyPath.
**/
 public func <= <T: NSManagedObject, Value: QueryableAttributeType & Comparable>(_ keyPath: KeyPath<T, Value>, _ value: Value) -> Where<T> {
    
    let path = keyPath._kvcKeyPathString!
    return Where<T>("%K <= %@", path, value.cs_toQueryableNativeType())
}

/**
Creates a `Where` clause by comparing if a attribute is greater than given value.

```
FetchRequest<User>().where(\.age > 18)
```

- Parameter keyPath: A key path from a specific `NSManagedObject` to a specific resulting value type.
- Parameter value: Equatable Value with same type of KeyPath.
**/
 public func > <T: NSManagedObject, Value: QueryableAttributeType & Comparable>(_ keyPath: KeyPath<T, Value>, _ value: Value) -> Where<T> {
    
    let path = keyPath._kvcKeyPathString!
    return Where<T>("%K > %@", path, value.cs_toQueryableNativeType())
}

/**
Creates a `Where` clause by comparing if a attribute is greated than or equal to given value.

```
FetchRequest<User>().where(\.age >= 18)
```

- Parameter keyPath: A key path from a specific `NSManagedObject` to a specific resulting value type.
- Parameter value: Equatable Value with same type of KeyPath.
**/
 public func >= <T: NSManagedObject, Value: QueryableAttributeType & Comparable>(_ keyPath: KeyPath<T, Value>, _ value: Value) -> Where<T> {
    
    let path = keyPath._kvcKeyPathString!
    return Where<T>("%K >= %@", path, value.cs_toQueryableNativeType())
}

// MARK: Optionals

/**
Creates a `Where` clause by comparing if a attribute is equal to given value.

```
FetchRequest<User>().where(\.id == 101)
```

- Parameter keyPath: A key path from a specific `NSManagedObject` to a specific resulting value type.
- Parameter value: Equatable Value with same type of KeyPath.
**/
 public func == <T: NSManagedObject, V: QueryableAttributeType & Equatable>(_ keyPath: KeyPath<T, Optional<V>>, _ value: V?) -> Where<T> {
    
    let path = keyPath._kvcKeyPathString!
    return Where<T>(path, isEqualTo: value)
}

/**
Creates a `Where` clause by comparing if a attribute is not equal to given value.

```
FetchRequest<User>().where(\.id != 101)
```

- Parameter keyPath: A key path from a specific `NSManagedObject` to a specific resulting value type.
- Parameter value: Equatable Value with same type of KeyPath.
**/
 public func != <T: NSManagedObject, V: QueryableAttributeType & Equatable>(_ keyPath: KeyPath<T, Optional<V>>, _ value: V?) -> Where<T> {
    
    let path = keyPath._kvcKeyPathString!
    return !Where<T>(path, isEqualTo: value)
}

/**
Creates a `Where` clause by comparing if a attribute is less than given value.

```
FetchRequest<User>().where(\.age < 18)
```

- Parameter keyPath: A key path from a specific `NSManagedObject` to a specific resulting value type.
- Parameter value: Equatable Value with same type of KeyPath.
**/
 public func < <T: NSManagedObject, V: QueryableAttributeType & Comparable>(_ keyPath: KeyPath<T, Optional<V>>, _ value: V?) -> Where<T> {
    
    let path = keyPath._kvcKeyPathString!
    if let value = value {
        return Where<T>("%K < %@", path, value.cs_toQueryableNativeType())
    } else {
        return Where<T>("%K < nil", path)
    }
}

/**
Creates a `Where` clause by comparing if a attribute is less than or equal to given value.

```
FetchRequest<User>().where(\.age <= 18)
```

- Parameter keyPath: A key path from a specific `NSManagedObject` to a specific resulting value type.
- Parameter value: Equatable Value with same type of KeyPath.
**/
 public func <= <T: NSManagedObject, V: QueryableAttributeType & Comparable>(_ keyPath: KeyPath<T, Optional<V>>, _ value: V?) -> Where<T> {
    
    let path = keyPath._kvcKeyPathString!
    if let value = value {
        return Where<T>("%K <= %@", path, value.cs_toQueryableNativeType())
    } else {
        return Where<T>("%K <= nil", path)
    }
}

/**
Creates a `Where` clause by comparing if a attribute is greater than given value.

```
FetchRequest<User>().where(\.age > 18)
```

- Parameter keyPath: A key path from a specific `NSManagedObject` to a specific resulting value type.
- Parameter value: Equatable Value with same type of KeyPath.
**/
 public func > <T: NSManagedObject, V: QueryableAttributeType & Comparable>(_ keyPath: KeyPath<T, Optional<V>>, _ value: V?) -> Where<T> {
    
    let path = keyPath._kvcKeyPathString!
    if let value = value {
        return Where<T>("%K > %@", path, value.cs_toQueryableNativeType())
    } else {
        return Where<T>("%K > nil", path)
    }
}

/**
Creates a `Where` clause by comparing if a attribute is greated than or equal to given value.

```
FetchRequest<User>().where(\.age >= 18)
```

- Parameter keyPath: A key path from a specific `NSManagedObject` to a specific resulting value type.
- Parameter value: Equatable Value with same type of KeyPath.
**/
 public func >= <T: NSManagedObject, V: QueryableAttributeType & Comparable>(_ keyPath: KeyPath<T, Optional<V>>, _ value: V?) -> Where<T> {
    
    let path = keyPath._kvcKeyPathString!
    if let value = value {
        return Where<T>("%K >= %@", path, value.cs_toQueryableNativeType())
    } else {
        return Where<T>("%K >= nil", path)
    }
}
