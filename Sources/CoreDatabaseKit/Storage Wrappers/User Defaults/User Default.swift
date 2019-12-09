//
//  User Default.swift
//  CoreDatabaseKit
//
//  Created by Raghav Ahuja on 18/10/19.
//  Copyright © 2019 Raghav Ahuja. All rights reserved.
//

import Foundation

open class UserDefault: UserDefaults {
    
    private static let shared = UserDefault()
    
    open override class var standard: UserDefault {
        shared
    }
    
    open func set<Key: StorageKeys>(_ value: Any?, for key: Key) {
        UserDefaults.standard.set(value, forKey: key.key)
    }
    
    class func set<Keys: StorageKeys>(_ keyedValues: [Keys : Any]) {
        let values = Dictionary(uniqueKeysWithValues: keyedValues.map { ($0.key, $1) })
        UserDefaults.standard.setValuesForKeys(values)
    }
    
    open func delete<Key: StorageKeys>(for key: Key) {
        UserDefaults.standard.removeObject(forKey: key.key)
    }
    
    open func value<Key: StorageKeys>(for key: Key) -> Any? {
        return UserDefaults.standard.value(forKey: key.key)
    }
    
    open func stringValue<Key: StorageKeys>(for key: Key) -> String {
        return UserDefaults.standard.string(forKey: key.key) ?? "nil"
    }
    
    open func intValue<Key: StorageKeys>(for key: Key) -> Int {
        return UserDefaults.standard.integer(forKey: key.key)
    }
    
    open func floatValue<Key: StorageKeys>(for key: Key) -> Float {
        return UserDefaults.standard.float(forKey: key.key)
    }
    
    open func doubleValue<Key: StorageKeys>(for key: Key) -> Double {
        return UserDefaults.standard.double(forKey: key.key)
    }
    
    open func boolValue<Key: StorageKeys>(for key: Key) -> Bool {
        return UserDefaults.standard.bool(forKey: key.key)
    }
    
    open func data<Key: StorageKeys>(for key: Key) -> Data? {
        return UserDefaults.standard.data(forKey: key.key)
    }
}
