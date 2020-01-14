//
//  Queryable.swift
//  CoreDataKit
//
//  Created by Raghav Ahuja on 18/10/19.
//  Copyright © 2019 Raghav Ahuja. All rights reserved.
//

import Foundation
#if canImport(UIKit)
import CoreGraphics.CGGeometry
#endif

// MARK: - CKQueryable

public typealias CKEquatableQuery = CKQueryable & Equatable
public typealias CKComparableQuery = CKQueryable & Comparable

/**
 Types supported by `CoreDataKit` for querying, especially as generic type for `Fetch` clauses.
 Supported default types:
 - `Bool`
 - `CGFloat`
 - `Float`
 - `Double`
 - `UInt`
 - `UInt8`
 - `UInt16`
 - `UInt32`
 - `UInt64`
 - `Int`
 - `Int8`
 - `Int16`
 - `Int32`
 - `Int64`
 - `NSNumber`
 - `String`
 - `NSString`
 - `Data`
 - `NSData`
 - `Date`
 - `NSDate`
 - `UUID`
 - `NSUUID`
 - `URL`
 - `NSURL`
 - `CKObjectId`
 - `NSNull`
 
 In addition, `RawRepresentable` types whose `RawValue` already implements `CKQueryable` only need to declare conformance to `CKQueryable`.
 */
public protocol CKQueryable: Hashable {
    
    /// The **CoreData Type** for this type when used in `Fetch` clauses.
    associatedtype CKQueryableType
    
    /// Creates an instance of this type from its `CKQueryableType` value.
    @inline(__always)
    static func ckValue(from value: CKQueryableType) -> Self?
    
    /// Creates `CKQueryableType` value from this instance.
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
    public static func ckValue(from value: CKQueryableType) -> Bool? {
        
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
    public static func ckValue(from value: CKQueryableType) -> CGFloat? {
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


// MARK: - Float

extension Float: CKQueryable {
    
    public typealias CKQueryableType = NSNumber
    
    @inline(__always)
    public static func ckValue(from value: CKQueryableType) -> Float? {
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


// MARK: - Double

extension Double: CKQueryable {
    
    public typealias CKQueryableType = NSNumber
    
    @inline(__always)
    public static func ckValue(from value: CKQueryableType) -> Double? {
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

// MARK: - UInt

extension UInt: CKQueryable {
    
    public typealias CKQueryableType = NSNumber
    
    @inline(__always)
    public static func ckValue(from value: CKQueryableType) -> UInt? {
        value.uintValue
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


// MARK: - UInt8

extension UInt8: CKQueryable {
    
    public typealias CKQueryableType = NSNumber
    
    @inline(__always)
    public static func ckValue(from value: CKQueryableType) -> UInt8? {
        value.uint8Value
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


// MARK: - UInt16

extension UInt16: CKQueryable {
    
    public typealias CKQueryableType = NSNumber
    
    @inline(__always)
    public static func ckValue(from value: CKQueryableType) -> UInt16? {
        value.uint16Value
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


// MARK: - UInt32

extension UInt32: CKQueryable {
    
    public typealias CKQueryableType = NSNumber
    
    @inline(__always)
    public static func ckValue(from value: CKQueryableType) -> UInt32? {
        value.uint32Value
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


// MARK: - UInt64

extension UInt64: CKQueryable {
    
    public typealias CKQueryableType = NSNumber
    
    @inline(__always)
    public static func ckValue(from value: CKQueryableType) -> UInt64? {
        value.uint64Value
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
    public static func ckValue(from value: CKQueryableType) -> Int? {
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
    public static func ckValue(from value: CKQueryableType) -> Int8? {
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
    public static func ckValue(from value: CKQueryableType) -> Int16? {
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
    public static func ckValue(from value: CKQueryableType) -> Int32? {
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
    public static func ckValue(from value: CKQueryableType) -> Int64? {
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


// MARK: - NSNumber

extension NSNumber: CKQueryable {
    
    public typealias CKQueryableType = NSNumber
    
    @nonobjc @inline(__always)
    public class func ckValue(from value: CKQueryableType) -> Self? {
        value as? Self
    }
    
    @nonobjc @inline(__always)
    public var ckQueryableValue: CKQueryableType {
        self
    }
    
    @inline(__always)
    public func ckEncode() throws -> Data {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *) {
            let data = try NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
            return data
        } else {
            let data = NSKeyedArchiver.archivedData(withRootObject: self)
            return data
        }
    }
    
    @inline(__always)
    public class func ckDecode(data: Data) throws -> Self {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *) {
            guard let object = try NSKeyedUnarchiver.unarchivedObject(ofClass: Self.self, from: data) else {
                throw NSError.cannotDecode
            }
            return object
        } else {
            guard let object = NSKeyedUnarchiver.unarchiveObject(with: data) as? Self else {
                throw NSError.cannotDecode
            }
            return object
        }
    }
}


// MARK: - String

extension String: CKQueryable {
    
    public typealias CKQueryableType = NSString
    
    @inline(__always)
    public static func ckValue(from value: CKQueryableType) -> Self? {
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


// MARK: - NSString

extension NSString: CKQueryable {
    
    public typealias CKQueryableType = NSString
    
    @nonobjc @inline(__always)
    public class func ckValue(from value: CKQueryableType) -> Self? {
        value as? Self
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


// MARK: - Data

extension Data: CKQueryable {
    
    public typealias CKQueryableType = NSData
    
    @inline(__always)
    public static func ckValue(from value: CKQueryableType) -> Data? {
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


// MARK: - NSData

extension NSData: CKQueryable {
    
    public typealias CKQueryableType = NSData
    
    @nonobjc @inline(__always)
    public class func ckValue(from value: CKQueryableType) -> Self? {
        value as? Self
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


// MARK: - Date

extension Date: CKQueryable {
    
    public typealias CKQueryableType = NSDate
    
    @inline(__always)
    public static func ckValue(from value: CKQueryableType) -> Date? {
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


// MARK: - NSDate

extension NSDate: CKQueryable {
    
    public typealias CKQueryableType = NSDate
    
    @nonobjc @inline(__always)
    public class func ckValue(from value: CKQueryableType) -> Self? {
        value as? Self
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


// MARK: - URL

extension URL: CKQueryable {
    
    public typealias CKQueryableType = NSString
    
    @inline(__always)
    public static func ckValue(from value: CKQueryableType) -> Self? {
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


// MARK: - NSURL

extension NSURL: CKQueryable {
    
    public typealias CKQueryableType = NSString
    
    @nonobjc @inline(__always)
    public class func ckValue(from value: CKQueryableType) -> Self? {
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


// MARK: - UUID

extension UUID: CKQueryable {
    
    public typealias CKQueryableType = NSString
    
    @inline(__always)
    public static func ckValue(from value: CKQueryableType) -> Self? {
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


// MARK: - NSUUID

extension NSUUID: CKQueryable {
    
    public typealias CKQueryableType = NSString
    
    @nonobjc @inline(__always)
    public class func ckValue(from value: CKQueryableType) -> Self? {
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


// MARK: - CKObjectId

extension CKObjectId: CKQueryable {
    
    public typealias CKQueryableType = CKObjectId
    
    @nonobjc @inline(__always)
    public class func ckValue(from value: CKQueryableType) -> Self? {
        value as? Self
    }
    
    @nonobjc @inline(__always)
    public var ckQueryableValue: CKQueryableType {
        self
    }
    
    @inline(__always)
    public func ckEncode() throws -> Data {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *) {
            let data = try NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
            return data
        } else {
            let data = NSKeyedArchiver.archivedData(withRootObject: self)
            return data
        }
    }
    
    @inline(__always)
    public class func ckDecode(data: Data) throws -> Self {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *) {
            guard let object = try NSKeyedUnarchiver.unarchivedObject(ofClasses: [Self.self], from: data) as? Self else {
                throw NSError.cannotDecode
            }
            return object
        } else {
            guard let object = NSKeyedUnarchiver.unarchiveObject(with: data) as? Self else {
                throw NSError.cannotDecode
            }
            return object
        }
    }
}


// MARK: - NSNull

extension NSNull: CKQueryable {
    
    public typealias CKQueryableType = NSNull
    
    @nonobjc @inline(__always)
    public class func ckValue(from value: CKQueryableType) -> Self? {
        value as? Self
    }
    
    @nonobjc @inline(__always)
    public var ckQueryableValue: CKQueryableType {
        self
    }
    
    @inline(__always)
    public func ckEncode() throws -> Data {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *) {
            let data = try NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
            return data
        } else {
            let data = NSKeyedArchiver.archivedData(withRootObject: self)
            return data
        }
    }
    
    @inline(__always)
    public class func ckDecode(data: Data) throws -> Self {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *) {
            guard let object = try NSKeyedUnarchiver.unarchivedObject(ofClass: Self.self, from: data) else {
                throw NSError.cannotDecode
            }
            return object
        } else {
            guard let object = NSKeyedUnarchiver.unarchiveObject(with: data) as? Self else {
                throw NSError.cannotDecode
            }
            return object
        }
    }
}


// MARK: - RawRepresentable

extension RawRepresentable where RawValue: CKQueryable {
    
    public typealias QueryableType = RawValue.CKQueryableType
    
    @inline(__always)
    public static func nativeValue(from value: QueryableType) -> Self? {
        RawValue.ckValue(from: value).flatMap { self.init(rawValue: $0) }
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
