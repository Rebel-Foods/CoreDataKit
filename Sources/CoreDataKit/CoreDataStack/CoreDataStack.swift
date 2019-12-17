//
//  CoreDataStack.swift
//  CoreDataKit
//
//  Created by Raghav Ahuja on 18/10/19.
//  Copyright © 2019 Raghav Ahuja. All rights reserved.
//

import CoreData

// MARK: CoreDataStack
public final class CoreDataStack {
    
    public var viewContext: CKContext {
        persistentContainer.viewContext
    }
    
    public let databaseName: String
    
    private let mainContext = CKContext(concurrencyType: .mainQueueConcurrencyType)
    
    private let savingContext = CKContext(concurrencyType: .privateQueueConcurrencyType)

    /*
     The persistent container for the application. This implementation
     creates and returns a container, having loaded the store for the
     application to it. This property is optional since there are legitimate
     error conditions that could cause the creation of the store to fail.
    */
    public let persistentContainer: NSPersistentContainer
    
    public init(databaseName name: String) {
        databaseName = name
        
        persistentContainer = NSPersistentContainer(name: name)
        loadContainer()
    }
    
    func loadContainer() {
        persistentContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
            
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                CoreDataKit.default.logger.log(error: CKError(error))
//                CoreDataKit.default.logger.fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            self.persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
            self.savingContext.persistentStoreCoordinator = self.persistentContainer.persistentStoreCoordinator
            self.mainContext.parent = self.savingContext
            self.mainContext.automaticallyMergesChangesFromParent = true
            self.savingContext.automaticallyMergesChangesFromParent = true
        })
    }
    
    
    /// Causes the persistent container to execute the block against a new private queue context.
    /// - Parameter block: A block that is executed by the persistent container against a newly created private context. The private context is passed into the block as part of the execution of the block.
    func performBackgroundTask(_ block: @escaping (CKContext) -> Void) {
        persistentContainer.performBackgroundTask { (context) in
            context.automaticallyMergesChangesFromParent = true
            block(context)
        }
    }
    
    /// Creates a private managed object context.
    /// - Returns: A newly created private managed object context.
    func newBackgroundTask() -> CKContext {
        let context = persistentContainer.newBackgroundContext()
        context.automaticallyMergesChangesFromParent = true
        return context
    }
}
