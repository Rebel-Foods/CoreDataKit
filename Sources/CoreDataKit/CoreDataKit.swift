//
//  CoreDataKit.swift
//  CoreDataKit
//
//  Created by Raghav Ahuja on 18/10/19.
//  Copyright © 2019 Raghav Ahuja. All rights reserved.
//

import Foundation

public final class CoreDataKit {
    
    /// The default instance with database name being application's name.
    public static let `default` = CoreDataKit()
    
    /// Core Data Stack associated with this instance.
    public let stack: CoreDataStack
    
    /// Allows the `CoreDataKit` to log errors and other information in the debug console.
    public var enableLogging: Bool {
        get {
            logger.isEnabled
        } set {
            logger.isEnabled = newValue
        }
    }
    
    private let queue: DispatchQueue
    
    let logger: CKLogger
    
    /// Intializes an instance of `CoreDataKit` with the given database name.
    /// - Parameter databaseName: Database name.
    public init(databaseName: String) {
        stack = CoreDataStack(databaseName: databaseName)
        queue = DispatchQueue(label: "com.CoreDataKit.contextQueue", qos: .default,
                              attributes: [], autoreleaseFrequency: .inherit, target: nil)
        logger = CKLogger(isEnabled: true)
    }
    
    public convenience init() {
        let databaseName = Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String ?? "Database"
        self.init(databaseName: databaseName)
    }
}

public extension CoreDataKit {
    
    /// <#Description#>
    /// - Parameter workItem: <#workItem description#>
    /// - Throws:
    /// - Returns:
    func perform<T>(synchronous workItem: (CKSynchronousOperation) throws -> T) throws -> T {
        let operation = CKSynchronousOperation(context: stack.newBackgroundTask(), queue: queue, logger: logger)

        return try operation.queue.sync {

            defer {
                withExtendedLifetime((self, operation), {})
            }

            let output: T

            do {
                output = try workItem(operation)//withoutActuallyEscaping(workItem, do: { try $0(operation) })
            }
            catch let error as NSError {
                throw error
            }
            if let error = operation.save().getError() {
                throw error as NSError
            }
            else {
                return output
            }
        }
    }
    
    func perform<T>(asynchronous workItem: @escaping (CKAsynchronousOperation) throws -> T, completion: @escaping (Result<T, NSError>) -> Void) {
        let operation = CKAsynchronousOperation(context: stack.newBackgroundTask(), queue: queue, logger: logger)

        operation.queue.async {

            let output: T

            do {
                output = try workItem(operation)
            }
            catch let error as NSError {
                DispatchQueue.main.async { completion(.failure(error)) }
                return
            }

            operation.save { (result) in
                defer {
                    withExtendedLifetime((self, operation), {})
                }

                switch result {
                case .success(let success):
                    if success {
                        completion(.success(output))
                    } else {
                        DispatchQueue.main.async { completion(.failure(NSError(domain: NSCocoaErrorDomain, code: 0101, userInfo: nil))) }
                    }

                case .failure(let error):
                    DispatchQueue.main.async { completion(.failure(error)) }
                }
            }
        }
    }
}

extension CoreDataKit: FetchClause {
    
    public func fetch<Object>(_ request: CKFetch<Object>) throws -> [Object] where Object : CKObject {
        precondition()
        
        return try stack.viewContext.fetch(request)
    }
    
    public func fetchFirst<Object>(_ request: CKFetch<Object>) throws -> Object? where Object : CKObject {
        precondition()
        
        return try stack.viewContext.fetchFirst(request)
    }
    
    public func fetchExisting<Object>(_ object: Object) -> Object? where Object : CKObject {
        stack.viewContext.fetchExisting(object)
    }
    
    public func fetchExisting<Object>(with objectId: CKObjectId) -> Object? where Object : CKObject {
        stack.viewContext.fetchExisting(with: objectId)
    }
    
    public func fetchExisting<Object, S>(_ objects: S) -> [Object] where Object : CKObject, Object == S.Element, S : Sequence {
        stack.viewContext.fetchExisting(objects)
    }
    
    public func fetchExisting<Object, S>(_ objectIds: S) -> [Object] where Object : CKObject, S : Sequence, S.Element == CKObjectId {
        stack.viewContext.fetchExisting(objectIds)
    }
    
    public func fetchIds<Object>(_ request: CKFetch<Object>) throws -> [CKObjectId] where Object : CKObject {
        precondition()
        
        return try stack.viewContext.fetchIds(request)
    }
    
    public func query<Object>(_ request: CKFetch<Object>) throws -> [NSDictionary] where Object : CKObject {
        precondition()
        
        return try stack.viewContext.query(request)
    }
    
    public func count<Object>(for request: CKFetch<Object>) throws -> Int where Object : CKObject {
        precondition()
        
        return try stack.viewContext.count(for: request)
    }
    
    public var unsafeContext: CKContext {
        stack.viewContext
    }
}

// MARK: LOGGING
private extension CoreDataKit {
    
    func precondition(file: StaticString = #file, line: UInt = #line, function: StaticString = #function) {
        logger.assert(
            Thread.isMainThread,
            "Attempted to fetch from a \(logger.typeName(self)) outside the main thread.",
            file: file,
            line: line,
            function: function
        )
    }
}
