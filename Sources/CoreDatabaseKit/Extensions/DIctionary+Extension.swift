//
//  Dictionary+Extension.swift
//  CoreDatabaseKit
//
//  Created by Raghav Ahuja on 18/10/19.
//  Copyright © 2019 Raghav Ahuja. All rights reserved.
//


import Foundation

extension Dictionary {
    
    var prettyPrint: String {
        var printString = "["
        
        for (key, value) in self {
            let itemString = "\n\t\(key): \(value),"
            printString.append(itemString)
        }
        
        let postfix = isEmpty ? " " : "\n"
        printString.append("\(postfix)]")
        
        return printString
    }
}
