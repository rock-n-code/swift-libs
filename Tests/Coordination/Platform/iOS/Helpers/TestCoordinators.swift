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
