//
//  CMRCECoreDataManager.swift
//  CMRCEContentStackDemo
//
//  Created by Parvind Bhatt on 22/10/22.
//

import Foundation
import CoreData

typealias ActionCompletion = (Result<Bool, Error>) -> Void
typealias ActionCompletionWithData<T: EntityCodable> = (Result<[T], Error>) -> Void
typealias PerformOperationResult = (NSManagedObjectContext) -> Result<Any, Error>
typealias PerformCompletionResult = (Result<Any, Error>) -> Void

/// RequestParameters is a EntityCodable  generic model responsible for providing entity type and other parameters.
/// - Parameters:
///   - entityClass: type of core data  Entity on which we preform fetch request
///   - sortByKey: attribute type by which we sort the fetched data
///   - sortByAscending: if true , fetched data will be sorted by ascending order if false then desceding order.
///   - predicate: specifies how data should be fetched or filtered
struct WFCCoreDataRequestParameters<T: EntityCodable> {
    var entityClass: T.Type
    var sortByKey: String?
    var sortByAscending: Bool = true
    var predicate: NSPredicate?
}

class WFCPersistentContainer: NSPersistentContainer {}

enum WFCCoreDataError: Error {
    case noChangesInContext
    case generic
    case entityNameNotValid
    case modelURLNotFound(forResourceName: String)
    case modelLoadingFailed(forURL: URL)
}

final class WFCCoreDataManager: NSObject {

    static let sharedInstance = WFCCoreDataManager()
    private static let managedObjectModelName = "WFCModel"
    lazy private var persistentContainer: WFCPersistentContainer = {
        return self.container()
    }()

    /// MainContext:-  context associated with the main queue.
    private(set) lazy var mainManagedObjectContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    /// Background Context has concurrency PrivateQueueConcurrencyType
    /// This will work in background and our UI in main thread will not get stuck
    var writeContext: NSManagedObjectContext {
        let newContext: NSManagedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        newContext.parent = mainManagedObjectContext
        newContext.mergePolicy = NSMergePolicy(merge: .mergeByPropertyObjectTrumpMergePolicyType)
        return newContext
    }
    
    private(set) lazy var backgroundContext: NSManagedObjectContext = persistentContainer.newBackgroundContext()

    private override init() {
        super.init()
    }
}

// MARK: - Core Data stack

extension WFCCoreDataManager {
    
    // MARK: - Core Data Saving support
    fileprivate func container() -> WFCPersistentContainer {
        let tempContainer = NSPersistentContainer(name: WFCCoreDataManager.managedObjectModelName)
        guard let modelURL = Bundle.main.url(forResource:WFCCoreDataManager.managedObjectModelName, withExtension: "momd") else { return tempContainer as! WFCPersistentContainer }
           guard let model = NSManagedObjectModel(contentsOf: modelURL) else { return tempContainer as! WFCPersistentContainer }
        let container = WFCPersistentContainer(name:WFCCoreDataManager.managedObjectModelName,managedObjectModel:model)
           container.loadPersistentStores(completionHandler: { (storeDescription, error) in
               if let error = error as NSError? {
                   debugPrint("Unresolved error \(error), \(error.userInfo)")
               }
           })
        return container
    }

    
    func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
        self.persistentContainer.performBackgroundTask { (context) in
            block(context)
        }
    }
    
    func saveMainContext(completion: ActionCompletion? = nil) {
        guard mainManagedObjectContext.hasChanges else {
            completion?(.success(true))
            return
        }
        saveMainContextChanges(completion: completion)
    }

    private func saveMainContextChanges(completion: ActionCompletion? = nil) {
        mainManagedObjectContext.mergePolicy = NSMergePolicy(merge: .mergeByPropertyObjectTrumpMergePolicyType)
        var reqError: NSError?
        mainManagedObjectContext.performAndWait { [weak self] in
            guard let self = self else { return }
            do {
                try self.mainManagedObjectContext.save()
            } catch let error as NSError {
                reqError = error
            }
        }
        if let error = reqError {
            completion?(.failure(error))
        } else {
            completion?(.success(true))
        }
    }
}

extension WFCCoreDataManager {
    
    func retrieve<T: EntityCodable>(request: WFCCoreDataRequestParameters<T>,
                                    context: NSManagedObjectContext,
                                    completion: ActionCompletionWithData<T>?) {
        guard let entityName = request.entityClass.entity().name,
              !entityName.isEmpty
        else {
            completion?(.failure(WFCCoreDataError.entityNameNotValid))
            return
        }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        if let predicate = request.predicate {
            fetchRequest.predicate = predicate
        }
        // fetchRequest.propertiesToFetch
        if let sortByKey = request.sortByKey {
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: sortByKey, ascending: request.sortByAscending)]
        }
        do {
            guard let data = try context.fetch(fetchRequest) as? [T] else {
                completion?(.failure(WFCCoreDataError.generic))
                return
            }
            completion?(.success(data))
        } catch {
            completion?(.failure(error))
        }
    }
    
    private static func staticFetch<T>(_ context: NSManagedObjectContext,
                                       _ request: NSFetchRequest<T>,
                                       map: ([T]) -> Any?) throws -> Any? where T: NSFetchRequestResult {
        var someError: Error?
        var result: Any?
        context.performAndWait {
            var fetchResult: [T]?
            do {
                fetchResult = try context.fetch(request)
            } catch {
                someError = error
            }
            guard let fetchResult = fetchResult else {
                return
            }

            result = map(fetchResult)
        }
        if let someError = someError {
            throw someError
        }
        return result
    }

    private static func staticPerformAndSave(_ context: NSManagedObjectContext,
                                             operation: @escaping PerformOperationResult,
                                             completion: @escaping PerformCompletionResult) {
        context.perform {
            let operationResult = operation(context)
            switch operationResult {
            case .failure:
                context.rollback()
                completion(operationResult)
            case .success:
                do {
                    try staticBackgroundSave(context)
                    completion(operationResult)
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }

    private static func staticBackgroundSave(_ context: NSManagedObjectContext) throws {
        do {
            try context.save()
        } catch {
            context.rollback()
            throw error
        }
    }
    
}

extension WFCCoreDataManager {
    func fetch<T>(_ request: NSFetchRequest<T>, map: ([T]) -> Any?) throws -> Any? where T: NSFetchRequestResult {
        try WFCCoreDataManager.staticFetch(backgroundContext, request, map: map)
    }

    func performAndSave(operation: @escaping PerformOperationResult, completion: @escaping PerformCompletionResult) {
        WFCCoreDataManager.staticPerformAndSave(backgroundContext, operation: operation, completion: completion)
    }
}
