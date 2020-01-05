//
//  CKStoreDescriptionMethods.swift
//  CoreDataKit
//
//  Created by Raghav Ahuja on 06/01/20.
//  Copyright © 2019 Raghav Ahuja. All rights reserved.
//

import Foundation

public protocol CKStoreDescriptionMethods: class {
    
    @inline(__always)
    func addStoreDescriptions(_ descriptions: [CKStoreDescription])
    
    @inline(__always)
    func addStoreDescriptions(_ descriptions: CKStoreDescription...)
    
    @inline(__always)
    func replaceStoreDescriptions(with descriptions: [CKStoreDescription])
    
    @inline(__always)
    func replaceStoreDescriptions(with descriptions: CKStoreDescription...)
    
    @inline(__always)
    func loadPersistentStores(block: ((CKStoreDescription, NSError) -> Void)?)
}
