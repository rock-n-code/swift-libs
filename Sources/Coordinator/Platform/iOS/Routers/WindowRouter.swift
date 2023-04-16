//
//  WindowRouter.swift
//  Coordinator
//
//  Created by Javier Cicchelli on 11/04/2023.
//  Copyright © 2023 Röck+Cöde. All rights reserved.
//

import UIKit

/// This class is responsible for populating the window of an application.
public class WindowRouter: Router {
    
    // MARK: Properties
    
    /// The window to set manually with a `UIViewController` view controller instance.
    private let window: UIWindow?
    
    // MARK: Initialisers
    
    /// Initialise this router.
    /// - Parameter window: A `UIWindow` window instance to be set manually.
    public init(window: UIWindow?) {
        self.window = window
    }
    
    // MARK: Functions

    public func present(
        _ viewController: UIViewController,
        animated: Bool,
        onDismiss: OnDismissedClosure?
    ) {
        window?.rootViewController = viewController

        window?.makeKeyAndVisible()
    }
    
    public func dismiss(animated: Bool) {
        // Nothing to do here...
    }
    
}
