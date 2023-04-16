//
//  CoordinatorTests.swift
//  CoordinationTests
//
//  Created by Javier Cicchelli on 11/04/2023.
//  Copyright © 2023 Röck+Cöde. All rights reserved.
//

import Coordination
import UIKit
import XCTest

final class CoordinatorTests: XCTestCase {

    // MARK: Properties
    
    private var router: SpyRouter!
    private var coordinator: Coordinator!
    
    // MARK: Tests
    
    func test_present_withoutOnDismissClosure() {
        // Executing this test on the main thread is required as a `UIViewController` instance in being initialised here.
        DispatchQueue.main.async {
            // GIVEN
            self.router = SpyRouter()
            self.coordinator = SomeCoordinator(router: self.router)
            
            
            // WHEN
            self.coordinator.present(animated: false, onDismiss: nil)
            
            // THEN
            XCTAssertTrue(self.coordinator.children.isEmpty)
            XCTAssertEqual(self.router.state, .presented)
            XCTAssertTrue(self.router.viewController is SomeViewController)
            XCTAssertFalse(self.router.animated ?? true)
            XCTAssertNil(self.router.onDismiss)
        }
    }
    
    func test_present_withOnDismissClosure() {
        // Executing this test on the main thread is required as a `UIViewController` instance in being initialised here.
        DispatchQueue.main.async {
            // GIVEN
            self.router = SpyRouter()
            self.coordinator = SomeOtherCoordinator(router: self.router)
            
            // WHEN
            self.coordinator.present(animated: true) {}
            
            // THEN
            XCTAssertTrue(self.coordinator.children.isEmpty)
            XCTAssertEqual(self.router.state, .presented)
            XCTAssertTrue(self.router.viewController is SomeOtherViewController)
            XCTAssertTrue(self.router.animated ?? false)
            XCTAssertNotNil(self.router.onDismiss)
        }
    }
    
    func test_presentChild_withoutOnDismissClosure() {
        // Executing this test on the main thread is required as a `UIViewController` instance in being initialised here.
        DispatchQueue.main.async {
            // GIVEN
            self.router = SpyRouter()
            self.coordinator = SomeCoordinator(router: self.router)
            
            let child = SomeOtherCoordinator(router: self.router)
            
            // WHEN
            self.coordinator.present(child: child, animated: false)
            
            // THEN
            XCTAssertFalse(self.coordinator.children.isEmpty)
            XCTAssertEqual(self.coordinator.children.count, 1)
            XCTAssertEqual(self.router.state, .presented)
            XCTAssertTrue(self.router.viewController is SomeOtherViewController)
            XCTAssertFalse(self.router.animated ?? true)
            XCTAssertNil(self.router.onDismiss)
        }
    }
    
    func test_presentChild_withOnDismissClosure() {
        // Executing this test on the main thread is required as a `UIViewController` instance in being initialised here.
        DispatchQueue.main.async {
            // GIVEN
            self.router = SpyRouter()
            self.coordinator = SomeOtherCoordinator(router: self.router)
            
            let child = SomeCoordinator(router: self.router)
            
            // WHEN
            self.coordinator.present(child: child, animated: true) {}
            
            // THEN
            XCTAssertFalse(self.coordinator.children.isEmpty)
            XCTAssertEqual(self.coordinator.children.count, 1)
            XCTAssertEqual(self.router.state, .presented)
            XCTAssertTrue(self.router.viewController is SomeViewController)
            XCTAssertTrue(self.router.animated ?? false)
            XCTAssertNotNil(self.router.onDismiss)
        }
    }
    
    func test_dismiss_notAnimated() {
        // GIVEN
        router = SpyRouter()
        coordinator = SomeOtherCoordinator(router: router)
        
        // WHEN
        coordinator.dismiss(animated: false)
        
        // THEN
        XCTAssertTrue(coordinator.children.isEmpty)
        XCTAssertEqual(router.state, .dismissed)
        XCTAssertNil(router.viewController)
        XCTAssertFalse(router.animated ?? true)
        XCTAssertNil(router.onDismiss)
    }
    
    func test_dismiss_animated() {
        // GIVEN
        router = SpyRouter()
        coordinator = SomeOtherCoordinator(router: router)
        
        // WHEN
        coordinator.dismiss(animated: true)
        
        // THEN
        XCTAssertTrue(coordinator.children.isEmpty)
        XCTAssertEqual(router.state, .dismissed)
        XCTAssertNil(router.viewController)
        XCTAssertTrue(router.animated ?? false)
        XCTAssertNil(router.onDismiss)
    }

}
