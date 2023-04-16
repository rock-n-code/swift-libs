//
//  ModalNavigationRouter.swift
//  Coordination
//
//  Created by Javier Cicchelli on 11/04/2023.
//  Copyright © 2023 Röck+Cöde. All rights reserved.
//

import UIKit

/// This class is responsible for showing view controllers modally, as it is a concrete implementation of the `Router` protocol.
public class ModalNavigationRouter: BaseNavigationRouter {
    
    // MARK: Properties
    
    /// The parent view controller from where this router is being called from.
    public unowned let parentViewController: UIViewController

    // MARK: Initialisers
    
    /// Initialise this router.
    /// - Parameter parentViewController: A `UIViewController` view controller instance from where this router is originated.
    public init(parentViewController: UIViewController) {
        self.parentViewController = parentViewController
        
        super.init(navigationController: .init())
    }
    
}

extension ModalNavigationRouter: Router {
    public func present(
        _ viewController: UIViewController,
        animated: Bool,
        onDismiss: OnDismissedClosure?
    ) {
        onDismissForViewController[viewController] = onDismiss
        
        if navigationController.viewControllers.isEmpty {
            presentModally(viewController, animated: animated)
        } else {
            navigationController.pushViewController(viewController, animated: animated)
        }
    }
    
    public func dismiss(animated: Bool) {
        guard let firstViewController = navigationController.viewControllers.first else {
            return
        }
        
        performOnDismissed(for: firstViewController)
        
        parentViewController.dismiss(animated: animated)
    }
    
}

// MARK: - Helpers

private extension ModalNavigationRouter {
    
    // MARK: Functions
    
    func presentModally(_ viewController: UIViewController, animated: Bool) {
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Cancel",
            style: .plain,
            target: self,
            action: #selector(onCancelPressed)
        )
        
        navigationController.setViewControllers([viewController], animated: false)
        
        parentViewController.present(navigationController, animated: animated)
    }
    
    @objc func onCancelPressed() {
        guard let firstViewController = navigationController.viewControllers.first else {
            return
        }
        
        performOnDismissed(for: firstViewController)
        dismiss(animated: true)
    }
    
}
