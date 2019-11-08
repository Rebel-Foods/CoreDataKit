//
//  User Default.swift
//  CoreDatabase
//
//  Created by Raghav Ahuja on 08/11/19.
//  Copyright © 2019 Raghav Ahuja. All rights reserved.
//

import Foundation

open class UserDefault {
    
    open class func set(_ value: Any?, for Key: StorageKeys) {
        UserDefaults.standard.set(value, forKey: Key.value)
    }
    
//    class func set(_ keyedValues: [StorageKeys : Any]) {
//        let values = Dictionary(uniqueKeysWithValues: keyedValues.map { ($0, $1) })
//        UserDefaults.standard.setValuesForKeys(values)
//    }
    
    open class func delete(for key: StorageKeys) {
        UserDefaults.standard.removeObject(forKey: key.value)
    }
    
    open class func value(for key: StorageKeys) -> Any? {
        return UserDefaults.standard.value(forKey: key.value)
    }
    
    open class func stringValue(for key: StorageKeys) -> String {
        return UserDefaults.standard.string(forKey: key.value) ?? "nil"
    }
    
    open class func intValue(for key: StorageKeys) -> Int {
        return UserDefaults.standard.integer(forKey: key.value)
    }
    
    open class func floatValue(for key: StorageKeys) -> Float {
        return UserDefaults.standard.float(forKey: key.value)
    }
    
    open class func doubleValue(for key: StorageKeys) -> Double {
        return UserDefaults.standard.double(forKey: key.value)
    }
    
    open class func boolValue(for key: StorageKeys) -> Bool {
        return UserDefaults.standard.bool(forKey: key.value)
    }
    
    open class func data(for key: StorageKeys) -> Data? {
        return UserDefaults.standard.data(forKey: key.value)
    }
}
