//
//  CKStack.swift
//  CoreDataKit
//
//  Created by Raghav Ahuja on 06/01/20.
//  Copyright © 2019 Raghav Ahuja. All rights reserved.
//

import Foundation

protocol CKStack: CKStoreDescriptionMethods {
    
    var viewContext: CKContext { get }
    
    func performBackgroundTask(_ block: @escaping (CKContext) -> Void)
    
    func newBackgroundTask() -> CKContext
}
