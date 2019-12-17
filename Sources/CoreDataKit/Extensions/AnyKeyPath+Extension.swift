//
//  AnyKeyPath+Extension.swift
//  CoreDataKit
//
//  Created by Raghav Ahuja on 18/10/19.
//  Copyright © 2019 Raghav Ahuja. All rights reserved.
//

import Foundation

extension AnyKeyPath {
    
    var objcStringValue: String {
        _objcStringValue!
    }
    
    var _objcStringValue: String? {
        _kvcKeyPathString
    }
}
