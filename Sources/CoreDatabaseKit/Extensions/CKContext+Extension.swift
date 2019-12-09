//
//  CKContext+Extension.swift
//  CoreDatabaseKit
//
//  Created by Raghav Ahuja on 18/10/19.
//  Copyright © 2019 Raghav Ahuja. All rights reserved.
//

import Foundation

extension CKContext: FetchClause {
    
    public func fetch<Object>(_ request: CKFetch<Object>) throws -> [Object] where Object : CKObject {
        let fetchRequest = request.fetchRequest//format(to: Object.self)
        
        var objects: [Object] = []
        var error: NSError?
        
        performAndWait {
            do {
                objects = try fetch(fetchRequest) as! [Object]
            } catch let fetchError as NSError {
                error = fetchError
            }
        }
        
        if let fetchError = error {
            throw fetchError
        } else {
            return objects
        }
    }
    
    public func fetchFirst<Object>(_ request: CKFetch<Object>) throws -> Object? where Object : CKObject {
        let objects = try fetch(request)
        return objects.first
    }
    
    public func fetchExisting<Object>(with objectId: CKObjectId) -> Object? where Object : CKObject {
        do {
            let object = try existingObject(with: objectId)
            return unsafeDowncast(object, to: Object.self)
        } catch {
            return nil
        }
    }
    
    public func fetchExisting<Object>(_ object: Object) -> Object? where Object : CKObject {
        if object.objectID.isTemporaryID {
            do {
                try withExtendedLifetime(self) { (context: CKContext) -> Void in
                    try context.obtainPermanentIDs(for: [object])
                }
            }
            catch {
                return nil
            }
        }
        do {
            let existingObject = try self.existingObject(with: object.objectID)
            if existingObject === object {
                return object
            }
            return Object.classType(of: object).downcast(object: existingObject)
        }
        catch {
            return nil
        }
    }
    
    public func fetchExisting<Object, S>(_ objects: S) -> [Object] where Object : CKObject, Object == S.Element, S : Sequence {
        objects.compactMap { fetchExisting($0) }
    }
    
    public func fetchExisting<Object, S>(_ objectIds: S) -> [Object] where Object : CKObject, S : Sequence, S.Element == CKObjectId {
        objectIds.compactMap { fetchExisting(with: $0) }
    }
    
    public func fetchIds<Object>(_ request: CKFetch<Object>) throws -> [CKObjectId] where Object : CKObject {
        let fetchRequest = request.format(to: CKObjectId.self)
        
        var objectIds: [CKObjectId] = []
        var error: NSError?
        
        performAndWait {
            do {
                objectIds = try fetch(fetchRequest)
            } catch let fetchError as NSError {
                error = fetchError
            }
        }
        
        if let fetchError = error {
            throw fetchError
        } else {
            return objectIds
        }
    }
    
    public func query<Object>(_ request: CKFetch<Object>) throws -> [NSDictionary] where Object : CKObject {
        let fetchRequest = request.format(to: NSDictionary.self)
        
        var objectIds: [NSDictionary] = []
        var error: NSError?
        
        performAndWait {
            do {
                objectIds = try fetch(fetchRequest)
            } catch let fetchError as NSError {
                error = fetchError
            }
        }
        
        if let fetchError = error {
            throw fetchError
        } else {
            return objectIds
        }
    }
    
    public func count<Object>(_ request: CKFetch<Object>) throws -> Int where Object : CKObject {
        let fetchRequest = request.format(to: NSNumber.self)
        
        var count: Int = 0
        var error: NSError?
        
        performAndWait {
            do {
                count = try self.count(for: fetchRequest)
            } catch let fetchError as NSError {
                error = fetchError
            }
        }
        
        if let fetchError = error {
            throw fetchError
        } else if count == NSNotFound {
            let error = NSError(domain: NSCocoaErrorDomain, code: NSNotFound, userInfo: nil)
            throw error
        } else {
            return count
        }
    }
    
    public var unsafeContext: CKContext {
        self
    }
}

extension CKContext {
    
    func batchUpdate<Object>(_ request: CKBatchUpdate<Object>, resultType: CKBatchUpdateResultType) throws -> CKBatchUpdateResult where Object : CKObject {
        
        let batchDeleteRequest = request.batchUpdateRequest(in: self)
        batchDeleteRequest.resultType = resultType
        
        var result: CKBatchUpdateResult?
        var error: NSError?
        
        performAndWait {
            do {
                result = try execute(batchDeleteRequest) as? CKBatchUpdateResult
                
            } catch let fetchError as NSError {
                error = fetchError
            }
        }
        
        if let updateResult = result {
            return updateResult
        } else if let fetchError = error {
            throw fetchError
        } else {
            throw NSError(domain: CKError.errorDomain, code: 101, userInfo: nil)
        }
    }
}

extension CKContext {
    
    func delete<Object>(_ request: CKFetch<Object>) throws where Object : CKObject {
        let fetchRequest = request.format(to: Object.self)
        
        fetchRequest.resultType = .managedObjectResultType
        fetchRequest.returnsObjectsAsFaults = true
        fetchRequest.includesPropertyValues = false
        
        var error: NSError?
        
        performAndWait {
            do {
                let objects = try fetch(fetchRequest)
                objects.forEach { delete($0) }
                
            } catch let fetchError as NSError {
                error = fetchError
            }
        }
        
        if let fetchError = error {
            throw fetchError
        }
    }
    
    func batchDelete<Object>(_ request: CKFetch<Object>, resultType: CKBatchDeleteResultType) throws -> CKBatchDeleteResult where Object : CKObject {
        
        let batchDeleteRequest = CKBatchDeleteRequest(fetchRequest: request.fetchRequest)
        batchDeleteRequest.resultType = resultType
        
        shouldDeleteInaccessibleFaults = true
        
        var result: CKBatchDeleteResult?
        var error: NSError?
        
        performAndWait {
            do {
                result = try execute(batchDeleteRequest) as? CKBatchDeleteResult
                
            } catch let fetchError as NSError {
                error = fetchError
            }
        }
        
        if let deleteResult = result {
            return deleteResult
        } else if let fetchError = error {
            throw fetchError
        } else {
            throw NSError(domain: CKError.errorDomain, code: 101, userInfo: nil)
        }
    }
}

extension CKContext {

    @available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
    func batchInsert<Object: CKObject>(_ request: CKBatchInsert<Object>, resultType: CKBatchInsertResultType) throws -> CKBatchInsertResult {
        let batchInsertRequest = request.batchInsertRequest
        batchInsertRequest.resultType = resultType
        
        var result: CKBatchInsertResult?
        var error: NSError?
        
        performAndWait {
            do {
                result = try execute(batchInsertRequest) as? CKBatchInsertResult
                
            } catch let fetchError as NSError {
                error = fetchError
            }
        }
        
        if let insertResult = result {
            return insertResult
        } else if let fetchError = error {
            throw fetchError
        } else {
            throw NSError(domain: CKError.errorDomain, code: 101, userInfo: nil)
        }
    }
}

extension CKContext {
    
    func saveContextAsync(completion: @escaping (Result<Bool, NSError>) -> Void) {
        guard hasChanges else {
            completion(.success(false))
            return
        }
        
        perform {
            do {
                try self.save()
                
                if let parent = self.parent {
                    parent.saveContextAsync(completion: completion)
                } else {
                    completion(.success(true))
                }
            } catch {
                completion(.failure(error as NSError))
            }
        }
    }
    
    
    func saveContextSync() -> Result<Bool, NSError> {
        
        var result: Result<Bool, NSError> = .success(false)
        
        guard hasChanges else {
            return result
        }
        
        performAndWait {
            do {
                try self.save()
                
                if let parent = self.parent {
                    result = parent.saveContextSync()
                } else {
                    result = .success(true)
                }
            } catch {
                result = .failure(error as NSError)
            }
        }
        
        return result
    }
}
