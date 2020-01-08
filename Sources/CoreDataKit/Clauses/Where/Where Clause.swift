//
//  Where Clause.swift
//  CoreDataKit
//
//  Created by Raghav Ahuja on 18/10/19.
//  Copyright © 2019 Raghav Ahuja. All rights reserved.
//

import Foundation

public protocol WhereClause {
    
    associatedtype Object: CKObject
    
    // MARK: WHERE CLAUSE
    
    /// Initializes a predicate by substituting the values in a given array into a format string and parsing the result.
    /// - Parameter format: The format string for the new predicate.
    /// - Parameter args: The arguments to substitute into predicateFormat. Values are substituted in the order they appear in the array.
    func `where`(_ format: String, args: CVarArg...) -> Self
    
    /// Creates and returns a predicate that always evaluates to a given Boolean value.
    /// - Parameter value: The Boolean value to which the new predicate should evaluate.
    func `where`(_ value: Bool) -> Self
    
    /// Initializes a predicate by substituting the values in a given array into a format string and parsing the result.
    /// - Parameter format: The format string for the new predicate.
    /// - Parameter args: The arguments to substitute into predicateFormat. Values are substituted in the order they appear in the array.
    func `where`(_ format: String, argumentArray: [Any]?) -> Self
    
    /// The predicate of the fetch request.
    /// - Parameter predicate: The predicate instance constrains the selection of objects the `FetchRequest` instance is to fetch.
    func `where`(_ predicate: CKPredicate?) -> Self
    
    /// The predicate of the fetch request.
    /// - Parameter clause: `Where` clause to create a `FetchRequest` with.
    func `where`(_ clause: Where<Object>) -> Self
}
