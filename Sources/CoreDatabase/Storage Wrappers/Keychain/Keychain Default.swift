//
//  Keychain Default.swift
//  CoreDatabase
//
//  Created by Raghav Ahuja on 08/11/19.
//  Copyright © 2019 Raghav Ahuja. All rights reserved.
//

import Foundation

open class KeychainDefault {
    
    @discardableResult open class func set(_ value: String, for key: StorageKeys) -> Bool {
        return Keychain.standard.set(value, for: key.value)
    }
    
    @discardableResult open class func set(_ value: Int, for key: StorageKeys) -> Bool {
        return Keychain.standard.set(value, for: key.value)
    }
    
    @discardableResult open class func set(_ value: Float, for key: StorageKeys) -> Bool {
        return Keychain.standard.set(value, for: key.value)
    }
    
    @discardableResult open class func set(_ value: Double, for key: StorageKeys) -> Bool {
        return Keychain.standard.set(value, for: key.value)
    }
    
    @discardableResult open class func set(_ value: Bool, for key: StorageKeys) -> Bool {
        return Keychain.standard.set(value, for: key.value)
    }
    
    @discardableResult open class func set(_ value: NSNumber, for key: StorageKeys) -> Bool {
        return Keychain.standard.set(value, for: key.value)
    }
    
    @discardableResult open class func delete(key: StorageKeys) -> Bool {
        return Keychain.standard.removeObject(for: key.value)
    }
    
    open class func stringValue(for key: StorageKeys) -> String? {
        return Keychain.standard.string(for: key.value)
    }
    
    open class func intValue(for key: StorageKeys) -> Int? {
        return Keychain.standard.integer(for: key.value)
    }
    
    open class func floatValue(for key: StorageKeys) -> Float? {
        return Keychain.standard.float(for: key.value)
    }
    
    open class func doubleValue(for key: StorageKeys) -> Double? {
        return Keychain.standard.double(for: key.value)
    }
    
    open class func boolValue(for key: StorageKeys) -> Bool? {
        return Keychain.standard.bool(for: key.value)
    }
    
    open class func nsNumberValue(for key: StorageKeys) -> NSNumber? {
        return Keychain.standard.object(for: key.value) as? NSNumber
    }
    
    @discardableResult open class func clearAll() -> Bool {
        return Keychain.standard.removeAllKeys()
    }
}
