//
//  TestCoordinators.swift
//  CoordinationTests
//
//  Created by Javier Cicchelli on 11/04/2023.
//  Copyright © 2023 Röck+Cöde. All rights reserved.
//

import Coordination
import UIKit

// MARK: - Test coordinators

class SomeCoordinator: Coordinator {
    
    // MARK: Properties
    
    var children: [Coordinator] = []
    var router: Router
    
    // MARK: Initialisers
    
    init(router: Router) {
        self.router = router
    }
    
    // MARK: Functions
    
    func present(animated: Bool, onDismiss: (() -> Void)?) {
        router.present(
            SomeViewController(),
            animated: animated,
            onDismiss: onDismiss
        )
    }

}

class SomeOtherCoordinator: Coordinator {

    // MARK: Properties
    
    var children: [Coordinator] = []
    var router: Router
    
    // MARK: Initialisers
    
    init(router: Router) {
        self.router = router
    }
    
    // MARK: Functions
    
    func present(animated: Bool, onDismiss: (() -> Void)?) {
        router.present(
            SomeOtherViewController(),
            animated: animated,
            onDismiss: onDismiss
        )
    }

}

// MARK: - SpyRouter

class SpyRouter: Router {
    
    // MARK: Enumerations
    
    enum State {
        case initialised
        case presented
        case dismissed
    }
    
    // MARK: Properties
    
    var state: State = .initialised
    var viewController: UIViewController?
    var animated: Bool?
    var onDismiss: OnDismissedClosure?
    
    // MARK: Functions
    
    func present(
        _ viewController: UIViewController,
        animated: Bool,
        onDismiss: OnDismissedClosure?
    ) {
        self.viewController = viewController
        self.animated = animated
        self.onDismiss = onDismiss
        self.state = .presented
    }
    
    func dismiss(animated: Bool) {
        self.animated = animated
        self.state = .dismissed
    }
    
}

// MARK: - Test view controllers

class SomeViewController: UIViewController {}
class SomeOtherViewController: UIViewController {}
