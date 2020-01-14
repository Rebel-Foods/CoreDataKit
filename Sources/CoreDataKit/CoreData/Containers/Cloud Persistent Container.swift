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
    
    convenience init(with name: String) {
        self.init(name: name)
    }

    func updateContexts() {
        viewContext.automaticallyMergesChangesFromParent = true
    }
}
