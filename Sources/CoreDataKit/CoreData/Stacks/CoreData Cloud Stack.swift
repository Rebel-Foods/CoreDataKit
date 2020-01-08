//
//  CoreData Cloud Stack.swift
//  CoreDataKit
//
//  Created by Raghav Ahuja on 06/01/20.
//  Copyright © 2019 Raghav Ahuja. All rights reserved.
//

import Foundation

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
final class CKCoreDataCloudStack: CKBaseStack<CKCloudPersistentContainer> {
    
    @inline(__always)
    func initializeCloudKitSchema(options: CKCloudSchemaInitializationOptions) throws {
        try persistentContainer.initializeCloudKitSchema(options: options)
    }
}
