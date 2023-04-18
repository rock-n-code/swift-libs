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
import Persistence
import XCTest

final class FetcherTests: XCTestCase {

    // MARK: Properties
    
    private lazy var persistence: TestPersistenceService = .shared
    private lazy var fetcher: Fetcher<TestEntity> = .init(
        fetchRequest: .allTestEntities(),
        managedObjectContext: persistence.viewContext
    )
    
    // MARK: Setup

    override func tearDownWithError() throws {
        try persistence.clean()
    }
    
    // MARK: Number of sections tests
    
    func test_numberOfSections_whenModelIsEmpty() throws {
        // GIVEN
        try fetcher.fetch()
        
        // WHEN
        let numberOfSections = fetcher.numberOfSections
        
        // THEN
        XCTAssertEqual(numberOfSections, 1)
    }
    
    func test_numberOfSections_whenModelIsFilled() throws {
        // GIVEN
        let context = persistence.makeChildContext()
        let _ = [
            TestEntity(context: context),
            TestEntity(context: context),
            TestEntity(context: context)
        ]
        
        try persistence.save(childContext: context)
        try fetcher.fetch()
        
        // WHEN
        let numberOfSections = fetcher.numberOfSections
        
        // THEN
        XCTAssertEqual(numberOfSections, 1)
    }
    
    func test_numberOfSections_whenNoFetch() async throws {
        // GIVEN
        // WHEN
        let numberOfSections = fetcher.numberOfSections
        
        // THEN
        XCTAssertEqual(numberOfSections, 0)
    }
    
    // MARK: Number of objects tests
    
    func test_numberOfObjects_inFirstSection_whenModelIsEmpty() throws {
        // GIVEN
        try fetcher.fetch()

        // WHEN
        let section = fetcher.numberOfSections - 1
        let numberOfObjects = try fetcher.numberOfObjects(in: section)
        
        // THEN
        XCTAssertEqual(numberOfObjects, 0)
    }
    
    func test_numberOfObjects_inFirstSection_whenModelIsFilled() throws {
        // GIVEN
        let context = persistence.makeChildContext()
        let entities = [
            TestEntity(context: context),
            TestEntity(context: context),
            TestEntity(context: context)
        ]
        
        try persistence.save(childContext: context)
        try fetcher.fetch()

        // WHEN
        let section = fetcher.numberOfSections - 1
        let numberOfObjects = try fetcher.numberOfObjects(in: section)
        
        // THEN
        XCTAssertEqual(numberOfObjects, entities.count)
    }
    
    func test_numberOfObjects_inNonExistingSection() throws {
        // GIVEN
        try fetcher.fetch()

        // WHEN & THEN
        let section = fetcher.numberOfSections
        
        XCTAssertThrowsError(try fetcher.numberOfObjects(in: section)) { error in
            XCTAssertEqual(error as? FetcherError, .sectionNotFound)
        }
    }
    
    func test_numberOfObjects_whenNoFetch() throws {
        // GIVEN
        // WHEN & THEN
        XCTAssertThrowsError(try fetcher.numberOfObjects(in: 1)) { error in
            XCTAssertEqual(error as? FetcherError, .fetchNotExecuted)
        }
    }
    
    // MARK: Object at tests
    
    func test_objectAt_whenModelIsEmpty() throws {
        // GIVEN
        try fetcher.fetch()

        // WHEN & THEN
        let _ = IndexPath(
            item: 0,
            section: fetcher.numberOfSections - 1
        )
        
        // TODO: Need to find out how to handle NSInvalidArgumentException in this test.
        // let object = try fetcher.object(at: indexPath)
    }
    
    func test_objectAt_whenModelIsFilled() throws {
        // GIVEN
        let context = persistence.makeChildContext()
        let entities = [TestEntity(context: context)]
        
        try persistence.save(childContext: context)
        try fetcher.fetch()

        // WHEN & THEN
        let indexPath = IndexPath(
            item: entities.count - 1,
            section: fetcher.numberOfSections - 1
        )
        
        let object = try fetcher.object(at: indexPath)
        
        XCTAssertNotNil(object)
    }
    
    func test_objectAt_withOutOfBoundsIndexPath() throws {
        // GIVEN
        let context = persistence.makeChildContext()
        let entities = [TestEntity(context: context)]
        
        try persistence.save(childContext: context)
        try fetcher.fetch()

        // WHEN & THEN
        let _ = IndexPath(
            item: entities.count,
            section: fetcher.numberOfSections
        )

        // TODO: Need to find out how to handle NSInvalidArgumentException in this test.
        // let object = try fetcher.object(at: indexPath)
    }

    func test_objectAt_whenNoFetch() throws {
        // GIVEN
        // WHEN & THEN
        let indexPath = IndexPath(
            item: 0,
            section: 0
        )
        
        XCTAssertThrowsError(try fetcher.object(at: indexPath)) { error in
            XCTAssertEqual(error as? FetcherError, .fetchNotExecuted)
        }
    }
    
    // MARK: Did change publisher tests
    
    func test_didChangePublisher_whenModelIsEmpty() throws {
        let expectation = self.expectation(description: "didChangePublisher when model is filled.")
        
        var result: [Change]?
        
        // GIVEN
        let cancellable = fetcher
            .didChangePublisher
            .sink(receiveValue: { value in
                result = value
                
                expectation.fulfill()
            })

        // WHEN
        try fetcher.fetch()

        // THEN
        let waiter = XCTWaiter.wait(for: [expectation], timeout: 1.0)
        
        guard waiter == .timedOut else {
            XCTFail("Waiter expected to time out.")
            return
        }
        
        cancellable.cancel()
        
        XCTAssertNil(result)
    }
    
    func test_didChangePublisher_whenModelIsFilled() throws {
        let expectation = self.expectation(description: "didChangePublisher when model is filled.")
        
        var result: [Change]?
        
        // GIVEN
        let context = persistence.makeChildContext()
        let _ = [
            TestEntity(context: context),
            TestEntity(context: context),
            TestEntity(context: context)
        ]
        
        let cancellable = fetcher
            .didChangePublisher
            .sink(receiveValue: { value in
                result = value
                
                expectation.fulfill()
            })

        // WHEN
        try persistence.save(childContext: context)
        try fetcher.fetch()

        // THEN
        let waiter = XCTWaiter.wait(for: [expectation], timeout: 1.0)
        
        guard waiter == .timedOut else {
            XCTFail("Waiter expected to time out.")
            return
        }
        
        cancellable.cancel()
        
        XCTAssertNil(result)
    }
    
    func test_didChangePublisher_whenModelIsUpdated() throws {
        let expectation = self.expectation(description: "didChangePublisher when model is updated.")
        
        var result: [Change]?
        
        // GIVEN
        let context = persistence.makeChildContext()
        let entities = [
            TestEntity(context: context),
            TestEntity(context: context),
            TestEntity(context: context)
        ]
        
        let cancellable = fetcher
            .didChangePublisher
            .sink(receiveValue: { value in
                result = value
                
                expectation.fulfill()
            })
        
        // WHEN
        try fetcher.fetch()
        try persistence.save(childContext: context)

        // THEN
        waitForExpectations(timeout: 1.0)
        
        cancellable.cancel()
        
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.count, entities.count)
        XCTAssertEqual(result, [
            .object(.inserted(at: .init(item: 2, section: 0))),
            .object(.inserted(at: .init(item: 1, section: 0))),
            .object(.inserted(at: .init(item: 0, section: 0))),
        ])
    }
    
}

// MARK: - TestPersistenceService+Functions

private extension TestPersistenceService {
    
    // MARK: Functions
    
    func clean() throws {
        let context = makeChildContext()
        
        try context.performAndWait {
            try context
                .fetch(.allTestEntities())
                .forEach(context.delete)
        }
        
        try save(childContext: context)
    }

}
