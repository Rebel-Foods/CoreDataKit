//
//  Cloud Persisten tContainer.swift
//  CoreDataKit
//
//  Created by Raghav Ahuja on 06/01/20.
//  Copyright © 2019 Raghav Ahuja. All rights reserved.
//

import Foundation

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
final class CKCloudPersistentContainer: CKCloudContainer, CKContainerType {
    
    let mainContext = CKContext(concurrencyType: .mainQueueConcurrencyType)
    
    let savingContext = CKContext(concurrencyType: .privateQueueConcurrencyType)
    
    override var viewContext: CKContext {
        mainContext
    }
    
    init(with name: String) {
        self.init(name: name)
        
        savingContext.persistentStoreCoordinator = persistentStoreCoordinator
        
        mainContext.parent = savingContext
        
        mainContext.automaticallyMergesChangesFromParent = true
        savingContext.automaticallyMergesChangesFromParent = true
    }
    
    override init(name: String, managedObjectModel model: CKObjectModel) {
        super.init(name: name, managedObjectModel: model)
        
        savingContext.persistentStoreCoordinator = persistentStoreCoordinator
        
        mainContext.parent = savingContext
        
        mainContext.automaticallyMergesChangesFromParent = true
        savingContext.automaticallyMergesChangesFromParent = true
    }
}
