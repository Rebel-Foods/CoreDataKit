//
//  CKObject+Extension.swift
//  CoreDataKit
//
//  Created by Raghav Ahuja on 18/10/19.
//  Copyright © 2019 Raghav Ahuja. All rights reserved.
//

import Foundation

extension CKObject {
    
    class func classType<T: AnyObject>(of instance: T) -> T.Type {
        object_getClass(instance) as! T.Type
    }
    
    class func downcast(object: CKObject) -> Self {
        unsafeDowncast(object, to: self)
    }
}
