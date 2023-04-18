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

import Combine
import CoreData

/// This class fetches objects from a given managed object context and it notifies of changes in the object fetched if any.
public class Fetcher<Model: NSManagedObject>: NSObject, NSFetchedResultsControllerDelegate {
    
    // MARK: Properties
    
    /// The publisher that emits the changes detected to the Location entities in a given object context.
    public let didChangePublisher = PassthroughSubject<[Change], Never>()

    private let fetchedResultsController: NSFetchedResultsController<Model>
    
    /// The number of sections in the data.
    public var numberOfSections: Int {
        fetchedResultsController.sections?.count ?? 0
    }
    
    private var changesToNotify: [Change] = []

    // MARK: Initialisers
    
    /// Initialises the fetcher give the given parameters.
    /// - Parameters:
    ///   - fetchRequest: The fetch request to use to get the objects.
    ///   - managedObjectContext: The managed object context against the fetch request is executed.
    ///   - sectionNameKeyPath: A key path on result objects that returns the section name.
    ///   - cacheName: The name of the cache file the receiver should use.
    public init(
        fetchRequest: NSFetchRequest<Model>,
        managedObjectContext: NSManagedObjectContext,
        sectionNameKeyPath: String? = nil,
        cacheName: String? = nil
    ) {
        self.fetchedResultsController = .init(
            fetchRequest: fetchRequest,
            managedObjectContext: managedObjectContext,
            sectionNameKeyPath: sectionNameKeyPath,
            cacheName: cacheName
        )
        
        super.init()
        
        self.fetchedResultsController.delegate = self
    }
    
    // MARK: Functions
    
    /// Perform the fetching.
    public func fetch() throws {
        try fetchedResultsController.performFetch()
    }
    
    /// Retrieve the number of objects in a given section number.
    /// - Parameter section: The section number to inquiry about.
    /// - Returns: A number of objects in the given section number.
    public func numberOfObjects(in section: Int) throws -> Int {
        guard let sections = fetchedResultsController.sections else {
            throw FetcherError.fetchNotExecuted
        }
        guard sections.endIndex > section else {
            throw FetcherError.sectionNotFound
        }

        return sections[section].numberOfObjects
    }
    
    /// Retrieve an object out of a given index path.
    /// - Parameter indexPath: The index path to use to retrieve an object.
    /// - Returns: A `NSManagedObject` entity positioned in the given index path.
    public func object(at indexPath: IndexPath) throws -> Model {
        guard fetchedResultsController.sections != nil else {
            throw FetcherError.fetchNotExecuted
        }

        return fetchedResultsController.object(at: indexPath)
    }

    // MARK: NSFetchedResultsControllerDelegate
    
    public func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        changesToNotify.removeAll()
    }
    
    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        didChangePublisher.send(changesToNotify)
    }
    
    public func controller(
        _ controller: NSFetchedResultsController<NSFetchRequestResult>,
        didChange sectionInfo: NSFetchedResultsSectionInfo,
        atSectionIndex sectionIndex: Int,
        for type: NSFetchedResultsChangeType
    ) {
        if type == .insert {
            changesToNotify.append(.section(.inserted(sectionIndex)))
        } else if type == .delete {
            changesToNotify.append(.section(.deleted(sectionIndex)))
        }
    }
    
    public func controller(
        _ controller: NSFetchedResultsController<NSFetchRequestResult>,
        didChange anObject: Any,
        at indexPath: IndexPath?,
        for type: NSFetchedResultsChangeType,
        newIndexPath: IndexPath?
    ) {
        switch type {
        case .insert:
            guard let newIndexPath else { return }
            
            changesToNotify.append(.object(.inserted(at: newIndexPath)))
        case .delete:
            guard let indexPath else { return }
            
            changesToNotify.append(.object(.deleted(from: indexPath)))
        case .move:
            guard let indexPath, let newIndexPath else { return }
            
            changesToNotify.append(.object(.moved(from: indexPath, to: newIndexPath)))
        case .update:
            guard let indexPath else { return }
            
            changesToNotify.append(.object(.updated(at: indexPath)))
        default:
            break
        }
    }

}

// MARK: - Errors

public enum FetcherError: Error {
    case fetchNotExecuted
    case sectionNotFound
}

// MARK: - Enumerations

public enum Change: Hashable {
    public enum SectionUpdate: Hashable {
        case inserted(Int)
        case deleted(Int)
    }
    
    public enum ObjectUpdate: Hashable {
        case inserted(at: IndexPath)
        case deleted(from: IndexPath)
        case updated(at: IndexPath)
        case moved(from: IndexPath, to: IndexPath)
    }
    
    case section(SectionUpdate)
    case object(ObjectUpdate)
}
