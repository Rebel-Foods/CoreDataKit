//
//  DisptachQueue+Extension.swift
//  CoreDatabaseKit
//
//  Created by Raghav Ahuja on 18/10/19.
//  Copyright © 2019 Raghav Ahuja. All rights reserved.
//

import Foundation

extension DispatchQueue {
    
    func isCurrentExecutionContext() -> Bool {
        enum Static {
            static let specificKey = DispatchSpecificKey<ObjectIdentifier>()
        }
        
        let specific = ObjectIdentifier(self)
        
        setSpecific(key: Static.specificKey, value: specific)
        return DispatchQueue.getSpecific(key: Static.specificKey) == specific
    }
}
