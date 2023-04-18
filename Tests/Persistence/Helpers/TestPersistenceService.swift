//===----------------------------------------------------------------------===//
//
// This source file is part of the SwiftLibs open source project
//
// Copyright (c) 2023 Röck+Cöde VoF. and the SwiftLibs project authors
// Licensed under the EUPL 1.2 or later.
//
// See LICENSE.txt for license information
// See CONTRIBUTORS.txt for the list of SwiftLibs project authors
//
//===----------------------------------------------------------------------===//

import CoreData
import Persistence

struct TestPersistenceService {
    
    // MARK: Properties
    
    static let shared = TestPersistenceService()
    
    private let container: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        container.viewContext
    }
    
    // MARK: Initialisers
    
    init() {
        guard
            let modelURL = Bundle.module.url(forResource: .Model.name, withExtension: .Model.extension),
            let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL)
        else {
            fatalError("Could not load the Core Data model from the module.")
        }
        
        self.container = .init(
            name: .Model.name,
            managedObjectModel: managedObjectModel
        )
        
        setContainer()
    }

}

// MARK: - Service

extension TestPersistenceService: Service {
    
    // MARK: Functions
    
    func makeTaskContext() -> NSManagedObjectContext {
        let taskContext = container.newBackgroundContext()
        
        taskContext.automaticallyMergesChangesFromParent = true
        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        return taskContext
    }
    
    func makeChildContext() -> NSManagedObjectContext {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        context.parent = container.viewContext
        context.automaticallyMergesChangesFromParent = true
        
        return context
    }
    
    func save(context: NSManagedObjectContext) throws {
        guard context.hasChanges else {
            return
        }
        
        try context.save()
    }
    
    func save(childContext context: NSManagedObjectContext) throws {
        guard context.hasChanges else {
            return
        }
        
        try context.save()
        
        guard
            let parent = context.parent,
            parent == container.viewContext
        else {
            return
        }

        try parent.performAndWait {
            try parent.save()
        }
    }
    
}

// MARK: - Helpers

private extension TestPersistenceService {
    
    // MARK: Functions
    
    func setContainer() {
        container.persistentStoreDescriptions = [
            .init(url: .bitBucket)
        ]
        
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = false
    }

}

// MARK: - String+Constants

private extension String {
    enum Model {
        static let name = "TestModel"
        static let `extension` = "momd"
    }
}
