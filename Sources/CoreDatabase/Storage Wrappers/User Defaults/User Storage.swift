//
//  User Storage.swift
//  CoreDatabase
//
//  Created by Raghav Ahuja on 08/11/19.
//  Copyright © 2019 Raghav Ahuja. All rights reserved.
//

import Foundation

@propertyWrapper
public struct UserStorage<Value> {
    
    private let key: StorageKeys
    private var value: Value
    
    public init(key initialKey: StorageKeys, initialValue: Value) {
        key = initialKey
        value = initialValue
    }
    
    public var wrappedValue: Value {
        get {
            UserDefaults.standard.value(forKey: key.value) as? Value ?? value
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key.value)
            value = newValue
        }
    }
    
    public func delete() {
        UserDefaults.standard.removeObject(forKey: key.value)
    }
}
