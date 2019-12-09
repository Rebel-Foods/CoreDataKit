//
//  CKQueryable.swift
//  CoreDatabaseKit
//
//  Created by Raghav Ahuja on 18/10/19.
//  Copyright © 2019 Raghav Ahuja. All rights reserved.
//

import Foundation
import CoreGraphics.CGGeometry

// MARK: - CKQueryable

public typealias CKEquatableQuery = CKQueryable & Equatable
public typealias CKComparableQuery = CKQueryable & Comparable

/**
 Types supported by CoreDatabase for querying, especially as generic type for `Fetch` clauses.
 Supported default types:
 - `Bool`
 - `CGFloat`
 - `Data`
 - `Date`
 - `Double`
 - `Float`
 - `Int`
 - `Int8`
 - `Int16`
 - `Int32`
 - `Int64`
 - `NSData`
 - `NSDate`
 - `NSDecimalNumber`
 - `NSManagedObjectID`
 - `NSNull`
 - `NSNumber`
 - `NSString`
 - `NSURL`
 - `NSUUID`
 - `String`
 - `URL`
 - `UUID`
 
 In addition, `RawRepresentable` types whose `RawValue` already implements `CKQueryable` only need to declare conformance to `CKQueryable`.
 */
public protocol CKQueryable: Hashable {
    
    /// The **CoreData Type** for this type when used in `Fetch` clauses.
    associatedtype CKQueryableType
    
    /// Creates an instance of this type from its `CKQueryableType` value.
    @inline(__always)
    static func ckNativeValue(from value: CKQueryableType) -> Self?
    
    /// Creates `QueryableNativeType` value from this instance.
    @inline(__always)
    var ckQueryableValue: CKQueryableType { get }
    
    @inline(__always)
    func ckEncode() throws -> Data
    
    @inline(__always)
    static func ckDecode(data: Data) throws -> Self
}

// MARK: - Bool

extension Bool: CKQueryable {
    
    public typealias CKQueryableType = NSNumber
    
    @inline(__always)
    public static func ckNativeValue(from value: CKQueryableType) -> Bool? {
        
        switch value {
            
        case let decimal as NSDecimalNumber:
            // iOS: NSDecimalNumber(string: "0.5").boolValue // true
            // macOS: NSDecimalNumber(string: "0.5").boolValue // false
            return decimal != NSDecimalNumber.zero
            
        default:
            return value.boolValue
        }
    }
    
    @inline(__always)
    public var ckQueryableValue: CKQueryableType {
        self as CKQueryableType
    }
    
    @inline(__always)
    public func ckEncode() throws -> Data {
        try JSONEncoder().encode(self)
    }
    
    @inline(__always)
    public static func ckDecode(data: Data) throws -> Self {
        try JSONDecoder().decode(Bool.self, from: data)
    }
}


// MARK: - CGFloat

extension CGFloat: CKQueryable {
    
    public typealias CKQueryableType = NSNumber
    
    @inline(__always)
    public static func ckNativeValue(from value: CKQueryableType) -> CGFloat? {
        CGFloat(value.doubleValue)
    }
    
    @inline(__always)
    public var ckQueryableValue: CKQueryableType {
        self as CKQueryableType
    }
    
    @inline(__always)
    public func ckEncode() throws -> Data {
        try JSONEncoder().encode(self)
    }
    
    @inline(__always)
    public static func ckDecode(data: Data) throws -> Self {
        try JSONDecoder().decode(CGFloat.self, from: data)
    }
}


// MARK: - Data

extension Data: CKQueryable {
    
    public typealias CKQueryableType = NSData
    
    @inline(__always)
    public static func ckNativeValue(from value: CKQueryableType) -> Data? {
        value as Data
    }
    
    @inline(__always)
    public var ckQueryableValue: CKQueryableType {
        self as CKQueryableType
    }
    
    @inline(__always)
    public func ckEncode() throws -> Data {
        self
    }
    
    @inline(__always)
    public static func ckDecode(data: Data) throws -> Self {
        data
    }
}


// MARK: - Date

extension Date: CKQueryable {
    
    public typealias CKQueryableType = NSDate
    
    @inline(__always)
    public static func ckNativeValue(from value: CKQueryableType) -> Date? {
        value as Date
    }
    
    @inline(__always)
    public var ckQueryableValue: CKQueryableType {
        self as NSDate
    }
    
    @inline(__always)
    public func ckEncode() throws -> Data {
        try JSONEncoder().encode(self)
    }
    
    @inline(__always)
    public static func ckDecode(data: Data) throws -> Self {
        try JSONDecoder().decode(Date.self, from: data)
    }
}


// MARK: - Double

extension Double: CKQueryable {
    
    public typealias CKQueryableType = NSNumber
    
    @inline(__always)
    public static func ckNativeValue(from value: CKQueryableType) -> Double? {
        value.doubleValue
    }
    
    @inline(__always)
    public var ckQueryableValue: CKQueryableType {
        self as NSNumber
    }
    
    @inline(__always)
    public func ckEncode() throws -> Data {
        try JSONEncoder().encode(self)
    }
    
    @inline(__always)
    public static func ckDecode(data: Data) throws -> Self {
        try JSONDecoder().decode(Self.self, from: data)
    }
}


// MARK: - Float

extension Float: CKQueryable {
    
    public typealias CKQueryableType = NSNumber
    
    @inline(__always)
    public static func ckNativeValue(from value: CKQueryableType) -> Float? {
        value.floatValue
    }
    
    @inline(__always)
    public var ckQueryableValue: CKQueryableType {
        self as NSNumber
    }
    
    @inline(__always)
    public func ckEncode() throws -> Data {
        try JSONEncoder().encode(self)
    }
    
    @inline(__always)
    public static func ckDecode(data: Data) throws -> Self {
        try JSONDecoder().decode(Self.self, from: data)
    }
}


// MARK: - Int

extension Int: CKQueryable {
    
    public typealias CKQueryableType = NSNumber
    
    @inline(__always)
    public static func ckNativeValue(from value: CKQueryableType) -> Int? {
        value.intValue
    }
    
    @inline(__always)
    public var ckQueryableValue: CKQueryableType {
        self as NSNumber
    }
    
    @inline(__always)
    public func ckEncode() throws -> Data {
        try JSONEncoder().encode(self)
    }
    
    @inline(__always)
    public static func ckDecode(data: Data) throws -> Self {
        try JSONDecoder().decode(Self.self, from: data)
    }
}


// MARK: - Int8

extension Int8: CKQueryable {
    
    public typealias CKQueryableType = NSNumber
    
    @inline(__always)
    public static func ckNativeValue(from value: CKQueryableType) -> Int8? {
        value.int8Value
    }
    
    @inline(__always)
    public var ckQueryableValue: CKQueryableType {
        self as NSNumber
    }
    
    @inline(__always)
    public func ckEncode() throws -> Data {
        try JSONEncoder().encode(self)
    }
    
    @inline(__always)
    public static func ckDecode(data: Data) throws -> Self {
        try JSONDecoder().decode(Self.self, from: data)
    }
}


// MARK: - Int16

extension Int16: CKQueryable {
    
    public typealias CKQueryableType = NSNumber
    
    @inline(__always)
    public static func ckNativeValue(from value: CKQueryableType) -> Int16? {
        value.int16Value
    }
    
    @inline(__always)
    public var ckQueryableValue: CKQueryableType {
        self as NSNumber
    }
    
    @inline(__always)
    public func ckEncode() throws -> Data {
        try JSONEncoder().encode(self)
    }
    
    @inline(__always)
    public static func ckDecode(data: Data) throws -> Self {
        try JSONDecoder().decode(Self.self, from: data)
    }
}


// MARK: - Int32

extension Int32: CKQueryable {
    
    public typealias CKQueryableType = NSNumber
    
    @inline(__always)
    public static func ckNativeValue(from value: CKQueryableType) -> Int32? {
        value.int32Value
    }
    
    @inline(__always)
    public var ckQueryableValue: CKQueryableType {
        self as NSNumber
    }
    
    @inline(__always)
    public func ckEncode() throws -> Data {
        try JSONEncoder().encode(self)
    }
    
    @inline(__always)
    public static func ckDecode(data: Data) throws -> Self {
        try JSONDecoder().decode(Self.self, from: data)
    }
}


// MARK: - Int64

extension Int64: CKQueryable {
    
    public typealias CKQueryableType = NSNumber
    
    @inline(__always)
    public static func ckNativeValue(from value: CKQueryableType) -> Int64? {
        value.int64Value
    }
    
    @inline(__always)
    public var ckQueryableValue: CKQueryableType {
        self as NSNumber
    }
    
    @inline(__always)
    public func ckEncode() throws -> Data {
        try JSONEncoder().encode(self)
    }
    
    @inline(__always)
    public static func ckDecode(data: Data) throws -> Self {
        try JSONDecoder().decode(Self.self, from: data)
    }
}


// MARK: - NSData

extension NSData: CKQueryable {
    
    public typealias CKQueryableType = NSData
    
    @nonobjc @inline(__always)
    public class func ckNativeValue(from value: CKQueryableType) -> Self? {
        
        func forceCast<T: NSData>(_ value: Any) -> T? {
             value as? T
        }
        
        return forceCast(value)
    }
    
    @nonobjc @inline(__always)
    public var ckQueryableValue: CKQueryableType {
        self
    }
    
    @inline(__always)
    public func ckEncode() throws -> Data {
        self as Data
    }
    
    @inline(__always)
    public class func ckDecode(data: Data) throws -> Self {
        self.init(data: data)
    }
}


// MARK: - NSDate

extension NSDate: CKQueryable {
    
    public typealias CKQueryableType = NSDate
    
    @nonobjc @inline(__always)
    public class func ckNativeValue(from value: CKQueryableType) -> Self? {
        
        func forceCast<T: NSDate>(_ value: Any) -> T? {
             value as? T
        }
        
        return forceCast(value)
    }
    
    @nonobjc @inline(__always)
    public var ckQueryableValue: CKQueryableType {
        self
    }
    
    @inline(__always)
    public func ckEncode() throws -> Data {
        try JSONEncoder().encode(self as Date)
    }
    
    @inline(__always)
    public class func ckDecode(data: Data) throws -> Self {
        let date = try JSONDecoder().decode(Date.self, from: data)
        return self.init(timeIntervalSince1970: date.timeIntervalSince1970)
    }
}


// MARK: - NSManagedObjectID

extension CKObjectId: CKQueryable {
    
    
    public typealias CKQueryableType = CKObjectId
    
    @nonobjc @inline(__always)
    public class func ckNativeValue(from value: CKQueryableType) -> Self? {
        
        func forceCast<T: CKObjectId>(_ value: Any) -> T? {
             value as? T
        }
        
        return forceCast(value)
    }
    
    @nonobjc @inline(__always)
    public var ckQueryableValue: CKQueryableType {
        self
    }
    
    @inline(__always)
    public func ckEncode() throws -> Data {
        NSKeyedArchiver.archivedData(withRootObject: self)
    }
    
    @inline(__always)
    public class func ckDecode(data: Data) throws -> Self {
        let object = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data)
        return object as! Self
    }
}


// MARK: - NSNull

extension NSNull: CKQueryable {
    
    public typealias CKQueryableType = NSNull
    
    @nonobjc @inline(__always)
    public class func ckNativeValue(from value: CKQueryableType) -> Self? {
        
        func forceCast<T: NSNull>(_ value: Any) -> T? {
             value as? T
        }
        
        return forceCast(value)
    }
    
    @nonobjc @inline(__always)
    public var ckQueryableValue: CKQueryableType {
        self
    }
    
    @inline(__always)
    public func ckEncode() throws -> Data {
        NSKeyedArchiver.archivedData(withRootObject: self)
    }
    
    @inline(__always)
    public class func ckDecode(data: Data) throws -> Self {
        let object = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data)
        return object as! Self
    }
}


// MARK: - NSNumber

extension NSNumber: CKQueryable {
    
    public typealias CKQueryableType = NSNumber
    
    @nonobjc @inline(__always)
    public class func ckNativeValue(from value: CKQueryableType) -> Self? {
        
        func forceCast<T: NSNumber>(_ value: Any) -> T? {
             value as? T
        }
        
        return forceCast(value)
    }
    
    @nonobjc @inline(__always)
    public var ckQueryableValue: CKQueryableType {
        self
    }
    
    @inline(__always)
    public func ckEncode() throws -> Data {
        NSKeyedArchiver.archivedData(withRootObject: self)
    }
    
    @inline(__always)
    public class func ckDecode(data: Data) throws -> Self {
        let object = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data)
        return object as! Self
    }
}


// MARK: - NSString

extension NSString: CKQueryable {
    
    public typealias CKQueryableType = NSString
    
    @nonobjc @inline(__always)
    public class func ckNativeValue(from value: CKQueryableType) -> Self? {
        
        func forceCast<T: NSString>(_ value: Any) -> T? {
            value as? T
        }
        
        return forceCast(value)
    }
    
    @nonobjc @inline(__always)
    public var ckQueryableValue: CKQueryableType {
        self
    }
    
    @inline(__always)
    public func ckEncode() throws -> Data {
        try JSONEncoder().encode(self as String)
    }
    
    @inline(__always)
    public class func ckDecode(data: Data) throws -> Self {
        let string = try JSONDecoder().decode(String.self, from: data)
        return self.init(string: string)
    }
}


// MARK: - NSURL

extension NSURL: CKQueryable {
    
    public typealias CKQueryableType = NSString
    
    @nonobjc @inline(__always)
    public class func ckNativeValue(from value: CKQueryableType) -> Self? {
        self.init(string: value as String)
    }
    
    @nonobjc @inline(__always)
    public var ckQueryableValue: CKQueryableType {
        (self as URL).absoluteString as CKQueryableType
    }
    
    @inline(__always)
    public func ckEncode() throws -> Data {
        try JSONEncoder().encode(self as URL)
    }
    
    @inline(__always)
    public class func ckDecode(data: Data) throws -> Self {
        let url = try JSONDecoder().decode(URL.self, from: data)
        return self.init(string: url.absoluteString)!
    }
}


// MARK: - NSUUID

extension NSUUID: CKQueryable {
    
    public typealias CKQueryableType = NSString
    
    @nonobjc @inline(__always)
    public class func ckNativeValue(from value: CKQueryableType) -> Self? {
        self.init(uuidString: value.lowercased)
    }
    
    @nonobjc @inline(__always)
    public var ckQueryableValue: CKQueryableType {
        uuidString.lowercased() as CKQueryableType
    }
    
    @inline(__always)
    public func ckEncode() throws -> Data {
        try JSONEncoder().encode(self.uuidString)
    }
    
    @inline(__always)
    public class func ckDecode(data: Data) throws -> Self {
        let string = try JSONDecoder().decode(String.self, from: data)
        return self.init(uuidString: string)!
    }
}


// MARK: - String

extension String: CKQueryable {
    
    public typealias CKQueryableType = NSString
    
    @inline(__always)
    public static func ckNativeValue(from value: CKQueryableType) -> Self? {
        value as String
    }
    
    @inline(__always)
    public var ckQueryableValue: CKQueryableType {
        self as CKQueryableType
    }
    
    @inline(__always)
    public func ckEncode() throws -> Data {
        try JSONEncoder().encode(self)
    }
    
    @inline(__always)
    public static func ckDecode(data: Data) throws -> Self {
        try JSONDecoder().decode(Self.self, from: data)
    }
}


// MARK: - URL

extension URL: CKQueryable {
    
    public typealias CKQueryableType = NSString
    
    @inline(__always)
    public static func ckNativeValue(from value: CKQueryableType) -> Self? {
        self.init(string: value as String)
    }
    
    @inline(__always)
    public var ckQueryableValue: CKQueryableType {
        absoluteString as CKQueryableType
    }
    
    @inline(__always)
    public func ckEncode() throws -> Data {
        try JSONEncoder().encode(self)
    }
    
    @inline(__always)
    public static func ckDecode(data: Data) throws -> Self {
        try JSONDecoder().decode(Self.self, from: data)
    }
}


// MARK: - UUID

extension UUID: CKQueryable {
    
    public typealias CKQueryableType = NSString
    
    @inline(__always)
    public static func ckNativeValue(from value: CKQueryableType) -> Self? {
        self.init(uuidString: value.lowercased)
    }
    
    @inline(__always)
    public var ckQueryableValue: CKQueryableType {
        uuidString.lowercased() as CKQueryableType
    }
    
    @inline(__always)
    public func ckEncode() throws -> Data {
        try JSONEncoder().encode(self.uuidString)
    }
    
    @inline(__always)
    public static func ckDecode(data: Data) throws -> Self {
        let string = try JSONDecoder().decode(String.self, from: data)
        return self.init(uuidString: string)!
    }
}


// MARK: - RawRepresentable

extension RawRepresentable where RawValue: CKQueryable {
    
    public typealias QueryableType = RawValue.CKQueryableType
    
    @inline(__always)
    public static func nativeValue(from value: QueryableType) -> Self? {
        RawValue.ckNativeValue(from: value).flatMap { self.init(rawValue: $0) }
    }
    
    @inline(__always)
    public var ckQueryableValue: QueryableType {
        rawValue.ckQueryableValue
    }
    
    @inline(__always)
    public func ckEncode() throws -> Data {
        try rawValue.ckEncode()
    }
    
    @inline(__always)
    public static func ckDecode(data: Data) throws -> Self {
        let value = try RawValue.ckDecode(data: data)
        return self.init(rawValue: value)!
    }
}
