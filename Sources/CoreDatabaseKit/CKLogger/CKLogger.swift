//
//  CKLogger.swift
//  CoreDatabaseKit
//
//  Created by Raghav Ahuja on 18/10/19.
//  Copyright © 2019 Raghav Ahuja. All rights reserved.
//

import Foundation

class CKLogger {
    
    /**
     Creates a `CKLogger`.
     */
    public init() { }
    
    /**
     Handles errors sent by the `CoreDatabaseKit`.
     
     - parameter error: Error occurred.
     - parameter file: Source file name.
     - parameter line: Source line number.
     - parameter function: Source function name.
     */
    public func log(error: CKError, file: StaticString = #file, line: UInt = #line, function: StaticString = #function) {
        
        #if DEBUG
        Swift.print("⚠️ [CoreDatabaseKit: Error] \((String(describing: file) as NSString).lastPathComponent):\(line) \(function)\n  ↪︎ \(error)\n")
        #endif
    }
    
    /**
     Handles assertions made throughout the `CoreDatabaseKit`.
     
     - parameter condition: Assertion condition.
     - parameter message: Assertion failure message.
     - parameter file: Source file name.
     - parameter line: Source line number.
     - parameter function: Source function name.
     */
    public func assert(_ condition: @autoclosure () -> Bool, _ message: @autoclosure () -> String, file: StaticString = #file, line: UInt = #line, function: StaticString = #function) {
        
        #if DEBUG
        
        let condition = condition()
        
        if condition { return }
        
        let message = message()
        
        Swift.print("❗ [CoreDatabaseKit: Assertion Failure] \((String(describing: file) as NSString).lastPathComponent):\(line) \(function)\n  ↪︎ \(message)\n")
        Swift.assert(condition, message, file: file, line: line)
        #endif
    }
    
    /**
     Handles preconditions made throughout the `CoreDatabaseKit`.
     
     - parameter condition: Precondition to be satisfied.
     - parameter message: Precondition failure message.
     - parameter file: Source file name.
     - parameter line: Source line number.
     - parameter function: Source function name.
     */
    public func precondition(_ condition: @autoclosure () -> Bool, _ message: @autoclosure () -> String, file: StaticString = #file, line: UInt = #line, function: StaticString = #function) {
        
        let condition = condition()
        
        if condition { return }
        
        let message = message()
        
        Swift.print("❗ [CoreDatabaseKit: Precondition Failure] \((String(describing: file) as NSString).lastPathComponent):\(line) \(function)\n  ↪︎ \(message)\n")
        Swift.preconditionFailure(message, file: file, line: line)
    }
    
    /**
     Handles fatal errors made throughout the `CoreDatabaseKit`.
     - Important: Implementers should guarantee that this function doesn't return, either by calling another `Never` function such as `fatalError()` or `abort()`, or by raising an exception.
     
     - parameter message: Fatal error message.
     - parameter file: Source file name.
     - parameter line: Source line number.
     - parameter function: Source function name.
     */
    public func fatalError(_ message: @autoclosure () -> String, file: StaticString = #file, line: UInt = #line, function: StaticString = #function) -> Never {
        
        let message = message()
        Swift.print("❗ [CoreDatabaseKit: Fatal Error] \((String(describing: file) as NSString).lastPathComponent):\(line) \(function)\n  ↪︎ \(message)\n")
        Swift.fatalError(message, file: file, line: line)
    }
}

