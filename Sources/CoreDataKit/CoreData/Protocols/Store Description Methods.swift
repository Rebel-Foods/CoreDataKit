//
//  Store Description Methods.swift
//  CoreDataKit
//
//  Created by Raghav Ahuja on 06/01/20.
//  Copyright © 2019 Raghav Ahuja. All rights reserved.
//

import Foundation

public protocol CKStoreDescriptionMethods: class {
    
    func addStoreDescriptions(_ descriptions: [CKStoreDescription])
    
    func addStoreDescriptions(_ descriptions: CKStoreDescription...)
    
    func replaceStoreDescriptions(with descriptions: [CKStoreDescription])
    
    func replaceStoreDescriptions(with descriptions: CKStoreDescription...)
    
    func loadPersistentStores(block: ((CKStoreDescription, NSError) -> Void)?)
}
