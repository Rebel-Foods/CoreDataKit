//
//  Keypath+Querying.swift
//  CoreDatabase
//
//  Created by Raghav Ahuja on 18/10/19.
//  Copyright © 2019 Raghav Ahuja. All rights reserved.
//

import Foundation

/**
Creates a `Where` clause by comparing if a attribute is equal to given value.
 
 ```
 CKFetch<User>().where(\.id == 101)
 ```
 
- Parameter keyPath: A key path from a specific `CKObject` to a specific resulting value type.
- Parameter value: Equatable Value with same type of KeyPath.
 **/
public func == <T: CKObject, Value: CKEquatableQuery>(_ keyPath: KeyPath<T, Value>, _ value: Value) -> Where<T> {
    Where<T>(keyPath, isEqualTo: value)
}

/**
Creates a `Where` clause by comparing if a attribute is not equal to given value.

```
CKFetch<User>().where(\.id != 101)
```

- Parameter keyPath: A key path from a specific `CKObject` to a specific resulting value type.
- Parameter value: Equatable Value with same type of KeyPath.
**/
 public func != <T: CKObject, Value: CKEquatableQuery>(_ keyPath: KeyPath<T, Value>, _ value: Value) -> Where<T> {
    !Where<T>(keyPath, isEqualTo: value)
}

/**
Creates a `Where` clause by comparing if a attribute is less than given value.

```
CKFetch<User>().where(\.age < 18)
```

- Parameter keyPath: A key path from a specific `CKObject` to a specific resulting value type.
- Parameter value: Equatable Value with same type of KeyPath.
**/
 public func < <T: CKObject, Value: CKComparableQuery>(_ keyPath: KeyPath<T, Value>, _ value: Value) -> Where<T> {
     Where(keyPath, isLessThan: value)
}

/**
Creates a `Where` clause by comparing if a attribute is less than or equal to given value.

```
CKFetch<User>().where(\.age <= 18)
```

- Parameter keyPath: A key path from a specific `CKObject` to a specific resulting value type.
- Parameter value: Equatable Value with same type of KeyPath.
**/
 public func <= <T: CKObject, Value: CKComparableQuery>(_ keyPath: KeyPath<T, Value>, _ value: Value) -> Where<T> {
    Where(keyPath, isLessThanEqualTo: value)
}

/**
Creates a `Where` clause by comparing if a attribute is greater than given value.

```
CKFetch<User>().where(\.age > 18)
```

- Parameter keyPath: A key path from a specific `CKObject` to a specific resulting value type.
- Parameter value: Equatable Value with same type of KeyPath.
**/
 public func > <T: CKObject, Value: CKComparableQuery>(_ keyPath: KeyPath<T, Value>, _ value: Value) -> Where<T> {
     Where(keyPath, isGreaterThan: value)
}

/**
Creates a `Where` clause by comparing if a attribute is greated than or equal to given value.

```
CKFetch<User>().where(\.age >= 18)
```

- Parameter keyPath: A key path from a specific `CKObject` to a specific resulting value type.
- Parameter value: Equatable Value with same type of KeyPath.
**/
 public func >= <T: CKObject, Value: CKComparableQuery>(_ keyPath: KeyPath<T, Value>, _ value: Value) -> Where<T> {
    Where(keyPath, isGreaterThanEqualTo: value)
}

// MARK: Optionals

/**
Creates a `Where` clause by comparing if a attribute is equal to given value.

```
CKFetch<User>().where(\.id == 101)
```

- Parameter keyPath: A key path from a specific `CKObject` to a specific resulting value type.
- Parameter value: Equatable Value with same type of KeyPath.
**/
 public func == <T: CKObject, Value: CKEquatableQuery>(_ keyPath: KeyPath<T, Value?>, _ value: Value?) -> Where<T> {
    Where(keyPath, isEqualTo: value)
}

/**
Creates a `Where` clause by comparing if a attribute is not equal to given value.

```
CKFetch<User>().where(\.id != 101)
```

- Parameter keyPath: A key path from a specific `CKObject` to a specific resulting value type.
- Parameter value: Equatable Value with same type of KeyPath.
**/
 public func != <T: CKObject, Value: CKEquatableQuery>(_ keyPath: KeyPath<T, Value?>, _ value: Value?) -> Where<T> {
    !Where(keyPath, isEqualTo: value)
}

/**
Creates a `Where` clause by comparing if a attribute is less than given value.

```
CKFetch<User>().where(\.age < 18)
```

- Parameter keyPath: A key path from a specific `CKObject` to a specific resulting value type.
- Parameter value: Equatable Value with same type of KeyPath.
**/
 public func < <T: CKObject, Value: CKComparableQuery>(_ keyPath: KeyPath<T, Value?>, _ value: Value?) -> Where<T> {
     Where(keyPath, isLessThan: value)
}

/**
Creates a `Where` clause by comparing if a attribute is less than or equal to given value.

```
CKFetch<User>().where(\.age <= 18)
```

- Parameter keyPath: A key path from a specific `CKObject` to a specific resulting value type.
- Parameter value: Equatable Value with same type of KeyPath.
**/
 public func <= <T: CKObject, Value: CKComparableQuery>(_ keyPath: KeyPath<T, Value?>, _ value: Value?) -> Where<T> {
    Where(keyPath, isLessThanEqualTo: value)
}

/**
Creates a `Where` clause by comparing if a attribute is greater than given value.

```
CKFetch<User>().where(\.age > 18)
```

- Parameter keyPath: A key path from a specific `CKObject` to a specific resulting value type.
- Parameter value: Equatable Value with same type of KeyPath.
**/
 public func > <T: CKObject, Value: CKComparableQuery>(_ keyPath: KeyPath<T, Value?>, _ value: Value?) -> Where<T> {
    Where(keyPath, isGreaterThan: value)
}

/**
Creates a `Where` clause by comparing if a attribute is greated than or equal to given value.

```
CKFetch<User>().where(\.age >= 18)
```

- Parameter keyPath: A key path from a specific `CKObject` to a specific resulting value type.
- Parameter value: Equatable Value with same type of KeyPath.
**/
 public func >= <T: CKObject, Value: CKComparableQuery>(_ keyPath: KeyPath<T, Value?>, _ value: Value?) -> Where<T> {
    Where(keyPath, isGreaterThanEqualTo: value)
}
