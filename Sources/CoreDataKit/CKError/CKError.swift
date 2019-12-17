//
//  CKError.swift
//  CoreDataKit
//
//  Created by Raghav Ahuja on 18/10/19.
//  Copyright © 2019 Raghav Ahuja. All rights reserved.
//

import Foundation

public struct CKError: CustomNSError {
    
    public static var errorDomain: String { "CKErrorDomain" }
    
    private let code: Int
    public var errorCode: Int { code }
    
    private let userInfo: [String: Any]
    public var errorUserInfo: [String: Any] { userInfo }
    
    public init(errorCode: Int, localizedDescription: String) {
        code = errorCode
        userInfo = [NSLocalizedDescriptionKey: localizedDescription]
    }
    
    public init(errorCode: Int, userInfo info: [String : Any]) {
        code = errorCode
        userInfo = info
    }
    
    init(_ nsError: NSError) {
        code = nsError.code
        userInfo = nsError.userInfo
    }
}

extension CKError: CustomStringConvertible, CustomDebugStringConvertible {
    
    /// A textual representation of this instance.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(describing:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `description` property for types that conform to
    /// `CustomStringConvertible`:
    ///
    ///     struct Point: CustomStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var description: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(describing: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `description` property.
    public var description: String {
        "⚠️ [CoreDataKit: CKError] Code = \(errorCode) \"\(errorUserInfo[NSLocalizedDescriptionKey] ?? "")\" UserInfo = \(errorUserInfo.prettyPrint)"
    }
    
    /// A textual representation of this instance, suitable for debugging.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(reflecting:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `debugDescription` property for types that conform to
    /// `CustomDebugStringConvertible`:
    ///
    ///     struct Point: CustomDebugStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var debugDescription: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(reflecting: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `debugDescription` property.
    public var debugDescription: String {
        "⚠️ [CoreDataKit: CKError] Code = \(errorCode) \"\(errorUserInfo[NSLocalizedDescriptionKey] ?? "")\" UserInfo = \(errorUserInfo.prettyPrint)"
    }
}
