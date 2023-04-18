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

import UIKit

/// This class is responsible for pushing view controllers into a navigation controller, as it is a concrete implementation of the `Router` protocol.
public class PushNavigationRouter: BaseNavigationRouter {
    
    // MARK: Properties
    
    /// A root view controller coming in from the navigation controller, if any.
    private let rootViewController: UIViewController?
    
    // MARK: Initialisers
    
    /// Initialise this router.
    /// - Parameters:
    ///   - navigationController: A `UINavigationController` navigation controller instance to use in this router.
    ///   - rootViewController: A `UIViewController` view controller instance to define as a root view controller of the navigation controller.
    /// - Note This initialiser added the `rootViewController` parameter although it is not really needed to differentiate itself from the `.init(navigationController:)` implemented for the `BaseNavigationRouter` base class.
    public init(
        navigationController: UINavigationController,
        rootViewController: UIViewController? = nil
    ) {
        self.rootViewController = navigationController.viewControllers.first ?? rootViewController

        super.init(navigationController: navigationController)
    }

}

// MARK: - Router

extension PushNavigationRouter: Router {
    
    // MARK: Functions
    
    public func present(
        _ viewController: UIViewController,
        animated: Bool,
        onDismiss: OnDismissedClosure?
    ) {
        onDismissForViewController[viewController] = onDismiss
        
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    public func dismiss(animated: Bool) {
        guard let rootViewController else {
            navigationController.popViewController(animated: animated)
            return
        }
        
        performOnDismissed(for: rootViewController)
        
        navigationController.popToViewController(rootViewController, animated: animated)
    }
    
}
