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
#endif
