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

#if os(iOS)
import UIKit

/// This is a base class for the `NavigationRouter` concrete router implementations.
public class BaseNavigationRouter: NSObject {
    
    // MARK: Properties
    
    /// A navigation controller to use within this concrete router.
    var navigationController: UINavigationController
    
    /// Dictionary that persist `onDismiss` closure for its respective view controllers until one of the later is dismissed.
    var onDismissForViewController: [UIViewController: Router.OnDismissedClosure] = [:]
    
    // MARK: Initialisers
    
    /// Initialise this router.
    /// - Parameter navigationController: A `UINavigationController` navigation controller instance to use in this router.
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
        super.init()
        
        self.navigationController.delegate = self
    }
    
    // MARK: Functions
    
    /// Executes the `onDismiss` closure for a given view controller.
    /// - Parameter viewController: A `UIViewController` view controller instance for which the on dismiss closure will be executed.
    func performOnDismissed(for viewController: UIViewController) {
        guard let onDismiss = onDismissForViewController[viewController] else {
            return
        }
        
        onDismiss()
        
        onDismissForViewController[viewController] = nil
    }
    
}

// MARK: - UINavigationControllerDelegate

extension BaseNavigationRouter: UINavigationControllerDelegate {
    
    // MARK: Functions
    
    public func navigationController(
        _ navigationController: UINavigationController,
        didShow viewController: UIViewController,
        animated: Bool
    ) {
        guard let dismissedViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        
        performOnDismissed(for: dismissedViewController)
    }

}
#endif
