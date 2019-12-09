//
//  CoreDatabaseKit.swift
//  CoreDatabaseKit
//
//  Created by Raghav Ahuja on 18/10/19.
//  Copyright © 2019 Raghav Ahuja. All rights reserved.
//

import Foundation

public final class CoreDatabaseKit {
    
    public static let `default` = CoreDatabaseKit()
    
    public let stack: CoreDataStack
    
    public var enableLogging: Bool {
        get {
            logger.isEnabled
        } set {
            logger.isEnabled = newValue
        }
    }
    
    private let queue: DispatchQueue
    
    let logger: CKLogger
    
    public init(databaseName: String) {
        stack = CoreDataStack(databaseName: databaseName)
        queue = DispatchQueue(label: "com.CoreDatabaseKit.contextQueue", qos: .default,
                              attributes: [], autoreleaseFrequency: .inherit, target: nil)
        logger = CKLogger(isEnabled: true)
    }
    
    public convenience init() {
        let databaseName = Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String ?? "Database"
        self.init(databaseName: databaseName)
    }
}

public extension CoreDatabaseKit {
    
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

extension CoreDatabaseKit: FetchClause {
    
    public func fetch<Object>(_ request: CKFetch<Object>) throws -> [Object] where Object : CKObject {
        try stack.viewContext.fetch(request)
    }
    
    public func fetchFirst<Object>(_ request: CKFetch<Object>) throws -> Object? where Object : CKObject {
        try stack.viewContext.fetchFirst(request)
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
        try stack.viewContext.fetchIds(request)
    }
    
    public func query<Object>(_ request: CKFetch<Object>) throws -> [NSDictionary] where Object : CKObject {
        try stack.viewContext.query(request)
    }
    
    public func count<Object>(_ request: CKFetch<Object>) throws -> Int where Object : CKObject {
        try stack.viewContext.count(request)
    }
    
    public var unsafeContext: CKContext {
        stack.viewContext
    }
}
