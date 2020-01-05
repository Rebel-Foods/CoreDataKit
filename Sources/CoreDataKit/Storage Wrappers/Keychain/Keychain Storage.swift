//
//  Keychain Storage.swift
//  CoreDataKit
//
//  Created by Raghav Ahuja on 18/10/19.
//  Copyright © 2019 Raghav Ahuja. All rights reserved.
//

import Foundation

@propertyWrapper
public struct KeychainStorage<Value: CKQueryable> {
    
    private let key: String
    private var value: Value
    
    public init<Key: StorageKeys>(key k: Key, initialValue v: Value) {
        key = k.key
        value = v
    }
    
    public init(key k: String, initialValue v: Value) {
        key = k
        value = v
    }
    
    public var wrappedValue: Value {
        get {
            guard let data = Keychain.standard.data(for: key) else {
                return value
            }
            
            let unarchiveObject = try? Value.ckDecode(data: data)
            
            return unarchiveObject ?? value
        }
        set {
            do {
                let data = try newValue.ckEncode()
                if Keychain.standard.set(data, for: key) {
                    value = newValue
                } else {
                    print("Cannot save value for key: \(key) in Keychain.")
                }
            } catch {
                print("Cannot save value for key: \(key).\nError: \(error as NSError)")
            }
        }
    }
    
    public func delete() {
        Keychain.standard.removeObject(for: key)
    }
}
