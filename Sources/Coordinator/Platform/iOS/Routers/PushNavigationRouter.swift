//
//  PushNavigationRouter.swift
//  Coordinator
//
//  Created by Javier Cicchelli on 11/04/2023.
//  Copyright © 2023 Röck+Cöde. All rights reserved.
//

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
