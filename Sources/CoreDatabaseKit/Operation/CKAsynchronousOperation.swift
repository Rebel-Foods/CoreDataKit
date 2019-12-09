//
//  CKAsynchronousOperation.swift
//  CoreDatabaseKit
//
//  Created by Raghav Ahuja on 18/10/19.
//  Copyright © 2019 Raghav Ahuja. All rights reserved.
//

import Foundation

public class CKAsynchronousOperation: CKBaseOperation {
    
    func save(_ completion: @escaping (Result<Bool, NSError>) -> Void) {
        isCommitted = true
        
        let group = DispatchGroup()
        group.enter()
        
        context.saveContextAsync { (result) in
            completion(result)
            group.leave()
        }
        
        group.wait()
    }
}
