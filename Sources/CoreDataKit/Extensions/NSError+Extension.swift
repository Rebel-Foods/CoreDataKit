//
//  File.swift
//  
//
//  Created by Raghav Ahuja on 14/01/20.
//

import Foundation

extension NSError {
    static var errorDomain = "CKErrorDomain"
    
    static var cannotDecode = NSError(domain: errorDomain, code: NSURLErrorCannotParseResponse, userInfo: [NSLocalizedDescriptionKey : "Nil value for this object."])
}
