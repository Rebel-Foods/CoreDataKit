//
//  Keypath+Querying.swift
//  CoreDataKit
//
//  Created by Raghav Ahuja on 18/10/19.
//  Copyright © 2019 Raghav Ahuja. All rights reserved.
//

import Foundation

/**
Creates a `CKPredicate` clause by comparing if a attribute is equal to given value.
 
 ```
 CKFetch<User>().where(\.id == 101)
 ```
 
- Parameter keyPath: A key path from a specific `CKObject` to a specific resulting value type.
- Parameter value: Equatable Value with same type of KeyPath.
 **/
public func == <T: CKObject, Value: CKEquatableQuery>(_ keyPath: KeyPath<T, Value>, _ value: Value) -> CKPredicate<T> {
    CKPredicate<T>(keyPath, isEqualTo: value)
}

/**
Creates a `CKPredicate` clause by comparing if a attribute is not equal to given value.

```
CKFetch<User>().where(\.id != 101)
```

- Parameter keyPath: A key path from a specific `CKObject` to a specific resulting value type.
- Parameter value: Equatable Value with same type of KeyPath.
**/
 public func != <T: CKObject, Value: CKEquatableQuery>(_ keyPath: KeyPath<T, Value>, _ value: Value) -> CKPredicate<T> {
    !CKPredicate<T>(keyPath, isEqualTo: value)
}

/**
Creates a `CKPredicate` clause by comparing if a attribute is less than given value.

```
CKFetch<User>().where(\.age < 18)
```

- Parameter keyPath: A key path from a specific `CKObject` to a specific resulting value type.
- Parameter value: Equatable Value with same type of KeyPath.
**/
 public func < <T: CKObject, Value: CKComparableQuery>(_ keyPath: KeyPath<T, Value>, _ value: Value) -> CKPredicate<T> {
     CKPredicate(keyPath, isLessThan: value)
}

/**
Creates a `CKPredicate` clause by comparing if a attribute is less than or equal to given value.

```
CKFetch<User>().where(\.age <= 18)
```

- Parameter keyPath: A key path from a specific `CKObject` to a specific resulting value type.
- Parameter value: Equatable Value with same type of KeyPath.
**/
 public func <= <T: CKObject, Value: CKComparableQuery>(_ keyPath: KeyPath<T, Value>, _ value: Value) -> CKPredicate<T> {
    CKPredicate(keyPath, isLessThanEqualTo: value)
}

/**
Creates a `CKPredicate` clause by comparing if a attribute is greater than given value.

```
CKFetch<User>().where(\.age > 18)
```

- Parameter keyPath: A key path from a specific `CKObject` to a specific resulting value type.
- Parameter value: Equatable Value with same type of KeyPath.
**/
 public func > <T: CKObject, Value: CKComparableQuery>(_ keyPath: KeyPath<T, Value>, _ value: Value) -> CKPredicate<T> {
     CKPredicate(keyPath, isGreaterThan: value)
}

/**
Creates a `CKPredicate` clause by comparing if a attribute is greated than or equal to given value.

```
CKFetch<User>().where(\.age >= 18)
```

- Parameter keyPath: A key path from a specific `CKObject` to a specific resulting value type.
- Parameter value: Equatable Value with same type of KeyPath.
**/
 public func >= <T: CKObject, Value: CKComparableQuery>(_ keyPath: KeyPath<T, Value>, _ value: Value) -> CKPredicate<T> {
    CKPredicate(keyPath, isGreaterThanEqualTo: value)
}

// MARK: Optionals

/**
Creates a `CKPredicate` clause by comparing if a attribute is equal to given value.

```
CKFetch<User>().where(\.id == 101)
```

- Parameter keyPath: A key path from a specific `CKObject` to a specific resulting value type.
- Parameter value: Equatable Value with same type of KeyPath.
**/
 public func == <T: CKObject, Value: CKEquatableQuery>(_ keyPath: KeyPath<T, Value?>, _ value: Value?) -> CKPredicate<T> {
    CKPredicate(keyPath, isEqualTo: value)
}

/**
Creates a `CKPredicate` clause by comparing if a attribute is not equal to given value.

```
CKFetch<User>().where(\.id != 101)
```

- Parameter keyPath: A key path from a specific `CKObject` to a specific resulting value type.
- Parameter value: Equatable Value with same type of KeyPath.
**/
 public func != <T: CKObject, Value: CKEquatableQuery>(_ keyPath: KeyPath<T, Value?>, _ value: Value?) -> CKPredicate<T> {
    !CKPredicate(keyPath, isEqualTo: value)
}

/**
Creates a `CKPredicate` clause by comparing if a attribute is less than given value.

```
CKFetch<User>().where(\.age < 18)
```

- Parameter keyPath: A key path from a specific `CKObject` to a specific resulting value type.
- Parameter value: Equatable Value with same type of KeyPath.
**/
 public func < <T: CKObject, Value: CKComparableQuery>(_ keyPath: KeyPath<T, Value?>, _ value: Value?) -> CKPredicate<T> {
     CKPredicate(keyPath, isLessThan: value)
}

/**
Creates a `CKPredicate` clause by comparing if a attribute is less than or equal to given value.

```
CKFetch<User>().where(\.age <= 18)
```

- Parameter keyPath: A key path from a specific `CKObject` to a specific resulting value type.
- Parameter value: Equatable Value with same type of KeyPath.
**/
 public func <= <T: CKObject, Value: CKComparableQuery>(_ keyPath: KeyPath<T, Value?>, _ value: Value?) -> CKPredicate<T> {
    CKPredicate(keyPath, isLessThanEqualTo: value)
}

/**
Creates a `CKPredicate` clause by comparing if a attribute is greater than given value.

```
CKFetch<User>().where(\.age > 18)
```

- Parameter keyPath: A key path from a specific `CKObject` to a specific resulting value type.
- Parameter value: Equatable Value with same type of KeyPath.
**/
 public func > <T: CKObject, Value: CKComparableQuery>(_ keyPath: KeyPath<T, Value?>, _ value: Value?) -> CKPredicate<T> {
    CKPredicate(keyPath, isGreaterThan: value)
}

/**
Creates a `CKPredicate` clause by comparing if a attribute is greated than or equal to given value.

```
CKFetch<User>().where(\.age >= 18)
```

- Parameter keyPath: A key path from a specific `CKObject` to a specific resulting value type.
- Parameter value: Equatable Value with same type of KeyPath.
**/
 public func >= <T: CKObject, Value: CKComparableQuery>(_ keyPath: KeyPath<T, Value?>, _ value: Value?) -> CKPredicate<T> {
    CKPredicate(keyPath, isGreaterThanEqualTo: value)
}
