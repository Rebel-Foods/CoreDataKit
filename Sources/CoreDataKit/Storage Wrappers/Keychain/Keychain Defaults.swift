//
//  Keychain Defaults.swift
//  CoreDataKit
//
//  Created by Raghav Ahuja on 18/10/19.
//  Copyright © 2019 Raghav Ahuja. All rights reserved.
//

import Foundation

open class KeychainDefaults: Keychain {
    
    private static let `default` = KeychainDefaults()
    
    open override class var standard: KeychainDefaults {
        .default
    }
    
    @discardableResult open func set<Key: StorageKeys>(_ value: String, for key: Key) -> Bool {
        return Keychain.standard.set(value, for: key.key)
    }
    
    @discardableResult open func set<Key: StorageKeys>(_ value: Int, for key: Key) -> Bool {
        return Keychain.standard.set(value, for: key.key)
    }
    
    @discardableResult open func set<Key: StorageKeys>(_ value: Float, for key: Key) -> Bool {
        return Keychain.standard.set(value, for: key.key)
    }
    
    @discardableResult open func set<Key: StorageKeys>(_ value: Double, for key: Key) -> Bool {
        return Keychain.standard.set(value, for: key.key)
    }
    
    @discardableResult open func set<Key: StorageKeys>(_ value: Bool, for key: Key) -> Bool {
        return Keychain.standard.set(value, for: key.key)
    }
    
    @discardableResult open func set<Key: StorageKeys>(_ value: NSNumber, for key: Key) -> Bool {
        return Keychain.standard.set(value, for: key.key)
    }
    
    @discardableResult open func delete<Key: StorageKeys>(key: Key) -> Bool {
        return Keychain.standard.removeObject(for: key.key)
    }
    
    open func stringValue<Key: StorageKeys>(for key: Key) -> String? {
        return Keychain.standard.string(for: key.key)
    }
    
    open func intValue<Key: StorageKeys>(for key: Key) -> Int? {
        return Keychain.standard.integer(for: key.key)
    }
    
    open func floatValue<Key: StorageKeys>(for key: Key) -> Float? {
        return Keychain.standard.float(for: key.key)
    }
    
    open func doubleValue<Key: StorageKeys>(for key: Key) -> Double? {
        return Keychain.standard.double(for: key.key)
    }
    
    open func boolValue<Key: StorageKeys>(for key: Key) -> Bool? {
        return Keychain.standard.bool(for: key.key)
    }
    
    open func nsNumberValue<Key: StorageKeys>(for key: Key) -> NSNumber? {
        return Keychain.standard.object(for: key.key) as? NSNumber
    }
}
